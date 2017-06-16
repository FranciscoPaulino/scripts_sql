CREATE trigger [dbo].[DR_TU_VENDAS] on [dbo].[VENDAS]
  for UPDATE NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPEDIDO char(12),
           @errno   int,
           @dias_limite_entrega int,
		   @dias_entrega int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  
  select @insPEDIDO = PEDIDO from inserted

  
  -- Verificar se existe reserva de produto
  if update(CODIGO_TAB_PRECO)
  begin
    select @nullcnt = 0

    select @validcnt = count(*)
    from inserted,VENDAS_PROD_EMBALADO
    where inserted.PEDIDO = VENDAS_PROD_EMBALADO.PEDIDO

    if @validcnt > 0
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #VENDAS #porque existe #Reservas de Produto'
      goto error
    end
  end
	
  if
    update(APROVACAO) 
  begin
    --- TRAZER O LIMITE MÍNIMO DE ENTREGA POR TIPO DE CLIENTE DEFINIDO EM PROPRIEDADE   
      SELECT @dias_limite_entrega = 
      CASE VALOR_PROPRIEDADE 
            WHEN 'RENNER'           THEN 21                                                                
            WHEN 'EXTRA'            THEN 23                                                                 
            WHEN 'WALMART'          THEN 23                                                       
            ELSE 27
      END
      FROM PROP_CLIENTES_ATACADO, inserted
      WHERE inserted.CLIENTE_ATACADO = PROP_CLIENTES_ATACADO.CLIENTE_ATACADO AND 
            inserted.FILIAL = 'D.R. LINGERIE' AND 
              PROP_CLIENTES_ATACADO.PROPRIEDADE='00261' 

    --- VERIFICAR QUAL É O PEDIDO 
	--- datediff deve receber a menor data depois maior data
    select @nullcnt = 0
    SELECT @insPEDIDO = inserted.PEDIDO
    FROM VENDAS, inserted
    WHERE (datediff(day,getdate(),VENDAS.DATA_FATURAMENTO_RELATIVO) < @dias_limite_entrega) AND 
           VENDAS.PEDIDO = inserted.PEDIDO AND 
           VENDAS.FILIAL='D.R. LINGERIE'    
    
    --- VERIFICAR SE PEDIDO ATENDE CONDIÇÃO
	--- datediff deve receber a menor data depois maior data
    SELECT @validcnt = count(*)
    FROM VENDAS, inserted
    WHERE (datediff(day,getdate(),VENDAS.DATA_FATURAMENTO_RELATIVO) < @dias_limite_entrega) AND 
           VENDAS.PEDIDO = inserted.PEDIDO AND 
           VENDAS.FILIAL='D.R. LINGERIE' AND VENDAS.TIPO NOT IN('GO REFATURAMENTO','GO SOB ESTOQUE','GO SOB PRÉ PEDIDO')   

    if @validcnt > 0
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar #VENDAS #porque #PERÍODO entre APROVAÇÃO e DATA_FATURAMENTO_RELATIVO do pedido ('+RTRIM(@insPEDIDO)+') está fora do limite mínimo'
      goto error
    end

    --- VERIFICAR SE PEDIDO ATENDE CONDIÇÃO DE ENTREGA NA APROVAÇÃO 12 DIAS NO MÍNIMO
	--- datediff deve receber a menor data depois maior data
    SELECT @dias_entrega = count(*)
    FROM VENDAS_PRODUTO, inserted
    WHERE VENDAS_PRODUTO.PEDIDO = inserted.PEDIDO AND 
	      inserted.APROVACAO = 'A' AND 
		  (datediff(day,getdate(),VENDAS_PRODUTO.ENTREGA) < 9) AND 
          INSERTED.FILIAL='D.R. LINGERIE' AND INSERTED.TIPO NOT IN('GO REFATURAMENTO','GO SOB ESTOQUE','GO SOB PRÉ PEDIDO')      

    if @dias_entrega > 0
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar #VENDAS #porque #PERÍODO entre APROVAÇÃO e ENTREGA do pedido ('+RTRIM(@insPEDIDO)+') está fora do limite mínimo'
      goto error
    end
    
  end

  --- VERIFICAR SE PEDIDO ATENDE CONDIÇÃO DE ENTREGA E AGENDA DO CLIENTE 9 DIAS NO MÍNIMO
  --- datediff deve receber a menor data depois maior data
  if update(DATA_FATURAMENTO_RELATIVO)
    SELECT @dias_entrega = count(*)
    FROM VENDAS_PRODUTO, inserted
    WHERE VENDAS_PRODUTO.PEDIDO = inserted.PEDIDO AND 
	      inserted.APROVACAO = 'A' AND 
		  (datediff(day,VENDAS_PRODUTO.ENTREGA,inserted.DATA_FATURAMENTO_RELATIVO) < 9) AND 
          INSERTED.FILIAL='D.R. LINGERIE' AND INSERTED.TIPO NOT IN('GO REFATURAMENTO','GO SOB ESTOQUE','GO SOB PRÉ PEDIDO')      

    if @dias_entrega > 0
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar #VENDAS #porque #DATA DA AGENDA DO CLIENTE# e #FATURAMENTO# do pedido ('+RTRIM(@insPEDIDO)+') está fora do limite mínimo'
      goto error
    end

  return
error:
  raiserror @errno @errmsg
  rollback transaction
end

