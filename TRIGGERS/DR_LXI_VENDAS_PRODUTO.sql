CREATE Trigger [dbo].[DR_LXI_VENDAS_PRODUTO] On [dbo].[VENDAS_PRODUTO]  
for INSERT NOT FOR REPLICATION
AS   
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
    	   @DATA_ENTREGA DATETIME,
    	   @BLOQ_CARTEIRA_ENTREGA DATETIME,  
		   @DATA_FATURAMENTO_RELATIVO DATETIME,
    	   @VALOR_ATUAL_USER DATETIME,
    	   @VALOR_ATUAL DATETIME,
    	   @user varchar(255),
		   @FILIAL VARCHAR(25),
           @errmsg  varchar(255)

  select @numrows = @@rowcount
/* nome do usu�rio logado */
  SELECT @user = SUSER_SNAME()
/* valor do parametro */
  SELECT @VALOR_ATUAL_USER=CONVERT(DATETIME,VALOR_ATUAL_USER,103) FROM PARAMETROS_USERS  
  WHERE PARAMETRO = 'BLOQ_CARTEIRA_ENTREGA' AND USUARIO=LTRIM(@user)
  ---
  SELECT @VALOR_ATUAL=CONVERT(DATETIME,VALOR_ATUAL,103) FROM PARAMETROS  
  WHERE PARAMETRO = 'BLOQ_CARTEIRA_ENTREGA'
  
  if update(ENTREGA) or update(LIMITE_ENTREGA)
  begin
    select @DATA_FATURAMENTO_RELATIVO = ISNULL(DATA_FATURAMENTO_RELATIVO,0),@FILIAL = VENDAS.FILIAL
    from inserted, VENDAS
	WHERE inserted.PEDIDO = VENDAS.PEDIDO 

    IF @FILIAL='D.R. LINGERIE' AND @DATA_FATURAMENTO_RELATIVO = 0
    begin
       select @errno  = 30007,
       @errmsg = 'Imposs�vel Incluir #VENDAS_PRODUTO# porque #DATA FATURAMENTO RELATIVO# n�o foi informada, verifique'
       goto error
    end
  end
  
/* tabela vendas_produto */
  if
    update(ENTREGA)
  begin
    select @nullcnt = 0

    -- PEGAR A DATA QUE EST� ENTRANDO
    select @DATA_ENTREGA = ENTREGA
    from inserted

    -- TESTAR A DATA
    IF (RTRIM(LTRIM(@VALOR_ATUAL_USER))<>'')
    BEGIN
        --PRINT @VALOR_ATUAL_USER
        if (@DATA_ENTREGA < @VALOR_ATUAL_USER)
        begin
            select @errno  = 30007,
            @errmsg = 'Imposs�vel Incluir  #VENDAS_PRODUTO #porque DATA ENTREGA fora do limite.'
            goto error
        end
    END
    ELSE
    BEGIN    
        --PRINT @VALOR_ATUAL
        if (@DATA_ENTREGA < @VALOR_ATUAL)
        begin
            select @errno  = 30007,
            @errmsg = 'Imposs�vel Incluir  #VENDAS_PRODUTO #porque DATA ENTREGA fora do limite.'
            goto error
        end
    END
  end

/*---LINX-INSERT---------------------------------------------------------------------------------------*/
	UPDATE 	VENDAS_PRODUTO
	SET 	VENDAS_PRODUTO.ENTREGA = CASE WHEN DBO.FX_DIA_SEMANA((VENDAS.DATA_FATURAMENTO_RELATIVO-9))=1 THEN ((VENDAS.DATA_FATURAMENTO_RELATIVO-9)-2) WHEN DBO.FX_DIA_SEMANA((VENDAS.DATA_FATURAMENTO_RELATIVO-9))=7 THEN ((VENDAS.DATA_FATURAMENTO_RELATIVO-9)-1) ELSE ((VENDAS.DATA_FATURAMENTO_RELATIVO-9)) END,
	        VENDAS_PRODUTO.LIMITE_ENTREGA = CASE WHEN DBO.FX_DIA_SEMANA((VENDAS.DATA_FATURAMENTO_RELATIVO-9))=1 THEN ((VENDAS.DATA_FATURAMENTO_RELATIVO-9)-2) WHEN DBO.FX_DIA_SEMANA((VENDAS.DATA_FATURAMENTO_RELATIVO-9))=7 THEN ((VENDAS.DATA_FATURAMENTO_RELATIVO-9)-1) ELSE ((VENDAS.DATA_FATURAMENTO_RELATIVO-9)) END
	FROM 	VENDAS_PRODUTO, VENDAS, INSERTED
	WHERE 	VENDAS_PRODUTO.PEDIDO = INSERTED.PEDIDO AND 
            VENDAS_PRODUTO.PRODUTO = INSERTED.PRODUTO AND 
			VENDAS_PRODUTO.COR_PRODUTO = INSERTED.COR_PRODUTO AND 
			VENDAS_PRODUTO.ITEM_PEDIDO = INSERTED.ITEM_PEDIDO AND 
	     
   VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO AND 
			VENDAS.FILIAL = 'D.R. LINGERIE' 
/*-----------------------------------------------------------------------------------------------------*/

  return
error:
  raiserror @errno @errmsg
  rollback transaction
end

