drop ASSEMBLY FuncoesSql

-- CRIA O ASSEMBLY INDICANDO SUA ORIGEM
create ASSEMBLY FuncoesSql FROM 'C:\CSqlDlls\FuncoesSQLServerASPNET.dll'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

drop function dbo.Fun_Valida_Mail
-- CRIA A FUN플O
CREATE FUNCTION dbo.Fun_Valida_Mail (@email NVARCHAR(350))
RETURNS BIT
-- INDICA A ORIGEM DA FUN플O SQL: ASSEMBLY > CLASSE > FUN플O
AS EXTERNAL NAME [FuncoesSql].FuncoesSql.IsMailValido
GO 

-- CRIA A FUN플O
CREATE FUNCTION dbo.Fun_Consulta_CNPJ (@cnpj NVARCHAR(30))
RETURNS BIT
-- INDICA A ORIGEM DA FUN플O SQL: ASSEMBLY > CLASSE > FUN플O
AS EXTERNAL NAME [FuncoesSql].FuncoesSql.BuscaCNPJ
GO 




SELECT dbo.Fun_Valida_Mail('tmarcal@gmail')
SELECT dbo.Fun_Valida_Mail('tmarcal@gmail.com')
SELECT dbo.Fun_Valida_Mail('tmarcal.. @gmail.com') 
SELECT dbo.Fun_Valida_Mail('eli@grazziotin,com.br')

SELECT CLIFOR,NOME_CLIFOR,EMAIL,dbo.Fun_Valida_Mail(LTRIM(RTRIM(EMAIL))) 
FROM CADASTRO_CLI_FOR
WHERE dbo.Fun_Valida_Mail(LTRIM(RTRIM(EMAIL)))=0 AND year(CADASTRAMENTO)=2014 and PJ_PF=1


UPDATE CADASTRO_CLI_FOR
SET EMAIL='nfe@ldr.ind.br',EMAIL_NFE='nfe@ldr.ind.br'
WHERE dbo.Fun_Valida_Mail(LTRIM(RTRIM(EMAIL)))=0 AND year(CADASTRAMENTO)=2014 and PJ_PF=1
