select datediff(day,convert(char(10),getdate(),103),convert(char(10),getdate(),103))
SELECT PEDIDO,DATA_RECEBIMENTO,datediff(day,DATA_RECEBIMENTO,getdate()) FROM VENDAS
WHERE datediff(day,DATA_RECEBIMENTO,getdate())>=4



USE [DRVAREJO]
GO
/****** Object:  Trigger [dbo].[LDR_TU_VENDAS]    Script Date: 08/04/2014 17:27:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER trigger [dbo].[LDR_TU_VENDAS] on [dbo].[VENDAS]
  for UPDATE NOT FOR REPLICATION
  as
-- 17/08/2007 - SERGIO		 - RETIRAR / ALTERAR TRATAMENTO DA FUNCAO SYSTEM_USER
/* UPDATE trigger on VENDAS */
/* default body for LXU_VENDAS */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPEDIDO char(12),
           @delPEDIDO char(12),
           @errno   int,
           @desconto int,
           @porc_desconto int,
           @uf      char(2),
           @natureza_saida char(7),
           @cod_cliente varchar(10),
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  
  select @insPEDIDO = PEDIDO from inserted

/* PRODUTOS_PERIODOS_ENTREGAS R/428 VENDAS ON CHILD UPDATE RESTRICT */
  if
    update(NUMERO_ENTREGA) or
    update(PERIODO_PCP)
  begin
    select @nullcnt = 0

    select @validcnt = count(*)
    from inserted,FATURAMENTO_PROD
    where inserted.PEDIDO = FATURAMENTO_PROD.PEDIDO

    if @validcnt >= @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #VENDAS #porque existe #FATURAMENTO_PROD#.'
      goto error
    end
  end
  
  if
    update(APROVACAO)
  begin
    select @nullcnt = 0
    select @delPEDIDO = inserted.PEDIDO
    from inserted,COTA_LIMITE_PERFAT, VENDAS, deleted
    where inserted.PEDIDO = VENDAS.PEDIDO 
          AND COTA_LIMITE_PERFAT.PERIODO_PCP=VENDAS.PERIODO_PCP 
          AND COTA_LIMITE_PERFAT.NUMERO_ENTREGA = VENDAS.NUMERO_ENTREGA
          AND deleted.PEDIDO=VENDAS.PEDIDO
          AND deleted.aprovacao IN ('R','E','N')
          AND COTA_LIMITE_PERFAT.FECHADO = 1 AND (datediff(day,vendas.DATA_RECEBIMENTO,getdate())>4) 
    
    select @validcnt = count(*)
    from inserted,COTA_LIMITE_PERFAT, VENDAS, deleted
    where inserted.PEDIDO = VENDAS.PEDIDO 
          AND COTA_LIMITE_PERFAT.PERIODO_PCP=VENDAS.PERIODO_PCP 
          AND COTA_LIMITE_PERFAT.NUMERO_ENTREGA = VENDAS.NUMERO_ENTREGA
          AND deleted.PEDIDO=VENDAS.PEDIDO
          AND deleted.aprovacao IN ('R','E','N')
          AND COTA_LIMITE_PERFAT.FECHADO = 1 AND  (datediff(day,vendas.DATA_RECEBIMENTO,getdate())>4) 

    if @validcnt >= @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #VENDAS #porque #PERFAT para o pedido '+@delPEDIDO+' está fechado, informe ao comercial.'
      goto error
    end
  end
  
  /* VALIDAÇÃO CRIADA PARA FORÇA ATUALIZAÇÃO DOS DADOS DO CLIENTE APÓS SEIS MESES SEM COMPRAR */
  if
    update(CONFERIDO) OR update(CONFERIDO_POR)
  begin

	SELECT @cod_cliente=CLIENTES_ATACADO.COD_CLIENTE 
	FROM CLIENTES_ATACADO, inserted
	WHERE CLIENTES_ATACADO.CLIENTE_ATACADO=inserted.CLIENTE_ATACADO AND CLIENTES_ATACADO.TIPO='REVALIDAR CADASTRO'  
 
    if @@ROWCOUNT > 0
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar #VENDAS #porque #CLIENTES_ATACADO ('+@cod_cliente+') está desatualizado, favor revalidar dados do cliente e alterar TIPO DO CLIENTE...'
      goto error
    end
  end

  
  --if
  --  update(PORC_DESCONTO) or update(DESCONTO)
  --begin 
  --  -- Pesquisa desconto suframa
  --  select @porc_desconto = count(*) from inserted 
  --  where inserted.PORC_DESCONTO <> 0 and inserted.TOT_QTDE_DEVOLVIDA=0
  --  -- Pesquisa UF que tem desconto SUFRAMA
  --  select @uf = CADASTRO_CLI_FOR.UF
  --  from inserted,CADASTRO_CLI_FOR
  --  where inserted.CLIENTE_ATACADO = CADASTRO_CLI_FOR.NOME_CLIFOR

  --  if @porc_desconto != 0 and (@uf!='RR' AND @uf!='AM' AND @uf!='AP')
  --  begin
  --    select @errno  = 30007,
  --           @errmsg = 'Impossível Atualizar #VENDAS #porque #UF não tem DESCONTO SUFRAMA, VERIFIQUE...'
  --    goto error
  --  end
  --end

  --if
  --  update(NATUREZA_SAIDA) OR update(DESCONTO)
  --begin 
  --  -- Pesquisa desconto suframa
  --  select @desconto = count(*) from inserted 
  --  where inserted.DESCONTO = 0
  --  -- Pesquisa natureza da saida 100.03 ( zona franca )
  --  select @natureza_saida = naturezas_saidas.natureza_saida
  --  from inserted,naturezas_saidas
  --  where inserted.natureza_saida = naturezas_saidas.natureza_saida
  --  -- Pesquisa UF que tem desconto SUFRAMA
  --  select @uf = CADASTRO_CLI_FOR.UF
  --  from inserted,CADASTRO_CLI_FOR
  --  where inserted.CLIENTE_ATACADO = CADASTRO_CLI_FOR.NOME_CLIFOR

  --  if @desconto != 0 and (@uf='RR' or @uf='AM' or @uf='AP') and (@natureza_saida = '100.03')
  --  begin
  --    select @errno  = 30007,
  --           @errmsg = 'Impossível Atualizar #VENDAS #porque não existe DESCONTO SUFRAMA.'
  --    goto error
  --  end
  --end
  
  -- Verificar se existe reserva do pedido
  if
    update(REPRESENTANTE) OR update(GERENTE) OR
    update(COMISSAO) OR update(COMISSAO_GERENTE) OR 
    update(CODIGO_TAB_PRECO) OR update(EMISSAO) OR update(CONDICAO_PGTO)  
  begin
    select @nullcnt = 0

    select @validcnt = count(*)
    from inserted,VENDAS_PROD_EMBALADO
    where inserted.PEDIDO = VENDAS_PROD_EMBALADO.PEDIDO

    if @validcnt > 0
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #VENDAS #porque existe #VENDAS_PROD_EMBALADO#.'
      goto error
    end
  end

  UPDATE VENDAS_PRODUTO
  SET NUMERO_ENTREGA=VENDAS.NUMERO_ENTREGA,ENTREGA=PRODUTOS_PERIODOS_ENTREGAS.ENTREGA, LIMITE_ENTREGA=PRODUTOS_PERIODOS_ENTREGAS.LIMITE
  FROM VENDAS_PRODUTO
  JOIN VENDAS ON VENDAS_PRODUTO.PEDIDO=VENDAS.PEDIDO
  JOIN PRODUTOS_PERIODOS_ENTREGAS ON PRODUTOS_PERIODOS_ENTREGAS.PERIODO_PCP=VENDAS.PERIODO_PCP 
  JOIN inserted ON inserted.PEDIDO=VENDAS.PEDIDO
  AND PRODUTOS_PERIODOS_ENTREGAS.NUMERO_ENTREGA=VENDAS.NUMERO_ENTREGA 
  AND VENDAS_PRODUTO.PEDIDO=inserted.PEDIDO AND VENDAS.TIPO<>'BONIFICACAO'

/*----------------------------------------------------------------------------------------------------------------*/
  IF UPDATE(PERIODO_PCP) OR UPDATE(NUMERO_ENTREGA)
     IF(SELECT COUNT(*) FROM COTA_LIMITE_PERFAT, inserted
		WHERE COTA_LIMITE_PERFAT.NUMERO_ENTREGA=inserted.NUMERO_ENTREGA AND
              COTA_LIMITE_PERFAT.PERIODO_PCP=inserted.PERIODO_PCP AND 
              COTA_LIMITE_PERFAT.FECHADO=1 AND inserted.TIPO NOT in('BRINDE','MOSTRUARIO','BONIFICACAO') ) > 0
        EXEC SP_PEDIDO_PERFAT_FECHADO_ENVIAR_EMAIL_PCP @insPEDIDO
/*----------------------------------------------------------------------------------------------------------------*/

  return
error:
  raiserror @errno @errmsg
  rollback transaction
end



