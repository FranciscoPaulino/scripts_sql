select * from ROMANEIOS_RESERVAS with (nolock)
where ROMANEIO='3970'

RPC:Completed	exec sp_executesql N'
UPDATE romaneios SET LIBERADO_EXPEDICAO=@P1  
WHERE ROMANEIO=@P2  AND FILIAL=@P3  AND LIBERADO_EXPEDICAO=@P4 ',N'@P1 bit,@P2 varchar(8),@P3 varchar(25),@P4 bit',1,'3969    ','DR VAREJO                ',0	Visual Linx		sa	0	38	1	1	11640	54	2016-03-10 17:41:33.000	2016-03-10 17:41:33.000	0X00000000070000001A00730070005F006500780065006300750074006500730071006C00F000000082000A0063206E007400650078007400D8000000550050004400410054004500200072006F006D0061006E00650069006F007300200053004500540020004C00490042004500	

exec sp_executesql N'UPDATE ROMANEIOS SET LIBERADO_EXPEDICAO=@P1  
WHERE ROMANEIO=@P2  AND FILIAL=@P3  AND LIBERADO_EXPEDICAO=@P4 ',N'@P1 bit,@P2 varchar(8),@P3 varchar(25),@P4 bit',1,'3970    ','DR VAREJO                ',0

select * from ROMANEIOS
WHERE ROMANEIO='3970'

UPDATE ROMANEIOS
SET LIBERADO_EXPEDICAO=1,OBS='SEGUNDA VEZ'
WHERE ROMANEIO='3970'

SELECT * FROM WMS_HOMOL.DBO.WMS_RESERVAS_PEDIDO
WHERE REPCN_RESERVA='3970'



EXECUTE PROC_WMS_RESERVAS

USE [DRLINGERIE]
GO
/****** Object:  StoredProcedure [dbo].[PROC_WMS_RESERVAS]    Script Date: 03/10/2016 17:40:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Yury Vidal>
-- Create date: <10/03/2016>
-- Description:	<executar apos gerar carteira no linx para regularizar as reservas do wms>
-- =============================================
CREATE PROCEDURE [dbo].[PROC_WMS_RESERVAS]
AS

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
     delete WMS_HOMOL.dbo.WMS_RESERVAS_PEDIDO where REPFG_STATUS_RESERVA = 'Pendente'
	
     delete WMS_HOMOL.dbo.wms_pedido where isn_pedido not in (select isn_pedido from WMS_HOMOL.dbo.WMS_RESERVAS_PEDIDO)

     delete WMS_HOMOL.dbo.WMS_ITEM_RESERVAS_PEDIDO
	

	SET NOCOUNT ON;
	--Variáveis do pedido;
	DECLARE @ISN_PED INT, @ISN_PRO INT, @TAMPROD VARCHAR(60), @ISN_CLI INT, @PEDOBS VARCHAR(MAX), @NOMECLIFOR VARCHAR(200);
	--Variáveis da reserva;
	DECLARE @ISN_RES INT;
	--Variáveis do insert
	DECLARE @RESERVA VARCHAR(20),@COR_PROD VARCHAR(60), @COD_PROD VARCHAR(60), @PEDIDO VARCHAR(20);	
	
	--Variávei da tabela de integração
	DECLARE @TAMCLN VARCHAR(20), @QTD INT;
	
	
	--Curso para percorre os itens
	DECLARE cINTEGRACAO CURSOR
	FAST_FORWARD
	FOR 
	--Seleciona os itens da nota de entrada.
	SELECT I.TAMANHO, I.QTD,I.COR_PRODUTO,I.PRODUTO,LTRIM(RTRIM(I.ROMANEIO)),LTRIM(RTRIM(I.PEDIDO)),i.NOME_CLIFOR FROM WMS_INTEGRACAO_EXP_RESERVAS_INS I with(nolock)
		WHERE I.QTD > 0;
	--Abre o cursor
	OPEN cINTEGRACAO;
	--Define os valores da primeira interação
	FETCH NEXT FROM cINTEGRACAO INTO @TAMCLN, @QTD,@COR_PROD,@COD_PROD,@RESERVA,@PEDIDO,@NOMECLIFOR
	--
	WHILE @@FETCH_STATUS = 0
	BEGIN
	 --RECUPERA O ID DO PEDIDO
		

		--Verifica se a nota fiscal já existe na base de dados
		IF not exists (SELECT ISN_PEDIDO FROM WMS_HOMOL.dbo.WMS_PEDIDO with(nolock)	WHERE PEDCN_PEDIDO = @PEDIDO)
		BEGIN
			SELECT @ISN_CLI = C.ISN_CLIENTE, @PEDOBS = V.OBS FROM CADASTRO_CLI_FOR C with(nolock)
			JOIN VENDAS V with(nolock) ON (V.CLIENTE_ATACADO = C.NOME_CLIFOR)
			WHERE NOME_CLIFOR = @NOMECLIFOR AND PEDIDO = @PEDIDO;
			
			INSERT INTO WMS_HOMOL.dbo.WMS_PEDIDO(PEDCN_PEDIDO, PEDDT_PEDIDO, ISN_CLIENTE,PEDDS_OBSERVACAO) 
			VALUES (@PEDIDO,GETDATE(), @ISN_CLI,@PEDOBS);
						
		END
			
			SELECT @ISN_PED = ISN_PEDIDO FROM WMS_HOMOL.dbo.WMS_PEDIDO with(nolock)	WHERE PEDCN_PEDIDO = @PEDIDO;

		IF not exists (SELECT RP.ISN_RESERVA_PEDIDO FROM WMS_HOMOL.dbo.WMS_RESERVAS_PEDIDO RP 	with(nolock)		
			WHERE RP.REPCN_RESERVA = @RESERVA AND RP.ISN_PEDIDO = @ISN_PED)
		BEGIN
			INSERT INTO WMS_HOMOL.dbo.WMS_RESERVAS_PEDIDO(ISN_PEDIDO, REPCN_RESERVA, REPFG_STATUS_RESERVA,REPDT_GERADO) 
			VALUES (@ISN_PED,@RESERVA, 'Pendente', GETDATE());
			
		END		

		SELECT @ISN_RES = RP.ISN_RESERVA_PEDIDO FROM WMS_HOMOL.dbo.WMS_RESERVAS_PEDIDO RP 	with(nolock)		
			WHERE RP.REPCN_RESERVA = @RESERVA AND RP.ISN_PEDIDO = @ISN_PED
		
		--Construção dinamica do select
		DECLARE @sql NVARCHAR(MAX), @params NVARCHAR(MAX), @tamanho varchar(50);
		--Define a clausula para a consulta dinamica.
		set @sql = N'SELECT @tamOUT = '+ @TAMCLN +' FROM PRODUTOS LP with(nolock)
		JOIN PRODUTOS_TAMANHOS LT with(nolock) ON (LP.GRADE = LT.GRADE)
		WHERE LP.PRODUTO = @codprod and LP.GRUPO_PRODUTO <>''VAREJO-MERCHANDISING'''
		--Define os parametros do sql dinamico
		set @params = N'@tamOUT varchar(15) output, @codprod varchar(50)';
		--Executa o sql feito dinamicamente
		EXECUTE SP_EXECUTESQL @sql, @params, @tamOUT = @tamanho output, @codprod = @COD_PROD; 			
		
		
		--Recupera o isn do produto baseado na cor, tamanho e codigo do produto.
		SELECT @ISN_PRO = P.ISN_PRODUTO FROM WMS_HOMOL.dbo.WMS_PRODUTO P with(nolock)
		JOIN WMS_HOMOL.dbo.WMS_CORES C with(nolock) ON (P.PRONR_COR = C.ISN_COR)
		WHERE P.PRODS_TAM = @tamanho and C.CORNR_COR = @COR_PROD and p.PROCC_PRODUTO = @COD_PROD;


		--insere os itens da nota de entrada.		
		IF NOT EXISTS(SELECT IRP.ISN_RESERVA_PEDIDO FROM WMS_HOMOL.dbo.WMS_ITEM_RESERVAS_PEDIDO IRP  with(nolock)			
			WHERE IRP.ISN_PRODUTO = @ISN_PRO AND IRP.ISN_RESERVA_PEDIDO = @ISN_RES)
		BEGIN 
			INSERT INTO WMS_HOMOL.dbo.WMS_ITEM_RESERVAS_PEDIDO(ISN_RESERVA_PEDIDO, ISN_PRODUTO, IRPQT_QUANTIDADE)
			VALUES(@ISN_RES, @ISN_PRO, @QTD);
		END;

	    --Próximo regitro da interação
		FETCH NEXT FROM cINTEGRACAO INTO @TAMCLN, @QTD,@COR_PROD,@COD_PROD,@RESERVA,@PEDIDO,@NOMECLIFOR	
	END
	--Finaliza o cursor
	CLOSE cINTEGRACAO;	
	DEALLOCATE cINTEGRACAO;

