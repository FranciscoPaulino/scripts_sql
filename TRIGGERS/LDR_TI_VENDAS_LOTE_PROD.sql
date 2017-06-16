CREATE trigger [dbo].[LDR_TI_VENDAS_LOTE_PROD] on [dbo].[VENDAS_LOTE_PROD] FOR INSERT NOT FOR REPLICATION as
  -- Declare the variables to store the values returned by FETCH.
begin 
  DECLARE 
  @produto varchar(20), 
  @cor_produto char(10),
  @periodo_pcp varchar(25),
  @numero_entrega char(2), 
  @entrega_venda datetime, 
  @entrega_produto datetime, 
  @limite datetime,
  @pedido_externo char(12),
  @representante varchar(25),
  @cliente_atacado varchar(25),
  @gerente varchar(25),
  @qtde_original int,
  @rep_numero_entrega char(2) 

  DECLARE vendas_lote_prod_cursor CURSOR FOR
  SELECT distinct vendas_lote_prod.produto,vendas_lote_prod.cor_produto,
  LDR_PRODUTO_COR_ENTREGA_FUTURA.numero_entrega,  
  entrega_venda=inserted.entrega,
  entrega_produto=LDR_PRODUTO_COR_ENTREGA_FUTURA.entrega,
  LDR_PRODUTO_COR_ENTREGA_FUTURA.limite,
  LDR_PRODUTO_COR_ENTREGA_FUTURA.periodo_pcp,
  inserted.pedido_externo,
  vendas_lote.representante,
  vendas_lote.cliente_atacado,
  vendas_lote.gerente,
  VENDAS_LOTE_PROD.QTDE_ORIGINAL,
  rep_numero_entrega=vendas_lote.numero_entrega
  FROM vendas_lote_prod,vendas_lote,LDR_PRODUTO_COR_ENTREGA_FUTURA,inserted
  WHERE inserted.pedido_externo=vendas_lote.pedido_externo 
  and vendas_lote.pedido_externo=vendas_lote_prod.pedido_externo
  and LDR_PRODUTO_COR_ENTREGA_FUTURA.produto=vendas_lote_prod.produto and LDR_PRODUTO_COR_ENTREGA_FUTURA.cor_produto=vendas_lote_prod.cor_produto
  and LDR_PRODUTO_COR_ENTREGA_FUTURA.produto=inserted.produto and LDR_PRODUTO_COR_ENTREGA_FUTURA.cor_produto=inserted.cor_produto
  ORDER BY LDR_PRODUTO_COR_ENTREGA_FUTURA.entrega desc

  OPEN vendas_lote_prod_cursor

  -- Perform the first fetch and store the values in variables.
  -- Note: The variables are in the same order as the columns
  -- in the SELECT statement. 

  FETCH NEXT FROM vendas_lote_prod_cursor
  INTO @produto, @cor_produto, @numero_entrega, @entrega_venda, @entrega_produto, @limite, @periodo_pcp, @pedido_externo, @representante, @cliente_atacado, @gerente, @qtde_original,@rep_numero_entrega

  -- Check @@FETCH_STATUS to see if there are any more rows to fetch.
  WHILE @@FETCH_STATUS = 0
  BEGIN

     if @entrega_produto > @entrega_venda
     begin
        -- grava informaçoes na tabela ldr_produtos_periodos_entregas_futuras para envio de email posterior em job
        INSERT INTO ldr_produtos_periodos_entregas_futuras 
        (representante,pedido_externo,cliente_atacado,produto,cor_produto,numero_entrega,entrega,limite_entrega,enviar_email,gerente,qtde_original,numero_entrega_rep)
        VALUES (@representante,@pedido_externo,@cliente_atacado,@produto,@cor_produto,@numero_entrega,@entrega_produto,@limite,'1',@gerente,@qtde_original,@rep_numero_entrega)

        -- Vendas Lote Produtos
        --update vendas_lote_prod
        --set numero_entrega=@numero_entrega, entrega=@entrega_produto,limite_entrega=@limite
        --from vendas_lote_prod, inserted
        --where vendas_lote_prod.pedido_externo=inserted.pedido_externo

        -- Vendas Lote
        update vendas_lote
        set periodo_pcp=@periodo_pcp,numero_entrega=@numero_entrega
        from vendas_lote, inserted
        where vendas_lote.pedido_externo=inserted.pedido_externo
     end

     -- Vendas Lote Produtos
     update vendas_lote_prod
     set numero_entrega=vendas_lote.numero_entrega, entrega=produtos_periodos_entregas.entrega,limite_entrega=produtos_periodos_entregas.limite
     from vendas_lote_prod, vendas_lote, produtos_periodos_entregas, inserted
     where vendas_lote_prod.pedido_externo=vendas_lote.pedido_externo and 
           vendas_lote.numero_entrega=produtos_periodos_entregas.numero_entrega and 
           vendas_lote.periodo_pcp=produtos_periodos_entregas.periodo_pcp and
           vendas_lote.pedido_externo = inserted.pedido_externo

     -- This is executed as long as the previous fetch succeeds.
     FETCH NEXT FROM vendas_lote_prod_cursor
     INTO @produto, @cor_produto, @numero_entrega, @entrega_venda, @entrega_produto, @limite, @periodo_pcp, @pedido_externo, @representante, @cliente_atacado, @gerente, @qtde_original, @rep_numero_entrega
  END
  
  CLOSE vendas_lote_prod_cursor
  DEALLOCATE vendas_lote_prod_cursor
  
  /* insert de registros para controle de CÓPIA DE PEDIDO REPRESENTANTE  VENDAS_LOTE_PROD                */ 

    INSERT INTO VENDAS_LOTE_PROD_COPIA_PEDIDO(PRODUTO,COR_PRODUTO,ENTREGA,PEDIDO_EXTERNO,SEQUENCIAL_DIGITACAO,PACKS,
            NUMERO_CONJUNTO,NUMERO_ENTREGA,LIMITE_ENTREGA,STATUS_VENDA_ATUAL,QTDE_ORIGINAL,VALOR_ORIGINAL,
            PRECO1,PRECO2,PRECO3,PRECO4,DESCONTO_ITEM,IPI,VO1,VO2,VO3,VO4,VO5,VO6,VO7,VO8,VO9,VO10,VO11,
            VO12,VO13,VO14,VO15,VO16,VO17,VO18,VO19,VO20,VO21,VO22,VO23,VO24,VO25,VO26,VO27,VO28,VO29,
            VO30,VO31,VO32,VO33,VO34,VO35,VO36,VO37,VO38,VO39,VO40,VO41,VO42,VO43,VO44,VO45,VO46,VO47,VO48,
            DATA_PARA_TRANSFERENCIA,ITEM_PEDIDO,CODIGO_LOCAL_ENTREGA,TIPO_CAIXA,NUMERO_CAIXAS,DESC_VENDA_CLIENTE,
            COMISSAO_ITEM,COMISSAO_ITEM_GERENTE,ID_MODIFICACAO,COMISSAO_VALOR_GERENTE,COMISSAO_VALOR)
    SELECT  VENDAS_LOTE_PROD.PRODUTO,VENDAS_LOTE_PROD.COR_PRODUTO,VENDAS_LOTE_PROD.ENTREGA,VENDAS_LOTE_PROD.PEDIDO_EXTERNO,
            VENDAS_LOTE_PROD.SEQUENCIAL_DIGITACAO,VENDAS_LOTE_PROD.PACKS,VENDAS_LOTE_PROD.NUMERO_CONJUNTO,
            VENDAS_LOTE_PROD.NUMERO_ENTREGA,VENDAS_LOTE_PROD.LIMITE_ENTREGA,VENDAS_LOTE_PROD.STATUS_VENDA_ATUAL,
            VENDAS_LOTE_PROD.QTDE_ORIGINAL,VENDAS_LOTE_PROD.VALOR_ORIGINAL,VENDAS_LOTE_PROD.PRECO1,VENDAS_LOTE_PROD.PRECO2,
            VENDAS_LOTE_PROD.PRECO3,VENDAS_LOTE_PROD.PRECO4,VENDAS_LOTE_PROD.DESCONTO_ITEM,VENDAS_LOTE_PROD.IPI,VENDAS_LOTE_PROD.VO1,
            VENDAS_LOTE_PROD.VO2,VENDAS_LOTE_PROD.VO3,VENDAS_LOTE_PROD.VO4,VENDAS_LOTE_PROD.VO5,VENDAS_LOTE_PROD.VO6,
            VENDAS_LOTE_PROD.VO7,VENDAS_LOTE_PROD.VO8,VENDAS_LOTE_PROD.VO9,VENDAS_LOTE_PROD.VO10,VENDAS_LOTE_PROD.VO11,
            VENDAS_LOTE_PROD.VO12,VENDAS_LOTE_PROD.VO13,VENDAS_LOTE_PROD.VO14,VENDAS_LOTE_PROD.VO15,VENDAS_LOTE_PROD.VO16,
            VENDAS_LOTE_PROD.VO17,VENDAS_LOTE_PROD.VO18,VENDAS_LOTE_PROD.VO19,VENDAS_LOTE_PROD.VO20,VENDAS_LOTE_PROD.VO21,VENDAS_LOTE_PROD.VO22,
            VENDAS_LOTE_PROD.VO23,VENDAS_LOTE_PROD.VO24,VENDAS_LOTE_PROD.VO25,VENDAS_LOTE_PROD.VO26,VENDAS_LOTE_PROD.VO27,VENDAS_LOTE_PROD.VO28,
            VENDAS_LOTE_PROD.VO29,VENDAS_LOTE_PROD.VO30,VENDAS_LOTE_PROD.VO31,VENDAS_LOTE_PROD.VO32,VENDAS_LOTE_PROD.VO33,VENDAS_LOTE_PROD.VO34,
            VENDAS_LOTE_PROD.VO35,VENDAS_LOTE_PROD.VO36,VENDAS_LOTE_PROD.VO37,VENDAS_LOTE_PROD.VO38,VENDAS_LOTE_PROD.VO39,VENDAS_LOTE_PROD.VO40,
            VENDAS_LOTE_PROD.VO41,VENDAS_LOTE_PROD.VO42,VENDAS_LOTE_PROD.VO43,VENDAS_LOTE_PROD.VO44,VENDAS_LOTE_PROD.VO45,VENDAS_LOTE_PROD.VO46,
            VENDAS_LOTE_PROD.VO47,VENDAS_LOTE_PROD.VO48,VENDAS_LOTE_PROD.DATA_PARA_TRANSFERENCIA,VENDAS_LOTE_PROD.ITEM_PEDIDO,
            VENDAS_LOTE_PROD.CODIGO_LOCAL_ENTREGA,VENDAS_LOTE_PROD.TIPO_CAIXA,VENDAS_LOTE_PROD.NUMERO_CAIXAS,VENDAS_LOTE_PROD.DESC_VENDA_CLIENTE,
            VENDAS_LOTE_PROD.COMISSAO_ITEM,VENDAS_LOTE_PROD.COMISSAO_ITEM_GERENTE,VENDAS_LOTE_PROD.ID_MODIFICACAO,VENDAS_LOTE_PROD.COMISSAO_VALOR_GERENTE,
            VENDAS_LOTE_PROD.COMISSAO_VALOR
    FROM    VENDAS_LOTE_PROD,INSERTED
    WHERE VENDAS_LOTE_PROD.PEDIDO_EXTERNO=INSERTED.PEDIDO_EXTERNO AND   
          VENDAS_LOTE_PROD.PRODUTO=INSERTED.PRODUTO AND   
          VENDAS_LOTE_PROD.COR_PRODUTO=INSERTED.COR_PRODUTO AND  
          VENDAS_LOTE_PROD.ENTREGA=INSERTED.ENTREGA AND  
          VENDAS_LOTE_PROD.ITEM_PEDIDO=INSERTED.ITEM_PEDIDO 


    /*-----------------------------------------------------------------------------------------------------*/
end 


