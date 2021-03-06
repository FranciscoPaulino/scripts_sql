USE [DRVAREJO]
GO

/****** Object:  UserDefinedFunction [dbo].[Qtde_Tamanho_VE]    Script Date: 07/24/2012 16:59:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[Qtde_Tamanho_EE] (@produto varchar(10),@cor_produto varchar(10),@tamanho char(2),@data_ini CHAR(10), @data_fin CHAR(10))  
RETURNS int  
WITH EXECUTE AS CALLER  
AS  
BEGIN  
     DECLARE @Retorno int  
     IF (LTRIM(@tamanho)='1')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_1)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='2')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_2)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='3')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_3)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='4')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_4)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='5')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_5)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='6')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_6)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='7')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_7)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='8')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_8)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='9')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_9)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='10')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_10)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='11')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_11)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='12')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_12)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='13')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_13)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='14')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_14)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='15')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_15)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     IF (LTRIM(@tamanho)='16')  
      SET @Retorno = (
            SELECT SUM(ESTOQUE_PROD1_ENT.EN_16)
			FROM DBO.ESTOQUE_PROD1_ENT ESTOQUE_PROD1_ENT, DBO.ESTOQUE_PROD_ENT ESTOQUE_PROD_ENT
			WHERE ESTOQUE_PROD1_ENT.PRODUTO=@PRODUTO AND ESTOQUE_PROD1_ENT.COR_PRODUTO=@COR_PRODUTO AND  ESTOQUE_PROD_ENT.EMISSAO >= @DATA_INI AND ESTOQUE_PROD_ENT.EMISSAO <= @DATA_FIN AND ESTOQUE_PROD1_ENT.FILIAL = 'DR VAREJO' AND  
			ESTOQUE_PROD_ENT.ROMANEIO_PRODUTO = ESTOQUE_PROD1_ENT.ROMANEIO_PRODUTO AND	ESTOQUE_PROD_ENT.FILIAL = ESTOQUE_PROD1_ENT.FILIAL 
			GROUP BY ESTOQUE_PROD_ENT.EMISSAO, ESTOQUE_PROD1_ENT.PRODUTO, ESTOQUE_PROD1_ENT.COR_PRODUTO 
         )  
     RETURN(@Retorno)  
END;  

GO


