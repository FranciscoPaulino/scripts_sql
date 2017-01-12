USE [TESTES]
GO

/****** Object:  Trigger [dbo].[LDR_TI_PRODUCAO_ORDEM]    Script Date: 02/24/2014 14:26:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Trigger [dbo].[LDR_TI_PRODUCAO_ORDEM] 
On [dbo].[PRODUCAO_ORDEM]
For INSERT NOT FOR REPLICATION
As 
-- INSERT Trigger On PRODUCAO_ORDEM
Begin
	Declare	@numrows	Int,
		@nullcnt	Int,
		@validcnt	Int,
		@insORDEM_PRODUCAO char(8) , 
		@errno   Int,
		@errmsg  varchar(255)

	Select @numrows = @@rowcount

--- incluir ordem de produção para fazer o controle de aviamentos 
    SELECT @insORDEM_PRODUCAO=ORDEM_PRODUCAO FROM inserted
    INSERT INTO LDR_PRODUCAO_ORDEM_AVIAMENTOS (ORDEM_PRODUCAO) VALUES(@insORDEM_PRODUCAO)
--- fim
	return
Error:
	raiserror @errno @errmsg
	rollback transaction
End


GO


