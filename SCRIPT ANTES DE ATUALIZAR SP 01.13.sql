-- Dica: O service pack cria uma pasta dentro do diretorio linx\imagens 
-- que está instalando chamado \LinxServicePack, fazer a cópia da pasta antes do OK na tela de erro.

-- apagar constraint
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[XFK2328LJ_NOTA_FISCAL_DESCARTADA]') AND parent_object_id = OBJECT_ID(N'[dbo].[LJ_NOTA_FISCAL_DESCARTADA]'))
ALTER TABLE [dbo].[LJ_NOTA_FISCAL_DESCARTADA] DROP CONSTRAINT [XFK2328LJ_NOTA_FISCAL_DESCARTADA]
GO

-- apagar coluna id_excecao_imposto
ALTER TABLE CADASTRO_CLI_FOR DROP COLUMN ID_EXCECAO_IMPOSTO

/****** Object:  Default [dbo].[DATA_ATUAL]    Script Date: 05/02/2013 16:11:53 ******/ 
CREATE DEFAULT [dbo].[DATA_ATUAL] AS GETDATE() 
 



