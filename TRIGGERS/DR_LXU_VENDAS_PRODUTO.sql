USE [DRLINGERIE]
GO
/****** Object:  Trigger [dbo].[DR_LXU_VENDAS_PRODUTO]    Script Date: 03/07/2017 12:57:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Trigger [dbo].[DR_LXU_VENDAS_PRODUTO] On [dbo].[VENDAS_PRODUTO]  
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
		   @filial varchar(25),
		   @insPEDIDO char(12),
		   @aprovacao char(1),
           @errmsg  varchar(255),
           @delPEDIDO char(12),
           @desconto int,
           @porc_desconto int,
           @uf      char(2),
           @natureza_saida char(7),
		   @qtde_embalada int,
		   @qtde_entregue int,
		   @qtde_original int,
		   @produto char(20),
		   @filial_venda_func varchar(25),
		   @ENTREGA DATETIME,
		   @LIMITE_ENTREGA DATETIME,
		   @ENTREGA_PERFAT DATETIME,
		   @LIMITE_ENTREGA_PERFAT DATETIME,
		   @cor_produto char(15),
		   @itemPEDIDO CHAR(4)

  select @numrows = @@rowcount
/* nome do usuário logado */
  SELECT @user = SUSER_SNAME()
/* valor do parametro */
  SELECT @VALOR_ATUAL_USER=CONVERT(DATETIME,VALOR_ATUAL_USER,103) FROM PARAMETROS_USERS  
  WHERE PARAMETRO = 'BLOQ_CARTEIRA_ENTREGA' AND USUARIO=LTRIM(@user)
  ---
  SELECT @VALOR_ATUAL=CONVERT(DATETIME,VALOR_ATUAL,103) FROM PARAMETROS  
  WHERE PARAMETRO = 'BLOQ_CARTEIRA_ENTREGA'

  -- VERIFICAR ALTERAÇÃO NA GRADE DO PEDIDO
  if update(vo1) or update(vo2) or update(vo3) or update(vo4) or update(vo5) or update(vo6) or 
     update(vo7) or update(vo8) or update(vo9) or update(vo10) or update(vo11) or update(vo12) or
     update(vo13) or update(vo14) or update(vo15) or update(vo16)
  begin
     -- seta filial, aprovacao e pedido
	 select @filial = RTRIM(vendas.FILIAL),@insPEDIDO = RTRIM(inserted.PEDIDO), @aprovacao = VENDAS.APROVACAO, @produto=inserted.PRODUTO, @cor_produto=inserted.COR_PRODUTO  
	 from inserted, VENDAS
  	 where vendas.PEDIDO = inserted.PEDIDO

     if (@filial = 'D.R. LINGERIE' and @aprovacao = 'A')
  	 begin
	    EXEC SP_PEDIDO_GRADE_ALTERADA_ENVIAR_EMAIL_PCP @insPEDIDO, @produto, @cor_produto 
	 end				
  end

  -- Verificar se existe reserva do pedido
  if
    update(PRECO1)
  begin
    select @nullcnt = 0

    select @validcnt = count(*)
    from inserted,VENDAS_PROD_EMBALADO
    where inserted.PEDIDO = VENDAS_PROD_EMBALADO.PEDIDO

	select @filial_venda_func = VALOR_ATUAL from parametros where PARAMETRO='FILIAL_VENDA_FUNC'

    if (select rtrim(VENDAS_PROD_EMBALADO.FILIAL) from inserted,VENDAS_PROD_EMBALADO where inserted.PEDIDO = VENDAS_PROD_EMBALADO.PEDIDO) <> @filial_venda_func
	begin
		if @validcnt > 0
		begin
		  select @errno  = 30007,
				 @errmsg = 'Impossível ALTERAR PREÇO em #VENDAS_PRODUTO #porque existe #VENDAS_PROD_EMBALADO#.'
		  goto error
		end
	end
  end

  -- Verificar se existe (QTDE_EMBALADA + QTDE_ENTREGUE) > QTDE_ORIGINAL
  if
    update(QTDE_EMBALADA) OR update(QTDE_ENTREGUE)
  begin
    select @nullcnt = 0

    select @insPEDIDO=VENDAS_PRODUTO.PEDIDO,
	       @itemPEDIDO=VENDAS_PRODUTO.item_PEDIDO,
           @produto=VENDAS_PRODUTO.PRODUTO,
           @cor_produto=VENDAS_PRODUTO.COR_PRODUTO,
           @qtde_embalada=SUM(VENDAS_PRODUTO.QTDE_EMBALADA),
		   @qtde_entregue=SUM(VENDAS_PRODUTO.QTDE_ENTREGUE),
		   @qtde_original=SUM(VENDAS_PRODUTO.QTDE_ORIGINAL)
    from   inserted,VENDAS_PRODUTO
    where  inserted.PEDIDO = VENDAS_PRODUTO.PEDIDO AND 
	       inserted.ITEM_PEDIDO = VENDAS_PRODUTO.ITEM_PEDIDO AND 
		   inserted.PRODUTO = VENDAS_PRODUTO.PRODUTO AND 
		   inserted.COR_PRODUTO = VENDAS_PRODUTO.COR_PRODUTO
    GROUP BY VENDAS_PRODUTO.PEDIDO,VENDAS_PRODUTO.item_PEDIDO,VENDAS_PRODUTO.PRODUTO,VENDAS_PRODUTO.COR_PRODUTO

    if (@QTDE_EMBALADA + @QTDE_ENTREGUE) > @QTDE_ORIGINAL
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível alterar QTDE_EMBALADA OU QTDE_ENTREGUE em #VENDAS_PRODUTO# porque (QTDE_EMBALADA + QTDE_ENTREGUE) > QTDE_ORIGINAL. (Pedido: '+rtrim(@insPEDIDO)+' Item Pedido: '+rtrim(@itemPEDIDO)+' Produto: '+rtrim(@produto)+' Cor '+rtrim(@cor_produto)+')'
      goto error
    end
  end
    
/* tabela vendas_produto */
  if
    update(ENTREGA) OR UPDATE(LIMITE_ENTREGA) OR update(NUMERO_ENTREGA)
  begin
    select @nullcnt = 0

    select @validcnt = count(*)
    from inserted,FATURAMENTO_PROD
    where inserted.PEDIDO = FATURAMENTO_PROD.PEDIDO

    if @validcnt > 0
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar #VENDAS_PRODUTO# porque existe #FATURAMENTO_PROD#, verifique'
      goto error
    end

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
    ---- ATUALIZA AS DATAS ENTREGA E LIMITE ENTREGA PARA O PERFAT, EVITANDO DISTORÇÕES DA DATAS NOS ITENS DO PEDIDO
    UPDATE C
    SET C.ENTREGA=A.ENTREGA, C.LIMITE_ENTREGA=A.LIMITE, C.NUMERO_ENTREGA=A.NUMERO_ENTREGA   
    FROM PRODUTOS_PERIODOS_ENTREGAS A WITH (NOLOCK)
    JOIN VENDAS B WITH (NOLOCK) ON B.PERIODO_PCP=A.PERIODO_PCP AND B.NUMERO_ENTREGA=A.NUMERO_ENTREGA
    JOIN VENDAS_PRODUTO C WITH (NOLOCK) ON C.PEDIDO=B.PEDIDO
    JOIN inserted D ON D.PEDIDO=C.PEDIDO AND D.PRODUTO=C.COR_PRODUTO
    WHERE (B.PEDIDO=D.PEDIDO AND B.FILIAL='DR VAREJO')
    --- FIM
	--- ATUALIZA DATAS CASO SEJA FINAL DE SEMANA
	UPDATE 	VENDAS_PRODUTO
	SET 	VENDAS_PRODUTO.ENTREGA = CASE WHEN DBO.FX_DIA_SEMANA(VENDAS_PRODUTO.ENTREGA)=1 THEN (VENDAS_PRODUTO.ENTREGA-2) WHEN DBO.FX_DIA_SEMANA(VENDAS_PRODUTO.ENTREGA)=7 THEN (VENDAS_PRODUTO.ENTREGA-1) ELSE (VENDAS_PRODUTO.ENTREGA) END,
	        VENDAS_PRODUTO.LIMITE_ENTREGA = CASE WHEN DBO.FX_DIA_SEMANA(VENDAS_PRODUTO.LIMITE_ENTREGA)=1 THEN (VENDAS_PRODUTO.LIMITE_ENTREGA-2) WHEN DBO.FX_DIA_SEMANA(VENDAS_PRODUTO.LIMITE_ENTREGA)=7 THEN (VENDAS_PRODUTO.LIMITE_ENTREGA-1) ELSE (VENDAS_PRODUTO.LIMITE_ENTREGA) END
	FROM 	VENDAS_PRODUTO, VENDAS, INSERTED
	WHERE 	VENDAS_PRODUTO.PEDIDO = INSERTED.PEDIDO AND 
            VENDAS_PRODUTO.PRODUTO = INSERTED.PRODUTO AND 
			VENDAS_PRODUTO.COR_PRODUTO = INSERTED.COR_PRODUTO AND 
			VENDAS_PRODUTO.ITEM_PEDIDO = INSERTED.ITEM_PEDIDO AND 
	        VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO AND 
			VENDAS.FILIAL = 'D.R. LINGERIE' AND 
	        DBO.FX_DIA_SEMANA(VENDAS_PRODUTO.ENTREGA) IN(1,7)
  end

  return
error:
  raiserror @errno @errmsg
  rollback transaction
end
