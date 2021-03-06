USE [TESTES]
GO
/****** Object:  Trigger [dbo].[LDR_TD_PRODUCAO_ORDEM]    Script Date: 02/24/2014 14:30:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Trigger [dbo].[LDR_TD_PRODUCAO_ORDEM] On [dbo].[PRODUCAO_ORDEM]
For DELETE NOT FOR REPLICATION
As 
-- DELETE Trigger On PRODUCAO_ORDEM
Begin
	Declare	@numrows Int,
		@nullcnt Int,
		@validcnt Int,
		@delORDEM_PRODUCAO char(8) ,
		@errno Int,
		@errmsg varchar(255)

	Select @numrows = @@rowcount



--- excluir ordem de produção do controle de aviamentos 
    SELECT @delORDEM_PRODUCAO=ORDEM_PRODUCAO FROM deleted
    DELETE FROM LDR_PRODUCAO_ORDEM_AVIAMENTOS WHERE ORDEM_PRODUCAO=@delORDEM_PRODUCAO
--- fim

	return
Error:
	raiserror @errno @errmsg
	rollback transaction
End

