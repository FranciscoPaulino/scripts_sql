USE [DRVAREJO]
GO
/****** Object:  Trigger [dbo].[LDR_TU_VENDAS_PRODUTO]    Script Date: 11/17/2015 10:39:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[LDR_TU_VENDAS_PRODUTO] on [dbo].[VENDAS_PRODUTO]
  for UPDATE NOT FOR REPLICATION
  as
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
           @errmsg  varchar(255),
		   @qtde_embalada int,
		   @qtde_entregue int,
		   @qtde_original int,
		   @produto char(20),
		   @cor_produto char(15)

  select @numrows = @@rowcount
  
  -- Verificar se existe reserva do pedido
  if
    update(PRECO1)
  begin
    select @nullcnt = 0

    select @validcnt = count(*)
    from inserted,VENDAS_PROD_EMBALADO
    where inserted.PEDIDO = VENDAS_PROD_EMBALADO.PEDIDO

    if @validcnt > 0
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível ALTERAR PREÇO em #VENDAS_PRODUTO #porque existe #VENDAS_PROD_EMBALADO#.'
      goto error
    end
  end


  -- Verificar se existe (QTDE_EMBALADA + QTDE_ENTREGUE) > QTDE_ORIGINAL
  if
    update(QTDE_EMBALADA) OR update(QTDE_ENTREGUE)
  begin
    select @nullcnt = 0

    select @insPEDIDO=VENDAS_PRODUTO.PEDIDO,
           @produto=VENDAS_PRODUTO.PRODUTO,
           @cor_produto=VENDAS_PRODUTO.COR_PRODUTO,
           @qtde_embalada=VENDAS_PRODUTO.QTDE_EMBALADA,
		   @qtde_entregue=VENDAS_PRODUTO.QTDE_ENTREGUE,
		   @qtde_original=VENDAS_PRODUTO.QTDE_ORIGINAL
    from   inserted,VENDAS_PRODUTO
    where  inserted.PEDIDO = VENDAS_PRODUTO.PEDIDO AND inserted.PRODUTO = VENDAS_PRODUTO.PRODUTO 
	       AND inserted.COR_PRODUTO = VENDAS_PRODUTO.COR_PRODUTO

    if (@QTDE_EMBALADA + @QTDE_ENTREGUE) > @QTDE_ORIGINAL
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível alterar QTDE_EMBALADA OU QTDE_ENTREGUE em #VENDAS_PRODUTO# porque (QTDE_EMBALADA + QTDE_ENTREGUE) > QTDE_ORIGINAL. (Pedido: '+rtrim(@insPEDIDO)+' Produto: '+rtrim(@produto)+' Cor '+rtrim(@cor_produto)+')'
      goto error
    end
  end

  return
error:
  raiserror @errno @errmsg
  rollback transaction
end
