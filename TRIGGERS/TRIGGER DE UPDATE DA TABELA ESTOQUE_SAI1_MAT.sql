USE [DRVAREJO]
GO
/****** Object:  Trigger [dbo].[LXU_ESTOQUE_SAI1_MAT]    Script Date: 01/09/2015 11:04:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[LXU_ESTOQUE_SAI1_MAT] 
on [dbo].[ESTOQUE_SAI1_MAT]
  for UPDATE NOT FOR REPLICATION
  as
/* UPDATE trigger on ESTOQUE_SAI1_MAT */
/* default body for LXU_ESTOQUE_SAI1_MAT */
begin

	-- 23/09/2014 - Rodrigo Souza - TP 6511122 - #1# - Alteração para não barrar atualização do custo.
	-- 13/02/2012 - RAFAEL - INCLUSÃO DO TRATAMENTO P/ MOVIMENTAÇÃO DE ESTOQUE DE MATERIA-PRIMA  
	-- 30/08/2011 - Fabiano Banin - Ajuste no consumo do material, verificar se a entrada é de uma transferência, se for, deixar consumir.
	-- 01/06/2010 - Fabiano Banin - Colocado tratamento para transferir quando o tipo de movimentação é F e a ordem de produção não esteja nula.
	-- 17/03/2008 - Fabiano Banin - Colocado tratamento para não permitir alteração qdo o material tem ajuste.
	-- 06/12/2004 - Alessandro - Teste para agilizar a valorização da movimentação

  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insREQ_MATERIAL char(8), 
           @insMATERIAL char(11), 
           @insCOR_MATERIAL char(10), 
           @insITEM char(3), 
           @insFILIAL varchar(25),
           @delREQ_MATERIAL char(8), 
           @delMATERIAL char(11), 
           @delCOR_MATERIAL char(10), 
           @delITEM char(3), 
           @delFILIAL varchar(25),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  
--#1#  
  IF (UPDATE(CUSTO) OR UPDATE(DATA_CUSTO)) AND NOT (UPDATE(REQ_MATERIAL) OR 
	UPDATE(FILIAL) OR 
	UPDATE(CODIGO_FISCAL_OPERACAO) OR 
	UPDATE(ITEM_IMPRESSAO) OR 
	UPDATE(OF_FATURAR) OR 
	UPDATE(PRECO_MATERIAL_EMPREGADO) OR 
	UPDATE(PRECO_SERVICO) OR 
	UPDATE(CONTA_CONTABIL) OR 
	UPDATE(RATEIO_FILIAL) OR 
	UPDATE(RATEIO_CENTRO_CUSTO) OR 
	UPDATE(MATERIAL) OR 
	UPDATE(COR_MATERIAL) OR 
	UPDATE(ITEM) OR 
	UPDATE(ORDEM_PRODUCAO) OR 
	UPDATE(QTDE) OR 
	UPDATE(QTDE_AUX) OR 
	UPDATE(MATAR_SALDO_RESERVA) OR 
	UPDATE(FILIAL_FATURAMENTO) OR 
	UPDATE(SERIE_NF) OR 
	UPDATE(NF_SAIDA) OR 
	UPDATE(ICMS) OR 
	UPDATE(IPI) OR 
	UPDATE(DESCONTO_ITEM) OR 
	UPDATE(PRECO) OR 
	UPDATE(VALOR) OR 
	UPDATE(FATOR_CONVERSAO_UNIDADE) OR 
	UPDATE(UNIDADE_FATURAMENTO) OR 
	UPDATE(VALOR_BRUTO) OR 
	UPDATE(ENTREGA) OR 
	UPDATE(PEDIDO) OR 
	UPDATE(RESERVA_AUTOMATICA) OR 
	UPDATE(PERDA))

RETURN 
--#1#   

/*-- Verifica Movimentacao Estoque MP ---------------------------------------------------------------------------------*/
DECLARE @xDataSaldo DateTime

	SELECT @xDataSaldo='18000101'
	SELECT @xDataSaldo=ISNULL(CONVERT(DATETIME,VALOR_ATUAL,103),'18000101') FROM PARAMETROS WHERE PARAMETRO='DATA_BLOQUEIO_MOV_MP'


	IF (	SELECT 	COUNT(*)
		FROM	Deleted, ESTOQUE_SAI_MAT
		WHERE	Deleted.REQ_MATERIAL = ESTOQUE_SAI_MAT.REQ_MATERIAL AND
                        Deleted.FILIAL = ESTOQUE_SAI_MAT.FILIAL AND
			ESTOQUE_SAI_MAT.EMISSAO <= @xDataSaldo

			)+
	   (	SELECT 	COUNT(*)
		FROM	Inserted, ESTOQUE_SAI_MAT
		WHERE	Inserted.REQ_MATERIAL = ESTOQUE_SAI_MAT.REQ_MATERIAL AND
                        Inserted.FILIAL = ESTOQUE_SAI_MAT.FILIAL AND
			ESTOQUE_SAI_MAT.EMISSAO <= @xDataSaldo

			) > 0

	BEGIN
		SELECT 	@errno=30002,
			@errmsg='Não é possível Alterar Movimentacao de Estoque de Materiais anterior a #'+CONVERT(Char(10),@xDataSaldo,103)+' !'
		GOTO error
	END


	/*--- BLOQUEIO POR AJUSTE ---*/

	--BEGIN
	--	IF EXISTS(SELECT *
	--		FROM	Deleted, ESTOQUE_SAI_MAT, ESTOQUE_MATERIAIS
	--		WHERE	DELETED.REQ_MATERIAL = ESTOQUE_SAI_MAT.REQ_MATERIAL AND
 --                        DELETED.FILIAL = ESTOQUE_SAI_MAT.FILIAL AND
	--			ESTOQUE_MATERIAIS.FILIAL=DELETED.FILIAL AND
	--			ESTOQUE_MATERIAIS.MATERIAL=DELETED.MATERIAL AND
	--			ESTOQUE_MATERIAIS.COR_MATERIAL=DELETED.COR_MATERIAL AND
	--			ESTOQUE_SAI_MAT.EMISSAO < ESTOQUE_MATERIAIS.DATA_AJUSTE ) OR
	--	   EXISTS(SELECT *
	--		FROM	Inserted, ESTOQUE_SAI_MAT, ESTOQUE_MATERIAIS
	--		WHERE	INSERTED.REQ_MATERIAL = ESTOQUE_SAI_MAT.REQ_MATERIAL AND
 --                        INSERTED.FILIAL = ESTOQUE_SAI_MAT.FILIAL AND
	--			ESTOQUE_MATERIAIS.FILIAL=INSERTED.FILIAL AND
	--			ESTOQUE_MATERIAIS.MATERIAL=INSERTED.MATERIAL AND
	--			ESTOQUE_MATERIAIS.COR_MATERIAL=INSERTED.COR_MATERIAL AND
	--			ESTOQUE_SAI_MAT.EMISSAO < ESTOQUE_MATERIAIS.DATA_AJUSTE )

	--	BEGIN
	--		SELECT 	@errno=30002,
	--			@errmsg='Não é possível Alterar Movimentacao de Estoque de Materiais anterior ao Ajuste !'
	--		GOTO error
	--	END
	--END

/*---------------------------------------------------------------------------------------------------------------------*/
	IF UPDATE(QTDE) OR UPDATE(QTDE_AUX) OR UPDATE(PERDA)
	BEGIN

		IF EXISTS( SELECT 1 
		           FROM ESTOQUE_MAT_CONTAGEM
		                INNER JOIN ESTOQUE_MAT_CTG_ITENS ON ESTOQUE_MAT_CONTAGEM.NOME_CONTAGEM = ESTOQUE_MAT_CTG_ITENS.NOME_CONTAGEM
		                INNER JOIN INSERTED ON ESTOQUE_MAT_CONTAGEM.FILIAL = INSERTED.FILIAL AND
		                                       ESTOQUE_MAT_CTG_ITENS.MATERIAL = INSERTED.MATERIAL AND
		                                       ESTOQUE_MAT_CTG_ITENS.COR_MATERIAL = INSERTED.COR_MATERIAL
		                INNER JOIN ESTOQUE_SAI_MAT ON INSERTED.FILIAL = ESTOQUE_SAI_MAT.FILIAL AND
		                                              INSERTED.REQ_MATERIAL = ESTOQUE_SAI_MAT.REQ_MATERIAL AND
		                                              ESTOQUE_MAT_CONTAGEM.DATA_AJUSTE >= ESTOQUE_SAI_MAT.EMISSAO )
		BEGIN

			SELECT @ERRNO = 30002,
			       @ERRMSG = 'Operação cancelada, o material possui ajuste posterior a essa movimentação !'
			GOTO error

		END

	END

--#1#
 -- IF (UPDATE(CUSTO) OR UPDATE(DATA_CUSTO)) AND NOT (UPDATE(REQ_MATERIAL) OR 
	--UPDATE(FILIAL) OR 
	--UPDATE(CODIGO_FISCAL_OPERACAO) OR 
	--UPDATE(ITEM_IMPRESSAO) OR 
	--UPDATE(OF_FATURAR) OR 
	--UPDATE(PRECO_MATERIAL_EMPREGADO) OR 
	--UPDATE(PRECO_SERVICO) OR 
	--UPDATE(CONTA_CONTABIL) OR 
	--UPDATE(RATEIO_FILIAL) OR 
	--UPDATE(RATEIO_CENTRO_CUSTO) OR 
	--UPDATE(MATERIAL) OR 
	--UPDATE(COR_MATERIAL) OR 
	--UPDATE(ITEM) OR 
	--UPDATE(ORDEM_PRODUCAO) OR 
	--UPDATE(QTDE) OR 
	--UPDATE(QTDE_AUX) OR 
	--UPDATE(MATAR_SALDO_RESERVA) OR 
	--UPDATE(FILIAL_FATURAMENTO) OR 
	--UPDATE(SERIE_NF) OR 
	--UPDATE(NF_SAIDA) OR 
	--UPDATE(ICMS) OR 
	--UPDATE(IPI) OR 
	--UPDATE(DESCONTO_ITEM) OR 
	--UPDATE(PRECO) OR 
	--UPDATE(VALOR) OR 
	--UPDATE(FATOR_CONVERSAO_UNIDADE) OR 
	--UPDATE(UNIDADE_FATURAMENTO) OR 
	--UPDATE(VALOR_BRUTO) OR 
	--UPDATE(ENTREGA) OR 
	--UPDATE(PEDIDO) OR 
	--UPDATE(RESERVA_AUTOMATICA) OR 
	--UPDATE(PERDA))

	--RETURN 
--#1#	

/* ESTOQUE_SAI_MAT R/1183 ESTOQUE_SAI1_MAT ON CHILD UPDATE RESTRICT */
  if
    update(REQ_MATERIAL) or
    update(FILIAL)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,ESTOQUE_SAI_MAT
     where
           inserted.REQ_MATERIAL = ESTOQUE_SAI_MAT.REQ_MATERIAL and
           inserted.FILIAL = ESTOQUE_SAI_MAT.FILIAL
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #ESTOQUE_SAI1_MAT #porque #ESTOQUE_SAI_MAT #não existe.'
      goto error
    end
  end

/* MATERIAIS_CORES R/1130 ESTOQUE_SAI1_MAT ON CHILD UPDATE RESTRICT */
  if
    update(MATERIAL) or
    update(COR_MATERIAL)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,MATERIAIS_CORES
     where
           inserted.MATERIAL = MATERIAIS_CORES.MATERIAL and
           inserted.COR_MATERIAL = MATERIAIS_CORES.COR_MATERIAL
    
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #ESTOQUE_SAI1_MAT #porque #MATERIAIS_CORES #não existe.'
      goto error
    end
  end

/* VENDAS R/755 ESTOQUE_SAI1_MAT ON CHILD UPDATE RESTRICT */
  if
    update(PEDIDO)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,VENDAS
     where
           inserted.PEDIDO = VENDAS.PEDIDO
    select @nullcnt = count(*) from inserted where
      inserted.PEDIDO is null
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #ESTOQUE_SAI1_MAT #porque #VENDAS #não existe.'
      goto error
    end
  end

/* CTB_LX_NATUREZAS_OPERACAO R/199 ESTOQUE_SAI1_MAT ON CHILD UPDATE RESTRICT */
  if
    update(CODIGO_FISCAL_OPERACAO)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,CTB_LX_NATUREZAS_OPERACAO
     where
           inserted.CODIGO_FISCAL_OPERACAO = CTB_LX_NATUREZAS_OPERACAO.CODIGO_FISCAL_OPERACAO
    select @nullcnt = count(*) from inserted where
      inserted.CODIGO_FISCAL_OPERACAO is null
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #ESTOQUE_SAI1_MAT #porque #CTB_LX_NATUREZAS_OPERACAO #não existe.'
      goto error
    end
  end

/* M_ORDEM_FABRICACAO R/25 ESTOQUE_SAI1_MAT ON CHILD UPDATE RESTRICT */
  if
    update(OF_FATURAR)
  begin
    select @nullcnt = 0
    select @validcnt = count(*)
      from inserted,M_ORDEM_FABRICACAO
     where
           inserted.OF_FATURAR = M_ORDEM_FABRICACAO.ORDEM_FABRICACAO
    select @nullcnt = count(*) from inserted where
      inserted.OF_FATURAR is null
    if @validcnt + @nullcnt != @numrows
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #ESTOQUE_SAI1_MAT #porque #M_ORDEM_FABRICACAO #não existe.'
      goto error
    end
  end


/* ESTOQUE_SAI1_MAT R/1194 ESTOQUE_SAI_PECA ON PARENT UPDATE CASCADE */
  IF 
     update(REQ_MATERIAL) OR 
     update(MATERIAL) OR 
     update(COR_MATERIAL) OR 
     update(ITEM) OR 
     update(FILIAL)
  BEGIN
    DECLARE ESTOQUE_SAI1_MATcbcb CURSOR FOR SELECT REQ_MATERIAL,
                                                   MATERIAL,
                                                   COR_MATERIAL,
                                                   ITEM,
                                                   FILIAL FROM INSERTED
    DECLARE ESTOQUE_SAI1_MAT40bc CURSOR FOR SELECT REQ_MATERIAL,
                                                   MATERIAL,
                                                   COR_MATERIAL,
                                                   ITEM,
                                                   FILIAL FROM DELETED
    OPEN ESTOQUE_SAI1_MATcbcb
    OPEN ESTOQUE_SAI1_MAT40bc
    FETCH NEXT FROM ESTOQUE_SAI1_MATcbcb INTO @insREQ_MATERIAL,
                                              @insMATERIAL,
                                              @insCOR_MATERIAL,
                                              @insITEM,
                                              @insFILIAL
    FETCH NEXT FROM ESTOQUE_SAI1_MAT40bc INTO @delREQ_MATERIAL,
                                              @delMATERIAL,
                                              @delCOR_MATERIAL,
                                              @delITEM,
                                              @delFILIAL
    IF @@rowcount >= 0
    BEGIN
      WHILE @@fetch_status = 0
      BEGIN
        UPDATE ESTOQUE_SAI_PECA
           SET ESTOQUE_SAI_PECA.REQ_MATERIAL=@insREQ_MATERIAL,
               ESTOQUE_SAI_PECA.MATERIAL=@insMATERIAL,
               ESTOQUE_SAI_PECA.COR_MATERIAL=@insCOR_MATERIAL,
               ESTOQUE_SAI_PECA.ITEM=@insITEM,
               ESTOQUE_SAI_PECA.FILIAL=@insFILIAL
         WHERE ESTOQUE_SAI_PECA.REQ_MATERIAL = @delREQ_MATERIAL and
               ESTOQUE_SAI_PECA.MATERIAL = @delMATERIAL and
               ESTOQUE_SAI_PECA.COR_MATERIAL = @delCOR_MATERIAL and
               ESTOQUE_SAI_PECA.ITEM = @delITEM and
               ESTOQUE_SAI_PECA.FILIAL = @delFILIAL

        FETCH NEXT FROM ESTOQUE_SAI1_MATcbcb INTO @insREQ_MATERIAL,
                                                  @insMATERIAL,
                                                  @insCOR_MATERIAL,
                                                  @insITEM,
                                                  @insFILIAL
        FETCH NEXT FROM ESTOQUE_SAI1_MAT40bc INTO @delREQ_MATERIAL,
                                                  @delMATERIAL,
                                                  @delCOR_MATERIAL,
                                                  @delITEM,
                                                  @delFILIAL
      END
    END
    CLOSE ESTOQUE_SAI1_MATcbcb
    CLOSE ESTOQUE_SAI1_MAT40bc
    DEALLOCATE ESTOQUE_SAI1_MATcbcb
    DEALLOCATE ESTOQUE_SAI1_MAT40bc
  END


/*-- MOVIMENTA RESERVA PRODUCAO -----------------------------------------------------------------------*/
-- 19/09/06 SZALONTAI -  RETIRADA DE BLOCO QUE PEGAVA O FLAG "MATAR_SALDO", POIS NÃO ESTAVA VENDO VERIFICADO O STATUS  DA OP
-- 17/05/06 - SZALONTAI - ADICAO DO CAMPO FILIAL NO LINK ENTRE ESTOQUE_SAI1_MAT E ESTOQUE_SAI_MAT
-- 12/09/05 - ADICAO DA VARIAVEL @ULTIMA_SAIDA PARA ATUALIZAR O CAMPO ULTIMA_SAIDA NA TABELA PRODUCAO_RESERVA
/* Fabricio - 11/12/2004 */
IF EXISTS (SELECT ORDEM_PRODUCAO FROM INSERTED WHERE ORDEM_PRODUCAO IS NOT NULL) OR
   EXISTS (SELECT ORDEM_PRODUCAO FROM DELETED  WHERE ORDEM_PRODUCAO IS NOT NULL)
BEGIN 
	DECLARE @rORDEM_PRODUCAO 	CHAR(8),
		@rMATERIAL 		CHAR(11),
		@rCOR_MATERIAL 		CHAR(10),
		@rRESERVA_ORIGINAL 	NUMERIC(9,3),
		@rRESERVA 		NUMERIC(9,3),
		@rCONSUMIDA 		NUMERIC(9,3),
		@rDIFERENCA_PREVISAO 	NUMERIC(9,3),
		@rQTDE_SAIDA 		NUMERIC(9,3),
		@rQTDE_RET 		NUMERIC(9,3),
		@rTRANSFERENCIA_ESTOQUE	NUMERIC(9,3),
		@rVALOR_MATERIAL	NUMERIC(14,2),
		@rMATAR_SALDO		SMALLINT,
		@x1Material		CHAR(11),
		@x1CorMaterial		CHAR(10),
		@ULTIMA_SAIDA		DATETIME

	DECLARE CUR_RESERVA SCROLL CURSOR FOR
		SELECT DISTINCT PRODUCAO_RESERVA.ORDEM_PRODUCAO,PRODUCAO_RESERVA.MATERIAL,PRODUCAO_RESERVA.COR_MATERIAL
		FROM 	PRODUCAO_RESERVA 
			INNER JOIN (SELECT DISTINCT ORDEM_PRODUCAO FROM INSERTED) X 
				ON PRODUCAO_RESERVA.ORDEM_PRODUCAO=X.ORDEM_PRODUCAO 

	OPEN CUR_RESERVA

	FETCH NEXT FROM CUR_RESERVA INTO @rORDEM_PRODUCAO, @rMATERIAL, @rCOR_MATERIAL

	WHILE @@FETCH_STATUS=0
	BEGIN

		SELECT  @rRESERVA_ORIGINAL	= CONVERT(NUMERIC(9,3),SUM(RESERVA.RESERVA_ORIGINAL)),
			@rRESERVA		= CONVERT(NUMERIC(9,3),SUM(RESERVA.RESERVA)) 		,
			@rCONSUMIDA		= CONVERT(NUMERIC(9,3),SUM(RESERVA.CONSUMIDA)) 		,
			@rDIFERENCA_PREVISAO	= CONVERT(NUMERIC(9,3),SUM(RESERVA.DIFERENCA_PREVISAO)) ,
			@rQTDE_SAIDA		= CONVERT(NUMERIC(9,3),SUM(RESERVA.QTDE_SAIDA)) 	,
			@rQTDE_RET		= CONVERT(NUMERIC(9,3),SUM(RESERVA.QTDE_RET)) 		,
			@rMATAR_SALDO		= CONVERT(SMALLINT,MAX(RESERVA.MATAR_SALDO))		,
			@rVALOR_MATERIAL	= CONVERT(NUMERIC(14,2),SUM(VALOR_MATERIAL)),
			@ULTIMA_SAIDA       = MAX(ULTIMA_SAIDA)
		FROM 	(	SELECT DISTINCT PRODUCAO_RESERVA.ORDEM_PRODUCAO,PRODUCAO_RESERVA.MATERIAL,PRODUCAO_RESERVA.COR_MATERIAL,PRODUCAO_RESERVA.RESERVA_ORIGINAL,PRODUCAO_RESERVA.RESERVA,CONSUMIDA,PRODUCAO_RESERVA.DIFERENCA_PREVISAO,0 AS QTDE_SAIDA,0 AS QTDE_RET,
					CASE WHEN PRODUCAO_ORDEM.STATUS='E' OR PRODUCAO_RESERVA.MATAR_SALDO_RESERVA=1 OR COMPRAS.TOT_QTDE_ENTREGAR=0 THEN 1 ELSE 0 END AS MATAR_SALDO, 0 AS VALOR_MATERIAL,
					ULTIMA_SAIDA
				FROM PRODUCAO_RESERVA 
					LEFT JOIN PRODUCAO_ORDEM ON PRODUCAO_RESERVA.ORDEM_PRODUCAO=PRODUCAO_ORDEM.ORDEM_PRODUCAO
					LEFT JOIN COMPRAS ON PRODUCAO_RESERVA.ORDEM_PRODUCAO=COMPRAS.PEDIDO
				WHERE PRODUCAO_RESERVA.ORDEM_PRODUCAO=@rORDEM_PRODUCAO AND PRODUCAO_RESERVA.MATERIAL=@rMATERIAL AND PRODUCAO_RESERVA.COR_MATERIAL=@rCOR_MATERIAL
				UNION ALL
				SELECT ESTOQUE_RET1_MAT.ORDEM_PRODUCAO,ESTOQUE_RET1_MAT.MATERIAL,ESTOQUE_RET1_MAT.COR_MATERIAL,0,0,0,0,0,SUM(ESTOQUE_RET1_MAT.QTDE) AS QTDE_RET,MAX(CASE WHEN ESTOQUE_RET1_MAT.MATAR_SALDO_RESERVA=1 THEN 1 ELSE 0 END), -ISNULL(SUM(ESTOQUE_RET1_MAT.QTDE*CUSTO_ULT_SAIDA),0),'19900101'
				FROM ESTOQUE_RET1_MAT 
				LEFT JOIN ESTOQUE_SAI_MAT ON ESTOQUE_RET1_MAT.REQ_MATERIAL = ESTOQUE_SAI_MAT.REQ_MATERIAL_DESTINO AND
											 ESTOQUE_RET1_MAT.FILIAL = ESTOQUE_SAI_MAT.FILIAL_DESTINO AND
											 ESTOQUE_SAI_MAT.TIPO_MOVIMENTACAO = 'F'
				WHERE ESTOQUE_RET1_MAT.ORDEM_PRODUCAO=@rORDEM_PRODUCAO AND ESTOQUE_RET1_MAT.MATERIAL=@rMATERIAL AND ESTOQUE_RET1_MAT.COR_MATERIAL=@rCOR_MATERIAL AND ESTOQUE_SAI_MAT.REQ_MATERIAL IS NULL
				GROUP BY ESTOQUE_RET1_MAT.ORDEM_PRODUCAO,ESTOQUE_RET1_MAT.MATERIAL,ESTOQUE_RET1_MAT.COR_MATERIAL
				UNION ALL 
				SELECT ESTOQUE_SAI1_MAT.ORDEM_PRODUCAO,ESTOQUE_SAI1_MAT.MATERIAL,ESTOQUE_SAI1_MAT.COR_MATERIAL,0,0,0,0,SUM(ESTOQUE_SAI1_MAT.QTDE),0,MAX(CASE WHEN ESTOQUE_SAI1_MAT.MATAR_SALDO_RESERVA=1 THEN 1 ELSE 0 END),
						SUM(( CASE WHEN ISNULL(ESTOQUE_SAI1_MAT.VALOR, 0) <= 0 THEN CAST(( ( QTDE + PERDA ) * CUSTO ) AS NUMERIC(14,2)) ELSE ESTOQUE_SAI1_MAT.VALOR END )),MAX(estoque_sai_mat.EMISSAO)
				FROM ESTOQUE_SAI1_MAT 
				INNER JOIN estoque_sai_mat ON estoque_sai_mat.req_material = estoque_sai1_mat.req_material and estoque_sai_mat.filial = estoque_sai1_mat.filial
				WHERE ESTOQUE_SAI1_MAT.ORDEM_PRODUCAO=@rORDEM_PRODUCAO AND ESTOQUE_SAI1_MAT.MATERIAL=@rMATERIAL AND ESTOQUE_SAI1_MAT.COR_MATERIAL=@rCOR_MATERIAL
				GROUP BY ESTOQUE_SAI1_MAT.ORDEM_PRODUCAO,ESTOQUE_SAI1_MAT.MATERIAL,ESTOQUE_SAI1_MAT.COR_MATERIAL) RESERVA
		WHERE ORDEM_PRODUCAO=@rORDEM_PRODUCAO AND MATERIAL=@rMATERIAL AND COR_MATERIAL=@rCOR_MATERIAL

		/* 07/07/2009 - Se o flag MATAR SALDO foi marcado na saída, deve tirar, senão fica o que está na ordem de reserva. - Inicio */
		DECLARE @MATAR_SALDO_DELETED AS BIT, @MATAR_SALDO_INSERTED AS BIT

		SELECT @MATAR_SALDO_DELETED = MATAR_SALDO_RESERVA
		FROM DELETED
		WHERE ORDEM_PRODUCAO = @rORDEM_PRODUCAO AND
			  MATERIAL = @rMATERIAL AND
			  COR_MATERIAL = @rCOR_MATERIAL

		SELECT @MATAR_SALDO_INSERTED = MATAR_SALDO_RESERVA
		FROM INSERTED
		WHERE ORDEM_PRODUCAO = @rORDEM_PRODUCAO AND
			  MATERIAL = @rMATERIAL AND
			  COR_MATERIAL = @rCOR_MATERIAL

		IF @MATAR_SALDO_DELETED = 1 AND @MATAR_SALDO_INSERTED = 0
			SET @rMATAR_SALDO = 0
		ELSE IF @MATAR_SALDO_DELETED = 0 AND @MATAR_SALDO_INSERTED = 1
			SET @rMATAR_SALDO = 1
		/* 07/07/2009 - Se o flag MATAR SALDO foi marcado na saída, deve tirar, senão fica o que está na ordem de reserva. - Final */

		UPDATE PRODUCAO_RESERVA           
		SET  	CONSUMIDA  = @rQTDE_SAIDA-@rQTDE_RET,     RESERVA   = (RESERVA_ORIGINAL-(@rQTDE_SAIDA-@rQTDE_RET))*CASE WHEN @rMATAR_SALDO=1 OR (@rQTDE_SAIDA-@rQTDE_RET)>RESERVA_ORIGINAL  THEN 0 ELSE 1 END,          
		   	DIFERENCA_PREVISAO = (RESERVA_ORIGINAL-(@rQTDE_SAIDA-@rQTDE_RET))*CASE WHEN @rMATAR_SALDO=1 OR (@rQTDE_SAIDA-@rQTDE_RET)>RESERVA_ORIGINAL THEN 1 ELSE 0 END,          
		   	MATAR_SALDO_RESERVA = @rMATAR_SALDO,          
		   	VALOR_MATERIAL_CONSUMIDO = ISNULL(@rVALOR_MATERIAL,0),
			ULTIMA_SAIDA=@ULTIMA_SAIDA                  
		from     
		(    
		 SELECT Inserted.Material,Inserted.Cor_Material,Inserted.ORDEM_PRODUCAO    
		 FROM  Inserted LEFT JOIN DELETED ON Inserted.REQ_MATERIAL=DELETED.REQ_MATERIAL AND Inserted.FILIAL=DELETED.FILIAL AND Inserted.MATERIAL=Deleted.MATERIAL AND Inserted.COR_MATERIAL=DELETED.COR_MATERIAL AND Inserted.ITEM=DELETED.ITEM        
		 UNION        
		 SELECT Deleted.Material,Deleted.Cor_Material,Deleted.ORDEM_PRODUCAO    
		 FROM  Inserted RIGHT JOIN DELETED ON Inserted.REQ_MATERIAL=DELETED.REQ_MATERIAL AND Inserted.FILIAL=DELETED.FILIAL AND Inserted.MATERIAL=Deleted.MATERIAL AND Inserted.COR_MATERIAL=DELETED.COR_MATERIAL AND Inserted.ITEM=DELETED.ITEM        
		)    
		a    
		  WHERE PRODUCAO_RESERVA.ORDEM_PRODUCAO=@rORDEM_PRODUCAO AND PRODUCAO_RESERVA.MATERIAL=@rMATERIAL AND PRODUCAO_RESERVA.COR_MATERIAL=@rCOR_MATERIAL          
		and a.ordem_producao =PRODUCAO_RESERVA.ordem_producao       
		and a.material = PRODUCAO_RESERVA.material        
		and a.cor_material = PRODUCAO_RESERVA.cor_material   


		FETCH NEXT FROM CUR_RESERVA INTO @rORDEM_PRODUCAO, @rMATERIAL, @rCOR_MATERIAL
	END
	CLOSE CUR_RESERVA
	DEALLOCATE CUR_RESERVA
END
/*-----------------------------------------------------------------------------------------------------*/
/*-- LINX ---------------------------------------------------------------------------------------------------------*/

DECLARE @Status Int,@xPedido Char(12),@xMaterial Char(11),@xCor_Material Char(10),@xQtde Numeric(9,3),
	@xValor Numeric(15,5),@xNF_Saida Char(15),@xEntrega DateTime, @DIF_NF SMALLINT, @xMata_Saldo SMALLINT, @xFator SmallInt

DECLARE Cur_LXU_Estoque_Sai1_Mat SCROLL CURSOR FOR
	SELECT	Inserted.Pedido,Inserted.Material,Inserted.Cor_Material,Inserted.Entrega,CONVERT(Numeric(9,3),INSERTED.QTDE),CONVERT(Numeric(15,5),INSERTED.Valor),Inserted.NF_Saida,CONVERT(SMALLINT,CASE WHEN ISNULL(Inserted.NF_Saida,'NULO')<>ISNULL(DELETED.NF_Saida,'NULO') THEN 1 ELSE 0 END) AS DIF_NF,CONVERT(SMALLINT,INSERTED.MATAR_SALDO_RESERVA)
	FROM 	Inserted LEFT JOIN DELETED ON Inserted.REQ_MATERIAL=DELETED.REQ_MATERIAL AND Inserted.FILIAL=DELETED.FILIAL AND Inserted.MATERIAL=Deleted.MATERIAL AND Inserted.COR_MATERIAL=DELETED.COR_MATERIAL AND Inserted.ITEM=DELETED.ITEM
	UNION
	SELECT	Deleted.Pedido,Deleted.Material,Deleted.Cor_Material,Deleted.Entrega,CONVERT(Numeric(9,3),Deleted.Qtde*-1),CONVERT(Numeric(15,5),Deleted.Valor*-1),Deleted.NF_Saida,CONVERT(SMALLINT,CASE WHEN ISNULL(Inserted.NF_Saida,'NULO')<>ISNULL(DELETED.NF_Saida,'NULO') THEN 1 ELSE 0 END) AS DIF_NF,CONVERT(SMALLINT,DELETED.MATAR_SALDO_RESERVA)
	FROM 	Inserted RIGHT JOIN DELETED ON Inserted.REQ_MATERIAL=DELETED.REQ_MATERIAL AND Inserted.FILIAL=DELETED.FILIAL AND Inserted.MATERIAL=Deleted.MATERIAL AND Inserted.COR_MATERIAL=DELETED.COR_MATERIAL AND Inserted.ITEM=DELETED.ITEM

OPEN Cur_LXU_Estoque_Sai1_Mat
SELECT @Status=0
FETCH NEXT FROM Cur_LXU_Estoque_Sai1_Mat INTO @xPedido,@xMaterial,@xCor_Material,@xEntrega,@xQtde,@xValor,@xNF_Saida, @DIF_NF ,@xMata_Saldo
WHILE @@fetch_status <> -1
BEGIN

	SELECT 	@xFator=CASE WHEN @xMata_Saldo = 1 THEN 0 ELSE 1 END WHERE @XQTDE >= 0
	SELECT 	@xFator= 1, @xMata_Saldo= 0 WHERE @XQTDE < 0

	IF EXISTS ( SELECT * FROM Vendas_Material WHERE Pedido=@xPedido AND Material=@xMaterial AND Cor_Material=@xCor_Material AND Entrega=@xEntrega)
	BEGIN


		IF @xNF_Saida IS NULL
		BEGIN
			UPDATE 	VENDAS_MATERIAL
			SET	Qtde_Reservada=Qtde_Reservada+@xQtde,
				Valor_Reservado=(Qtde_Reservada+@xQtde)*(Preco-Desconto_Item)
			WHERE 	Pedido=@xPedido AND Material=@xMaterial AND Cor_Material=@xCor_Material AND Entrega=@xEntrega AND @DIF_NF=0
			UPDATE 	VENDAS_MATERIAL
			SET	Qtde_Entregar = Qtde_original - qtde_entregue - Qtde_Cancelada,
				valor_entregar = (qtde_original - qtde_entregue - Qtde_Cancelada) * (preco - desconto_item)
			WHERE 	Pedido=@xPedido AND Material=@xMaterial AND Cor_Material=@xCor_Material AND Entrega=@xEntrega and (qtde_original - qtde_entregue - Qtde_Cancelada) > 0
			UPDATE 	VENDAS_MATERIAL
			SET	Qtde_Entregar = 0,
				valor_entregar = 0
			WHERE 	Pedido=@xPedido AND Material=@xMaterial AND Cor_Material=@xCor_Material AND Entrega=@xEntrega and (qtde_original - qtde_entregue - Qtde_Cancelada) <= 0
		END

		IF @xNF_Saida IS NOT NULL
		BEGIN
			UPDATE 	VENDAS_MATERIAL
			SET	Qtde_Reservada=Qtde_Reservada-@xQtde,
				Valor_Reservado=(Qtde_Reservada-@xQtde)*(Preco-Desconto_Item),
				Qtde_Entregue=Qtde_Entregue+@xQtde,
				Valor_Entregue=(Qtde_Entregue+@xQtde)*(Preco-Desconto_Item),
				QTDE_ENTREGAR=(Qtde_Original-Qtde_Entregue-Qtde_Cancelada-@xQTDE)*@xFator,
				QTDE_CANCELADA=Qtde_Cancelada + ((Qtde_Original-Qtde_Cancelada-Qtde_Entregue-@xQTDE)*@xMata_Saldo),
				Valor_ENTREGAR=(Qtde_Original-Qtde_Entregue-Qtde_Cancelada-@xQTDE)*(Preco-Desconto_Item)*@xFator,
				Valor_CANCELADO=Valor_Cancelado + ((Qtde_Original-Qtde_Entregue-Qtde_Cancelada-@xQTDE)*(Preco-Desconto_Item)*@xMata_Saldo)
			WHERE 	Pedido=@xPedido AND Material=@xMaterial AND Cor_Material=@xCor_Material AND Entrega=@xEntrega
			UPDATE VENDAS_MATERIAL
			SET 	qtde_entregar = (qtde_original - qtde_entregue - Qtde_Cancelada)*@xFator,
				valor_entregar = (qtde_original - qtde_entregue - Qtde_Cancelada) * (preco - desconto_item)*@xFator
			WHERE 	Pedido=@xPedido AND Material=@xMaterial AND Cor_Material=@xCor_Material AND Entrega=@xEntrega and (qtde_original - qtde_entregue - Qtde_Cancelada) > 0
			UPDATE VENDAS_MATERIAL
			SET 	qtde_entregar = 0,
				valor_entregar = 0
			WHERE 	Pedido=@xPedido AND Material=@xMaterial AND Cor_Material=@xCor_Material AND Entrega=@xEntrega and (qtde_original - qtde_entregue - Qtde_Cancelada) <= 0
		END
	END

	FETCH NEXT FROM Cur_LXU_Estoque_Sai1_Mat INTO @xPedido,@xMaterial,@xCor_Material,@xEntrega,@xQtde,@xValor,@xNF_Saida, @DIF_NF,@xMata_Saldo
END
CLOSE Cur_LXU_Estoque_Sai1_Mat
DEALLOCATE Cur_LXU_Estoque_Sai1_Mat

/*---------------------------------------------------------------------------------------------------------------------*/
/*-- Atualiza Estoque MP ----------------------------------------------------------------------------------------------*/
/* Atualizacao de Estoque Materiais */

IF UPDATE(QTDE) OR UPDATE(QTDE_AUX) OR UPDATE(MATERIAL) OR UPDATE(COR_MATERIAL) OR UPDATE(FILIAL) OR UPDATE(PERDA)
  BEGIN
   
	DECLARE cur_ESTOQUE_SAI1_MAT CURSOR
	FOR
		SELECT Inserted.Material, Inserted.Cor_Material, Filial,
			CONVERT(NUMERIC(10,3),ISNULL(SUM(QTDE),0)+ISNULL(SUM(PERDA),0)), 
			CONVERT(NUMERIC(10,3),ISNULL(SUM(QTDE_AUX),0))
		FROM Inserted 
                              
		GROUP BY Inserted.Material, Inserted.Cor_Material, Filial
		UNION	
		SELECT Deleted.Material, Deleted.Cor_Material, Filial,
			CONVERT(NUMERIC(10,3),(ISNULL(SUM(QTDE),0)+ISNULL(SUM(PERDA),0))*-1), 
			CONVERT(NUMERIC(10,3),ISNULL(SUM(QTDE_AUX),0)*-1)
		FROM Deleted  
                              
		GROUP BY Deleted.Material, Deleted.Cor_Material, Filial


	OPEN cur_ESTOQUE_SAI1_MAT

	DECLARE @cMaterial Char(11), @cCor_Material Char(10), @cFilial VarChar(25), @nQtde Numeric(10,3),@nQtde_Aux Numeric(10,3)

	FETCH NEXT FROM cur_ESTOQUE_SAI1_MAT INTO @cMaterial, @cCor_Material, @cFilial, @nQtde, @nQtde_Aux

	WHILE (@@Fetch_Status != -1)
	BEGIN
		
		IF EXISTS( SELECT * FROM FILIAIS   WHERE FILIAL=@cFilial AND ISNULL(ESTOQUE_CTRL_PECA,0)=0 ) OR
   		   EXISTS( SELECT * FROM MATERIAIS WHERE MATERIAL=@cMaterial AND ISNULL(MATERIAIS.CTRL_PECAS,0) = 0 AND ISNULL(MATERIAIS.CTRL_PARTIDAS,0) = 0)
        	BEGIN
			IF EXISTS (SELECT * FROM Estoque_Materiais WHERE Material=@cMaterial AND Cor_Material=@cCor_Material AND Filial=@cFilial)
				UPDATE	Estoque_Materiais
				SET	Qtde_Estoque 		= ISNULL(Qtde_Estoque,0)	- @nQtde, 
					Qtde_Estoque_Aux 	= ISNULL(Qtde_Estoque_Aux,0)	- @nQtde_Aux, 
					Saldo_Anterior 		= Qtde_Estoque, 
					Saldo_Anterior_Aux 	= Qtde_Estoque_Aux,
					Data_Saldo_Ant		= GETDATE(),
					ULTIMA_SAIDA	= GETDATE()
				WHERE	Material=@cMaterial AND Cor_Material=@cCor_Material AND Filial=@cFilial
			ELSE
				INSERT INTO Estoque_Materiais (Material,Cor_Material,Filial,Qtde_Estoque,Qtde_Estoque_Aux,
								Saldo_Anterior,Saldo_Anterior_Aux,Data_Saldo_Ant, ULTIMA_SAIDA)
				VALUES(@cMaterial, @cCor_Material, @cFilial, @nQtde*-1,@nQtde_Aux*-1,
					0,0,GETDATE(),GETDATE())
			
			IF @@ROWCOUNT = 0
			BEGIN
				select 	@errno  = 30002,
					@errmsg = 'Operação Cancelada, Não foi Possível Atualizar #ESTOQUE_MATERIAIS#.'
				goto error
			END
		END

		FETCH NEXT FROM cur_ESTOQUE_SAI1_MAT INTO @cMaterial,@cCor_Material,@cFilial,@nQtde,@nQtde_Aux
      END


    CLOSE cur_ESTOQUE_SAI1_MAT
    DEALLOCATE cur_ESTOQUE_SAI1_MAT

END
  
/*---------------------------------------------------------------------------------------------------------------------*/
/*-- Gera Lancamento em Estoque_Ret_Mat ------------------------------------------------------------------------*/

	IF EXISTS (SELECT *
			FROM INSERTED A 
				JOIN ESTOQUE_SAI_MAT B ON B.FILIAL=A.FILIAL AND B.REQ_MATERIAL=A.REQ_MATERIAL
				JOIN FILIAIS C  ON C.FILIAL=B.FILIAL
				JOIN FILIAIS D ON D.FILIAL=B.FILIAL_DESTINO
				JOIN MATERIAIS E ON E.MATERIAL=A.MATERIAL
			WHERE (E.CTRL_PECAS = 1 OR E.CTRL_PARTIDAS = 1) AND D.ESTOQUE_CTRL_PECA = 1 AND 
				C.ESTOQUE_CTRL_PECA=0 AND B.FILIAL_DESTINO IS NOT NULL AND B.REQ_MATERIAL_DESTINO IS NOT NULL and
				(A.ORDEM_PRODUCAO IS NULL OR (A.ORDEM_PRODUCAO IS NOT NULL AND B.TIPO_MOVIMENTACAO = 'F')))
	BEGIN
			select 	@errno  = 30040,
				@errmsg = 'Nao e possivel gerar entrada Automatica. FILIAL DE DESTINO CONTROLA ESTOQUE POR PECA e Filial de Origem nao controla!!!'
			goto error
	END

	IF UPDATE(REQ_MATERIAL) OR UPDATE(FILIAL) OR UPDATE(MATERIAL) OR UPDATE(COR_MATERIAL) OR UPDATE(ITEM)
	BEGIN
		DELETE D
		FROM (DELETED A 
			JOIN ESTOQUE_SAI_MAT B ON B.REQ_MATERIAL=A.REQ_MATERIAL AND B.FILIAL=A.FILIAL
			JOIN ESTOQUE_RET_MAT C ON C.REQ_MATERIAL=B.REQ_MATERIAL_DESTINO AND C.FILIAL=B.FILIAL_DESTINO)
			LEFT JOIN ESTOQUE_RET1_MAT D ON D.REQ_MATERIAL=C.REQ_MATERIAL AND D.FILIAL=C.FILIAL AND D.MATERIAL=A.MATERIAL AND D.COR_MATERIAL=A.COR_MATERIAL AND D.ITEM=A.ITEM
		WHERE D.FILIAL IS NOT NULL AND (A.ORDEM_PRODUCAO IS NULL OR (A.ORDEM_PRODUCAO IS NOT NULL AND B.TIPO_MOVIMENTACAO = 'F'))
	END

	UPDATE C 
	SET	REQ_MATERIAL		= B.REQ_MATERIAL_DESTINO,
		FILIAL			= B.FILIAL_DESTINO,
		REQ_MATERIAL_ORIGEM	= B.REQ_MATERIAL,
		FILIAL_ORIGEM		= B.FILIAL,
		CENTRO_CUSTO		= B.CENTRO_CUSTO,
		EMISSAO			= B.EMISSAO,
		RESPONSAVEL		= B.RESPONSAVEL,
		REQUISITANTE		= B.REQUISITANTE
	FROM (INSERTED A 
		JOIN ESTOQUE_SAI_MAT B ON B.REQ_MATERIAL=A.REQ_MATERIAL AND B.FILIAL=A.FILIAL
		INNER JOIN ESTOQUE_RET_MAT C ON C.REQ_MATERIAL=B.REQ_MATERIAL_DESTINO AND C.FILIAL=B.FILIAL_DESTINO)
	WHERE B.REQ_MATERIAL_DESTINO IS NOT NULL AND B.FILIAL_DESTINO IS NOT NULL AND (A.ORDEM_PRODUCAO IS NULL OR (A.ORDEM_PRODUCAO IS NOT NULL AND B.TIPO_MOVIMENTACAO = 'F'))

	INSERT INTO ESTOQUE_RET_MAT (REQ_MATERIAL,FILIAL,TIPO_MOVIMENTACAO,REQ_MATERIAL_ORIGEM,FILIAL_ORIGEM,CENTRO_CUSTO,EMISSAO,RESPONSAVEL,REQUISITANTE,cm_operacao)
	SELECT DISTINCT B.REQ_MATERIAL_DESTINO,B.FILIAL_DESTINO,CASE WHEN B.TIPO_MOVIMENTACAO = 'C' THEN 'A' ELSE B.TIPO_MOVIMENTACAO END,B.REQ_MATERIAL,
	                B.FILIAL,B.CENTRO_CUSTO,B.EMISSAO,B.RESPONSAVEL,B.REQUISITANTE,'026'
	FROM (INSERTED A 
		JOIN ESTOQUE_SAI_MAT B ON B.REQ_MATERIAL=A.REQ_MATERIAL AND B.FILIAL=A.FILIAL
		LEFT JOIN ESTOQUE_RET_MAT C ON C.REQ_MATERIAL=B.REQ_MATERIAL_DESTINO AND C.FILIAL=B.FILIAL_DESTINO)
	WHERE B.REQ_MATERIAL_DESTINO IS NOT NULL AND B.FILIAL_DESTINO IS NOT NULL AND C.FILIAL IS NULL AND (A.ORDEM_PRODUCAO IS NULL OR (A.ORDEM_PRODUCAO IS NOT NULL AND B.TIPO_MOVIMENTACAO = 'F'))

	UPDATE D 
	SET 	ORDEM_PRODUCAO=A.ORDEM_PRODUCAO,
		QTDE=A.QTDE,
		QTDE_AUX=A.QTDE_AUX,
		CUSTO_ULT_SAIDA=A.CUSTO,
		DATA_CUSTO=A.DATA_CUSTO
	FROM (INSERTED A 
		JOIN ESTOQUE_SAI_MAT B ON B.REQ_MATERIAL=A.REQ_MATERIAL AND B.FILIAL=A.FILIAL
		JOIN ESTOQUE_RET_MAT C ON C.REQ_MATERIAL=B.REQ_MATERIAL_DESTINO AND C.FILIAL=B.FILIAL_DESTINO)
		JOIN ESTOQUE_RET1_MAT D ON D.REQ_MATERIAL=C.REQ_MATERIAL AND D.FILIAL=C.FILIAL AND D.MATERIAL=A.MATERIAL AND D.COR_MATERIAL=A.COR_MATERIAL AND D.ITEM=A.ITEM
	WHERE (A.ORDEM_PRODUCAO IS NULL OR (A.ORDEM_PRODUCAO IS NOT NULL AND B.TIPO_MOVIMENTACAO = 'F'))

	INSERT INTO ESTOQUE_RET1_MAT (REQ_MATERIAL,FILIAL,MATERIAL,COR_MATERIAL,ITEM,ORDEM_PRODUCAO,QTDE,QTDE_AUX,CUSTO_ULT_SAIDA,DATA_CUSTO)
	SELECT C.REQ_MATERIAL,C.FILIAL,A.MATERIAL,A.COR_MATERIAL,A.ITEM,A.ORDEM_PRODUCAO,A.QTDE,A.QTDE_AUX,A.CUSTO,A.DATA_CUSTO
	FROM (INSERTED A 
		JOIN ESTOQUE_SAI_MAT B ON B.REQ_MATERIAL=A.REQ_MATERIAL AND B.FILIAL=A.FILIAL
		JOIN ESTOQUE_RET_MAT C ON C.REQ_MATERIAL=B.REQ_MATERIAL_DESTINO AND C.FILIAL=B.FILIAL_DESTINO)
		LEFT JOIN ESTOQUE_RET1_MAT D ON D.REQ_MATERIAL=C.REQ_MATERIAL AND D.FILIAL=C.FILIAL AND D.MATERIAL=A.MATERIAL AND D.COR_MATERIAL=A.COR_MATERIAL AND D.ITEM=A.ITEM
	WHERE D.FILIAL IS NULL AND (A.ORDEM_PRODUCAO IS NULL OR (A.ORDEM_PRODUCAO IS NOT NULL AND B.TIPO_MOVIMENTACAO = 'F'))

/*--------------------------------------------------------------------------------------------------------------*/

  return
error:
    raiserror (@errmsg, 16, 1)
    rollback transaction
end