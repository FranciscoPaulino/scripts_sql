USE [DESENV]
GO
/****** Object:  Trigger [dbo].[LDR_TI_CTB_A_RECEBER_MOV]    Script Date: 12/17/2014 16:55:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[LDR_TI_CTB_A_RECEBER_MOV] ON [dbo].[CTB_A_RECEBER_MOV]
AFTER INSERT NOT FOR REPLICATION
AS 

Begin
	Declare	@numrows		Int,
		@nullcnt			Int,
		@validcnt			Int,
		@insEMPRESA			int, 
		@insLANCAMENTO		int, 
		@insITEM			smallint, 
		@insID_PARCELA		char(2), 
		@insLANCAMENTO_MOV	int, 
		@insITEM_MOV		smallint, 
		@errno				Int,
		@errmsg				varchar(255),
		@ID_CRED_ACORDO		INT

	Select @numrows = @@rowcount

/*--CALCULA VALOR_A_RECEBER----------------------------------------------------------------------------------*/
-- 16/01/2005 - JOAO RICARDO - INCLUIDO A DATA PARA TRANSFERENCIA NO UPDATE
	BEGIN
		UPDATE A
		SET A.VALOR_MOV=E.VALOR_MOV+E.DESCONTO_EFETIVADO_PADRAO, A.VALOR_MOV_PADRAO=E.VALOR_MOV+E.DESCONTO_EFETIVADO_PADRAO
		FROM CTB_A_RECEBER_MOV A, INSERTED E     		
		WHERE A.LANCAMENTO=E.LANCAMENTO AND A.ITEM_MOV=E.ITEM_MOV AND A.ITEM=E.ITEM AND A.ID_PARCELA=E.ID_PARCELA
	END	

    FROM CTB_LANCAMENTO_ITEM A, INSERTED B
    WHERE A.LANCAMENTO=E.LANCAMENTO AND A.ITEM_MOV=E.ITEM_MOV AND A.ITEM=E.ITEM AND A.ID_PARCELA=E.ID_PARCELA
    	
	return
Error:
	raiserror @errno @errmsg
	rollback transaction
End

