USE [DRLINGERIE] 
GO
/****** Object:  Trigger [dbo].[DR_LXU_VENDAS_PRODUTO]    Script Date: 02/18/2013 13:15:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Trigger [dbo].[DR_LXU_VENDAS_PRODUTO] On [dbo].[VENDAS_PRODUTO]  
FOR UPDATE NOT FOR REPLICATION  
AS   
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
    	   @DATA_ENTREGA DATETIME,
    	   @BLOQ_CARTEIRA_ENTREGA DATETIME,  
    	   @VALOR_ATUAL_USER DATETIME,
    	   @VALOR_ATUAL DATETIME,
    	   @user varchar(255),
           @errmsg  varchar(255)

  select @numrows = @@rowcount
/* nome do usuário logado */
  SELECT @user = SUSER_SNAME()
/* valor do parametro */
  SELECT @VALOR_ATUAL_USER=CONVERT(DATETIME,VALOR_ATUAL_USER,103) FROM PARAMETROS_USERS  
  WHERE PARAMETRO = 'BLOQ_CARTEIRA_ENTREGA' AND USUARIO=LTRIM(@user)
  ---
  SELECT @VALOR_ATUAL=CONVERT(DATETIME,VALOR_ATUAL,103) FROM PARAMETROS  
  WHERE PARAMETRO = 'BLOQ_CARTEIRA_ENTREGA'
  
/* tabela vendas_produto */
  if
    update(ENTREGA)
  begin
    select @nullcnt = 0

    -- PEGAR A DATA QUE ESTÁ ENTRANDO
    select @DATA_ENTREGA = a.ENTREGA
    from inserted a, VENDAS_PRODUTO b
    where b.PEDIDO=a.PEDIDO and b.PRODUTO=a.PRODUTO and b.COR_PRODUTO=a.COR_PRODUTO and a.SEQUENCIAL_DIGITACAO=b.SEQUENCIAL_DIGITACAO
    
    -- TESTAR A DATA
    IF (RTRIM(LTRIM(@VALOR_ATUAL_USER))<>'')
    BEGIN
        --PRINT @VALOR_ATUAL_USER
        if (@DATA_ENTREGA < @VALOR_ATUAL_USER)
        begin
            select @errno  = 30007,
            @errmsg = 'Impossível Atualizar  #VENDAS_PRODUTO #porque DATA ENTREGA fora do limite.'
            goto error
        end
    END
    ELSE
    BEGIN    
        --PRINT @VALOR_ATUAL
        if (@DATA_ENTREGA < @VALOR_ATUAL)
        begin
            select @errno  = 30007,
            @errmsg = 'Impossível Atualizar  #VENDAS_PRODUTO #porque DATA ENTREGA fora do limite.'
            goto error
        end
    END
  end

  return
error:
  raiserror @errno @errmsg
  rollback transaction
end
