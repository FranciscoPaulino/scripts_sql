USE WISEMAN

UPDATE PARAMETROS
SET VALOR_ATUAL='3.10'
WHERE PARAMETRO='VERSAO_LAYOUT_XML_NFE'
GO
UPDATE PARAMETROS
SET VALOR_ATUAL='\SCHEMA\NFE_V3.10.XSD'
WHERE PARAMETRO='PASTA_SCHEMA_XML_NFE'
GO
UPDATE PARAMETROS
SET VALOR_ATUAL='\SCHEMA\SEFAZ\NFE_V3.10.XSD'
WHERE PARAMETRO='PASTA_SCHEMA_XML_NFE_SEFA'
GO
UPDATE PARAMETROS
SET VALOR_ATUAL='SP'
WHERE PARAMETRO='UF_SERVIDOR_SQL'
GO
