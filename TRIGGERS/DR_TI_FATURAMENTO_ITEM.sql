USE [DRLINGERIE]
GO
/****** Object:  Trigger [dbo].[DR_TI_FATURAMENTO_ITEM]    Script Date: 27/06/2017 09:24:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[DR_TI_FATURAMENTO_ITEM] 
on [dbo].[FATURAMENTO_ITEM] 
for INSERT NOT FOR REPLICATION 
as
/* INSERT trigger on FATURAMENTO_ITEM */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcntV int,
           @validcntM int,
           @insFILIAL varchar(25), 
           @QTDE_ITEM int, 
           @QTDE_OS int, 
           @CODIGO_ITEM char(50),
           @insNF_SAIDA char(15), 
           @insSERIE_NF char(6),
           @insITEM_IMPRESSAO char(4), 
           @insSUB_ITEM_TAMANHO int,
           @errno   int,
           @errmsg  varchar(255),
           @fantasia_cliente int,
           @retorno_ordem_servico int, 
           @tipo_faturamento varchar(25),
           @produto char(15)
           
  select @numrows = @@rowcount

  if 
     update(FILIAL)
  begin
    --- FILIAL DIGITAÇÃO
    select @insFILIAL = RTRIM(inserted.FILIAL),
           @produto = RTRIM(inserted.CODIGO_ITEM)
      from inserted,FATURAMENTO
     where 
           inserted.NF_SAIDA = FATURAMENTO.NF_SAIDA and
           inserted.SERIE_NF = FATURAMENTO.SERIE_NF and 
           inserted.FILIAL = FATURAMENTO.FILIAL and
           FATURAMENTO.NATUREZA_SAIDA = '130.01' and 
           rtrim(inserted.SERIE_NF) = '56' and 
           inserted.ORIGEM_ITEM = 'P'
  
    ---- PRODUTO VAREJO
    select @validcntV = COUNT(*)
      from inserted,FATURAMENTO
     where 
           inserted.NF_SAIDA = FATURAMENTO.NF_SAIDA and
           inserted.SERIE_NF = FATURAMENTO.SERIE_NF and 
           inserted.FILIAL = FATURAMENTO.FILIAL and
           FATURAMENTO.NATUREZA_SAIDA = '130.01' and 
           rtrim(inserted.SERIE_NF) = '56' and
           (inserted.REFERENCIA LIKE 'V%' OR inserted.CODIGO_ITEM LIKE '%V%') and
           inserted.ORIGEM_ITEM = 'P'

    ---- PRODUTO MAGAZINE
    select @validcntM = COUNT(*)
      from inserted,FATURAMENTO
     where 
           inserted.NF_SAIDA = FATURAMENTO.NF_SAIDA and
           inserted.SERIE_NF = FATURAMENTO.SERIE_NF and 
           inserted.FILIAL = FATURAMENTO.FILIAL and
           FATURAMENTO.NATUREZA_SAIDA = '130.01' and 
           rtrim(inserted.SERIE_NF) = '56' and
           (inserted.REFERENCIA NOT LIKE 'V%' OR inserted.CODIGO_ITEM NOT LIKE '%V%') and
           inserted.ORIGEM_ITEM = 'P'
           
    if @insFILIAL = 'DR VAREJO'
    begin 
		if @validcntV = 0
		begin
		  select @errno  = 30002,
				 @errmsg = 'Impossivel Incluir #FATURAMENTO_ITEM# porque o #PRODUTO# ('+RTRIM(@produto)+') não é do VAREJO'
		  goto error
		end
    end
           
    if @insFILIAL = 'D.R. LINGERIE'
    begin 
		if @validcntM = 0
		begin
		  select @errno  = 30002,
				 @errmsg = 'Impossivel Incluir #FATURAMENTO_ITEM# porque o #PRODUTO# ('+RTRIM(@produto)+') não é do MAGAZINE'
		  goto error
		end
    end
  end  
  ---- COMPLEMENTO NA DESCRIÇÃO DO ITEM PARA CLIENTE RENNER
  select @fantasia_cliente = COUNT(*)
  from  FATURAMENTO_ITEM,FATURAMENTO,CLIENTES_ATACADO,inserted
  where FATURAMENTO_ITEM.NF_SAIDA  = FATURAMENTO.NF_SAIDA and 
        FATURAMENTO_ITEM.SERIE_NF  = FATURAMENTO.SERIE_NF and
		FATURAMENTO_ITEM.FILIAL    = FATURAMENTO.FILIAL and
		FATURAMENTO.NOME_CLIFOR    = CLIENTES_ATACADO.CLIENTE_ATACADO AND
		inserted.NF_SAIDA          = FATURAMENTO_ITEM.NF_SAIDA AND 
		inserted.SERIE_NF          = FATURAMENTO_ITEM.SERIE_NF AND
		CLIENTES_ATACADO.CLIENTE_ATACADO LIKE '%RENNER%'
      
  IF @fantasia_cliente > 0
  BEGIN 
  --- ADICIONA O CÓDIGO DO CLIENTE NA DESCRIÇÃO DO ITEM
   	  UPDATE A
	  SET A.DESCRICAO_ITEM=RTRIM(B.CODIGO_BARRA)+' - '+RTRIM(A.DESCRICAO_ITEM)
	  FROM FATURAMENTO_ITEM A
	  JOIN PRODUTOS_BARRA B ON RTRIM(B.PRODUTO)+RTRIM(B.COR_PRODUTO)+RTRIM(B.GRADE)=A.CODIGO_ITEM
	  JOIN inserted C ON C.NF_SAIDA=A.NF_SAIDA AND C.SERIE_NF=A.SERIE_NF AND C.FILIAL=A.FILIAL
	  WHERE RTRIM(B.PRODUTO)+RTRIM(B.COR_PRODUTO)+RTRIM(B.GRADE) = C.CODIGO_ITEM AND 
	  A.NF_SAIDA=C.NF_SAIDA AND CODIGO_BARRA_PADRAO=0 AND B.NOME_CLIFOR LIKE '%RENNER%'
  ---
  END
  ---- FIM RENNER
  ----
  ---- COMPLEMENTO NA DESCRIÇÃO DO ITEM PARA CLIENTE MARISA
  select @fantasia_cliente = COUNT(*)
  from  FATURAMENTO_ITEM,FATURAMENTO,CLIENTES_ATACADO,inserted
  where FATURAMENTO_ITEM.NF_SAIDA  = FATURAMENTO.NF_SAIDA and 
        FATURAMENTO_ITEM.SERIE_NF  = FATURAMENTO.SERIE_NF and
		FATURAMENTO_ITEM.FILIAL    = FATURAMENTO.FILIAL and
		FATURAMENTO.NOME_CLIFOR    = CLIENTES_ATACADO.CLIENTE_ATACADO AND
		inserted.NF_SAIDA          = FATURAMENTO_ITEM.NF_SAIDA AND 
		inserted.SERIE_NF          = FATURAMENTO_ITEM.SERIE_NF AND
		CLIENTES_ATACADO.CGC_CPF LIKE '61189288%'
      
  IF @fantasia_cliente > 0
  BEGIN 
  --- ADICIONA O CÓDIGO DO CLIENTE NA DESCRIÇÃO DO ITEM
   	  UPDATE A
	  SET A.DESCRICAO_ITEM=RTRIM(B.CODIGO_BARRA)+' - '+RTRIM(A.DESCRICAO_ITEM)
	  FROM FATURAMENTO_ITEM A
	  JOIN PRODUTOS_BARRA B ON RTRIM(A.REFERENCIA_PEDIDO)+RTRIM(B.PRODUTO)+RTRIM(B.COR_PRODUTO)+RTRIM(B.GRADE)=A.CODIGO_ITEM
	  JOIN inserted C ON C.NF_SAIDA=A.NF_SAIDA AND C.SERIE_NF=A.SERIE_NF AND C.FILIAL=A.FILIAL
	  WHERE RTRIM(A.REFERENCIA_PEDIDO)+RTRIM(B.PRODUTO)+RTRIM(B.COR_PRODUTO)+RTRIM(B.GRADE) = C.CODIGO_ITEM AND 
	  A.NF_SAIDA=C.NF_SAIDA AND CODIGO_BARRA_PADRAO=0 AND B.NOME_CLIFOR LIKE '%MARISA%'
  ---
  END
  ---- FIM MARISA
  /***/
  ---- Verificar TIPO de faturamento
  SELECT @tipo_faturamento = TIPO_FATURAMENTO FROM FATURAMENTO A WITH (NOLOCK)
  JOIN inserted B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
  WHERE A.NF_SAIDA=B.NF_SAIDA 
    AND A.SERIE_NF=B.SERIE_NF 
    AND A.NATUREZA_SAIDA in('121.01','130.01')
  
  if @tipo_faturamento <> 'ORDENS DE SERVIÇO'
  begin
      select @errno  = 30002,
             @errmsg = 'Impossível Incluir #FATURAMENTO_ITEM #porque #TIPO_FATURAMENTO está diferente de [ORDENS DE SERVIÇO], verifique!'
      goto error     
  end
  
  ---- Verificar se NFE é referente a ORDEM DE SERVIÇO
  SELECT @retorno_ordem_servico = COUNT(*) FROM FATURAMENTO A WITH (NOLOCK)
  JOIN inserted B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
  WHERE A.NF_SAIDA=B.NF_SAIDA 
    AND A.SERIE_NF=B.SERIE_NF 
    AND A.TIPO_FATURAMENTO='ORDENS DE SERVIÇO' 
    AND A.NATUREZA_SAIDA in('121.01','130.01')

  ---- VERIFICAR QTDES ENTRE ITENS FISICOS X ITENS FISCAIS 
  if @retorno_ordem_servico > 0
  begin
	--- VERIFICAR FATURAMENTO_ITEM
	SELECT @CODIGO_ITEM=RTRIM(A.CODIGO_ITEM), @QTDE_ITEM=CONVERT(NUMERIC(14,0), SUM(A.QTDE_ITEM))
	FROM FATURAMENTO_ITEM A WITH (NOLOCK),inserted
	WHERE SUBSTRING(A.CODIGO_ITEM,1,7) = SUBSTRING(inserted.CODIGO_ITEM,1,7) AND A.NF_SAIDA=inserted.NF_SAIDA AND A.SERIE_NF=inserted.SERIE_NF
    GROUP BY A.CODIGO_ITEM

	--- VERIFICAR PRODUCAO_ORDEM_SERVICO
	SELECT @QTDE_OS=SUM(QTDE_O) FROM PRODUCAO_ORDEM_SERVICO A WITH (NOLOCK)
	JOIN PRODUCAO_OS_TAREFAS B WITH (NOLOCK) ON B.ORDEM_SERVICO=A.ORDEM_SERVICO
	JOIN inserted C ON C.NF_SAIDA = A.NF_SAIDA AND C.SERIE_NF = A.SERIE_NF
	WHERE A.ORDEM_SERVICO = SUBSTRING(C.CODIGO_ITEM,1,7) AND A.NF_SAIDA=C.NF_SAIDA AND A.SERIE_NF=C.SERIE_NF
	GROUP BY A.ORDEM_SERVICO

    if @QTDE_ITEM <> @QTDE_OS
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Incluir #FATURAMENTO_ITEM #porque #QUANTIDADE Item Físico <> Item Fiscal ('+rtrim(@CODIGO_ITEM)+'-'+cast(@QTDE_ITEM as CHAR(10))+'-'+CAST(@qtde_os as CHAR(10))+', verifique.'
      goto error
    end
  end
  --- FIM FISICO X FISCAIS
  /***/
  ---- Adicionar na descrição do item OP e NFe de Envio para Oficina	  	  
  IF @retorno_ordem_servico > 0
  BEGIN
	  UPDATE C
	  SET C.DESCRICAO_ITEM=RTRIM(C.DESCRICAO_ITEM)+' OP:'+RTRIM(A.ORDEM_PRODUCAO)+' NF:'+B.NF_SAIDA
	  FROM W_ORDEM_SERVICO_ORDEM_PRODUCAO_RETORNO A
	  JOIN W_ORDEM_SERVICO_ORDEM_PRODUCAO_ENVIO B ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO
	  JOIN FATURAMENTO_ITEM C WITH (NOLOCK) ON C.NF_SAIDA=A.NF_SAIDA AND C.SERIE_NF=A.SERIE_NF AND SUBSTRING(C.CODIGO_ITEM,1,7)=A.ORDEM_SERVICO
	  JOIN inserted D ON D.NF_SAIDA=A.NF_SAIDA AND D.SERIE_NF=A.SERIE_NF AND SUBSTRING(D.CODIGO_ITEM,1,7)=A.ORDEM_SERVICO
	  WHERE A.NF_SAIDA=D.NF_SAIDA 
		AND A.SERIE_NF=D.SERIE_NF
		AND A.ORDEM_SERVICO=SUBSTRING(D.CODIGO_ITEM,1,7)
		AND A.ORDEM_PRODUCAO=B.ORDEM_PRODUCAO   	  
  END
  
  return
error:
    raiserror (@errmsg, 16, 1)
    rollback transaction
end