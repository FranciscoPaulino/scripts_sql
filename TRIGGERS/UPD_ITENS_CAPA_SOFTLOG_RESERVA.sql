USE [DRLINGERIE]
GO

/****** Object:  Trigger [dbo].[UPD_ITENS_CAPA_SOFTLOG_RESERVA]    Script Date: 03/08/2016 08:20:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[UPD_ITENS_CAPA_SOFTLOG_RESERVA] ON [dbo].[VENDAS_PROD_EMBALADO]
FOR UPDATE 
AS
BEGIN 
  BEGIN TRY
	SET NOCOUNT ON;
	--Variáveis do pedido;
	DECLARE @ISN_PED INT, @ISN_PRO INT, @TAMPROD VARCHAR(60), @ISN_CLI INT, @PEDOBS VARCHAR(MAX);
	--Variáveis da reserva;
	DECLARE @ISN_RES INT;
	--Variáveis do insert
	DECLARE @RESERVA VARCHAR(20),@COR_PROD VARCHAR(60), @COD_PROD VARCHAR(60), @PEDIDO VARCHAR(60);	
	
	--Variávei da tabela de integração
	DECLARE @TAMCLN VARCHAR(20), @QTD INT;
	
	SELECT @COR_PROD = INS.COR_PRODUTO, @COD_PROD = INS.PRODUTO, @RESERVA = LTRIM(RTRIM(INS.ROMANEIO)),
	@PEDIDO = LTRIM(RTRIM(INS.PEDIDO))
	FROM INSERTED INS where ins.CAIXA is null;

	--insert into softlogwms.dbo.wms_teste ( TEMP1VAR, TEMP2VAR,TEMP3VAR,TEMP4VAR) values(@PEDIDO,@RESERVA,@COR_PROD,@COD_PROD)
	
	--Curso para percorre os itens
	DECLARE cINTEGRACAO CURSOR
	FAST_FORWARD
	FOR 
	--Seleciona os itens da nota de entrada.
	SELECT I.TAMANHO, I.QTD FROM WMS_INTEGRACAO_EXP_RESERVAS I
		WHERE I.RESERVA = @RESERVA AND I.PRODUTO = @COD_PROD AND I.COR_PRODUTO = @COR_PROD and PEDIDO =@PEDIDO; 
	--Abre o cursor
	OPEN cINTEGRACAO;
	--Define os valores da primeira interação
	FETCH NEXT FROM cINTEGRACAO INTO @TAMCLN, @QTD
	--
	WHILE @@FETCH_STATUS = 0
	BEGIN

	    	--RECUPERA O ID DO PEDIDO
		SELECT @ISN_PED = ISN_PEDIDO FROM softlogwms.dbo.WMS_PEDIDO with(nolock)	WHERE PEDCN_PEDIDO = @PEDIDO;

		--Recupera o id da reserva
		SELECT @ISN_RES = RP.ISN_RESERVA_PEDIDO, @ISN_PED = ISN_PEDIDO FROM softlogwms.dbo.WMS_RESERVAS_PEDIDO RP
		WHERE REPCN_RESERVA = @RESERVA AND ISN_PEDIDO = @ISN_PED;	
	
		
		--Construção dinamica do select
		DECLARE @sql NVARCHAR(MAX), @params NVARCHAR(MAX), @tamanho varchar(50);
		--Define a clausula para a consulta dinamica.
		set @sql = N'SELECT @tamOUT = '+ @TAMCLN +' FROM PRODUTOS LP
		JOIN PRODUTOS_TAMANHOS LT ON (LP.GRADE = LT.GRADE)
		WHERE LP.PRODUTO = @codprod and LP.GRUPO_PRODUTO <>''MERCHANDISING'''
		--Define os parametros do sql dinamico
		set @params = N'@tamOUT varchar(15) output, @codprod varchar(50)';
		--Executa o sql feito dinamicamente
		EXECUTE SP_EXECUTESQL @sql, @params, @tamOUT = @tamanho output, @codprod = @COD_PROD; 			
		--Recupera o isn do produto baseado na cor, tamanho e codigo do produto.
		
		SELECT @ISN_PRO = P.ISN_PRODUTO FROM softlogwms.dbo.WMS_PRODUTO P
		JOIN softlogwms.dbo.WMS_CORES C ON (P.PRONR_COR = C.ISN_COR)
		WHERE P.PRODS_TAM = @tamanho and C.CORNR_COR = @COR_PROD and p.PROCC_PRODUTO = @COD_PROD;
		--insere os itens da nota de entrada.		

	    

		IF NOT EXISTS(SELECT IRP.ISN_RESERVA_PEDIDO FROM softlogwms.dbo.WMS_ITEM_RESERVAS_PEDIDO IRP 			
			WHERE IRP.ISN_PRODUTO = @ISN_PRO AND IRP.ISN_RESERVA_PEDIDO = @ISN_RES)
		BEGIN 
		  IF(@QTD >0)
			BEGIN
			  --insert into softlogwms.dbo.wms_teste ( TEMP1VAR, TEMP2VAR, TEMP3VAR) values(@ISN_PRO,@ISN_RES,@QTD)
			  INSERT INTO softlogwms.dbo.WMS_ITEM_RESERVAS_PEDIDO(ISN_RESERVA_PEDIDO, ISN_PRODUTO, IRPQT_QUANTIDADE)
			  VALUES(@ISN_RES, @ISN_PRO, @QTD);
			END
		END
		ELSE
	   	BEGIN
	       IF(@QTD =0)
			BEGIN
			 
			    --Chave cascade
				DELETE softlogwms.dbo.WMS_ITEM_RESERVAS_PEDIDO WHERE ISN_RESERVA_PEDIDO = @ISN_RES and ISN_PRODUTO = @ISN_PRO

				IF((SELECT COUNT(ISN_RESERVA_PEDIDO) FROM softlogwms.dbo.WMS_ITEM_RESERVAS_PEDIDO WHERE ISN_RESERVA_PEDIDO = @ISN_RES) = 0 )
				BEGIN
					DELETE softlogwms.dbo.WMS_RESERVAS_PEDIDO WHERE  ISN_RESERVA_PEDIDO = @ISN_RES
				END
			END
			ELSE
			BEGIN
				UPDATE softlogwms.dbo.WMS_ITEM_RESERVAS_PEDIDO SET IRPQT_QUANTIDADE = @QTD
				WHERE ISN_RESERVA_PEDIDO = @ISN_RES AND ISN_PRODUTO = @ISN_PRO
			END
		END
		
		--Próximo regitro da interação
		FETCH NEXT FROM cINTEGRACAO INTO @TAMCLN, @QTD	
	END
	--Finaliza o cursor
	CLOSE cINTEGRACAO;	
	DEALLOCATE cINTEGRACAO;
  END TRY
		BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT @ErrorMessage = ERROR_MESSAGE(),
		@ErrorSeverity = ERROR_SEVERITY(),
		@ErrorState = ERROR_STATE();

		RAISERROR (@ErrorMessage,
		@ErrorSeverity,
		@ErrorState) 
   END CATCH
END

GO


