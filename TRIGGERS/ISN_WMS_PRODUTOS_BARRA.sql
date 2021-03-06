USE [DRLINGERIE]
GO
/****** Object:  Trigger [dbo].[ISN_WMS_PRODUTOS_BARRA]    Script Date: 25/04/2017 14:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[ISN_WMS_PRODUTOS_BARRA] ON [dbo].[PRODUTOS_BARRA]
	FOR INSERT not for replication
	AS
	BEGIN
		SET NOCOUNT ON
		
		DECLARE @CODPROD VARCHAR(20), @COD_COR varchar(15), @DESC_TAMANHO VARCHAR(15), @ISN_COR INT, @ISN_PRO INT,
		@ISN_BARRA INT,@CODIGO_BARRA_PADRAO bit, @CODIGO_BARRA varchar(100);

		--Obtém os dados do insert
		SELECT @CODPROD = I.PRODUTO, @COD_COR = I.COR_PRODUTO, @DESC_TAMANHO = I.GRADE,
		@ISN_BARRA = I.ISN_BARRA, @CODIGO_BARRA_PADRAO = CODIGO_BARRA_PADRAO, @CODIGO_BARRA = CODIGO_BARRA FROM INSERTED I	
			
		
		---Insere produtos----------------------------------------------------------------------------------------------------------------------------------------

		--Seleciona o id da cor
		SELECT @ISN_COR = C.ISN_COR FROM  LKD65.SOFTLOGWMS.DBO.WMS_CORES C WHERE C.CORNR_COR = @COD_COR;					
		--Caso o produto não exista, ele é inserido na tabela de produto do WMS.
		IF NOT EXISTS
		(
--									[ LKD65.SOFTLOGWMS.DBO.]		
			SELECT ISN_PRODUTO FROM  LKD65.SOFTLOGWMS.DBO.WMS_PRODUTO
			WHERE PRONR_COR = @ISN_COR AND PRODS_TAM = @DESC_TAMANHO AND PRONR_AUXILIAR = @CODPROD
		)
		BEGIN 
		    --Insere o produto na tabela do WMS.
			INSERT INTO  LKD65.SOFTLOGWMS.DBO.WMS_PRODUTO(PROCC_PRODUTO, PRONR_AUXILIAR, PRONR_COR, PRODS_TAM, PRODS_PRODUTO, PROFG_USO, PROFG_TIPO_PRODUTO, PROFG_PESO_PADRAO,prods_partnumber,profg_flowrack)
			SELECT TOP 1 @CODPROD, @CODPROD, @ISN_COR, @DESC_TAMANHO, DESC_PRODUTO, 'S', 'AC', 'S',('AC'+@CODPROD+@COD_COR+'000'+@DESC_TAMANHO),'S' FROM PRODUTOS WITH (NOLOCK)
			WHERE PRODUTO = @CODPROD;						
		END
		-------------------------------------------------------------------------------------------------------------------------------------------------------------
		-----Insere Tamanho-------------------------------------------------------------------------------------------------------------------------------------------------
		IF NOT EXISTS(
			SELECT ISN_TAM_PRODUTO FROM  LKD65.SOFTLOGWMS.DBO.WMS_TAMANHO_PRODUTO
			WHERE TPRDS_TAMANHO = @DESC_TAMANHO AND TPRNR_PRODUTO = @CODPROD
		)
		BEGIN 
			INSERT INTO  LKD65.SOFTLOGWMS.DBO.WMS_TAMANHO_PRODUTO(TPRDS_TAMANHO, TPRNR_PRODUTO)
			VALUES(@DESC_TAMANHO, @CODPROD);
		END;
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		-----Insere Cor----------------------------------------------------------------------------------------------------------------------------------------------------
		IF NOT EXISTS(
		--							    [ LKD65.SOFTLOGWMS.DBO.]
			SELECT ISN_COR_PRODUTO FROM  LKD65.SOFTLOGWMS.DBO.WMS_COR_PRODUTO
			WHERE ISN_COR  = @ISN_COR AND CPRNR_PRODUTO = @CODPROD
		)
		BEGIN 
		--              [ LKD65.SOFTLOGWMS.DBO.]
			INSERT INTO  LKD65.SOFTLOGWMS.DBO.WMS_COR_PRODUTO(CPRNR_PRODUTO, ISN_COR)
			VALUES(@CODPROD, @ISN_COR);
		END;
		------------------------------------------------------------------------------------------------------------------------------------------------------------

		---Pega o novo Isn do produto-
		SELECT @ISN_PRO = ISN_PRODUTO FROM  LKD65.SOFTLOGWMS.DBO.WMS_PRODUTO
		WHERE PRONR_COR = @ISN_COR AND PRONR_AUXILIAR = @CODPROD AND PRODS_TAM = @DESC_TAMANHO;
		--Associa o código de barras ao produto inserido.
		UPDATE PRODUTOS_BARRA SET
		ISN_PRODUTO = @ISN_PRO,
		ISN_COR = @ISN_COR
		WHERE ISN_BARRA = @ISN_BARRA;




	    		-------------------------------NOVO BANCO---------------------------------------------------------------------------------------------------------------------

		---Insere produtos----------------------------------------------------------------------------------------------------------------------------------------
	
		--Seleciona o id da cor
		SELECT @ISN_COR = C.ISN_COR FROM  LKD65.SOFTLOGWMS.dbo.WMS_CORES C WHERE C.CORNR_COR = @COD_COR;					
		--Caso o produto não exista, ele é inserido na tabela de produto do WMS.
		IF NOT EXISTS
		(
			SELECT ISN_PRODUTO FROM  LKD65.SOFTLOGWMS.dbo.WMS_PRODUTO	WHERE PRONR_COR = @ISN_COR AND PRODS_TAM = @DESC_TAMANHO AND PRONR_AUXILIAR = @CODPROD
		)
		BEGIN 
		    --Insere o produto na tabela do WMS.
			INSERT INTO  LKD65.SOFTLOGWMS.dbo.WMS_PRODUTO(PROCC_PRODUTO, PRONR_AUXILIAR, PRONR_COR, PRODS_TAM, PRODS_PRODUTO, PROFG_USO, PROFG_TIPO_PRODUTO, PROFG_PESO_PADRAO,prods_partnumber,profg_flowrack)
			SELECT TOP 1 @CODPROD, @CODPROD, @ISN_COR, @DESC_TAMANHO, DESC_PRODUTO, 'S', 'AC', 'S',('AC'+@CODPROD+@COD_COR+'000'+@DESC_TAMANHO),'N' FROM PRODUTOS WITH(NOLOCK)
			WHERE PRODUTO = @CODPROD;						
		END
		-------------------------------------------------------------------------------------------------------------------------------------------------------------
		-----Insere Tamanho-------------------------------------------------------------------------------------------------------------------------------------------------
		IF NOT EXISTS(
			SELECT ISN_TAM_PRODUTO FROM  LKD65.SOFTLOGWMS.dbo.WMS_TAMANHO_PRODUTO	WHERE TPRDS_TAMANHO = @DESC_TAMANHO AND TPRNR_PRODUTO = @CODPROD
		)
		BEGIN 
			INSERT INTO  LKD65.SOFTLOGWMS.dbo.WMS_TAMANHO_PRODUTO(TPRDS_TAMANHO, TPRNR_PRODUTO) VALUES (@DESC_TAMANHO, @CODPROD);
		END;
		------------------------------------------------------------------------------------------------------------------------------------------------------------
		-----Insere Cor----------------------------------------------------------------------------------------------------------------------------------------------------
		IF NOT EXISTS(
			SELECT ISN_COR_PRODUTO FROM  LKD65.SOFTLOGWMS.dbo.WMS_COR_PRODUTO WHERE ISN_COR  = @ISN_COR AND CPRNR_PRODUTO = @CODPROD
		)
		BEGIN 
			INSERT INTO  LKD65.SOFTLOGWMS.dbo.WMS_COR_PRODUTO(CPRNR_PRODUTO, ISN_COR) VALUES (@CODPROD, @ISN_COR);
		END;
		------------------------------------------------------------------------------------------------------------------------------------------------------------

		IF NOT EXISTS(
			SELECT ISN_BARRA FROM  LKD65.SOFTLOGWMS.dbo.wms_barra WHERE CODIGO_BARRA = @CODIGO_BARRA
		)
		BEGIN 
			---Pega o novo Isn do produto-
			SELECT @ISN_PRO = ISN_PRODUTO FROM  LKD65.SOFTLOGWMS.dbo.WMS_PRODUTO WHERE PRONR_COR = @ISN_COR AND PRONR_AUXILIAR = @CODPROD AND PRODS_TAM = @DESC_TAMANHO;
		
			insert into  LKD65.SOFTLOGWMS.dbo.wms_barra (ISN_PRODUTO,CODIGO_BARRA, ISN_COR, CODIGO_BARRA_PADRAO,GRADE,barqt_multiplicador,barqt_cubagem)
			values (@ISN_PRO,@CODIGO_BARRA, @ISN_COR,@CODIGO_BARRA_PADRAO,@DESC_TAMANHO,1,0.00001)	
		END;
		
	END
