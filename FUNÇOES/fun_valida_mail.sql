USE [DRLINGERIE]
GO
/****** Object:  UserDefinedFunction [dbo].[Fun_Valida_Mail]    Script Date: 18/04/2017 16:58:56 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create FUNCTION [dbo].[Fun_Valida_Mail](@email [nvarchar](350))
RETURNS [bit] WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [FuncoesSql].[FuncoesSql].[IsMailValido]


CREATE ASSEMBLY FuncoesSql FROM 'C:\CSqlDlls\FuncoesSQLServerASPNET.dll'


