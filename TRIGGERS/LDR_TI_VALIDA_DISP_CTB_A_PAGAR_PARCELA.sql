USE [DRVAREJO]
GO
/****** Object:  Trigger [dbo].[LDR_TI_VALIDA_DISP_CTB_A_PAGAR_PARCELA]    Script Date: 05/07/2013 08:42:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create trigger [dbo].[LDR_TI_CTB_A_PAGAR_PARCELA] on [dbo].[CTB_A_PAGAR_PARCELA] for INSERT NOT FOR REPLICATION as
BEGIN
    DECLARE  @NULLCNT INT,
             @VALIDCNT INT,
             @NUMROWS INT,
             @errno int,
             @errmsg varchar(255),
             @qtdeRecno INT,
             @qtdeRecMAR INT,
             @qtdeRecABR INT,
             @qtdeRecJUN INT,
             @qtdeRecNOV INT,
             @qtdeRecDEZ INT

    select @numrows = @@rowcount

-- CODIGO A ACRESCENTAR NAS TRIGGER CONTAS A PAGAR

--FLUXO_CAIXA_LDR
	IF	UPDATE(VALOR_ORIGINAL)
    declare @vencimento datetime,@valor_original numeric(19,2)

	Begin
        -- seleciona o valor que esta sendo inserido
        SELECT @valor_original = Inserted.valor_original, @vencimento = vencimento
        FROM Inserted

  --      -- verificacao da data no periodo de rescesso CARNAVAL
		--SELECT @qtdeRecMAR = count(*)
		--FROM COTA_LIMITE_COMPRA --FLUXO_CAIXA_LDR_CONTROLE
		--WHERE VENCIMENTO = @VENCIMENTO AND NOT (vencimento BETWEEN '20110307' AND '20110310') 

  --      -- verificacao da data no periodo de rescesso TIRADENTES
		--SELECT @qtdeRecABR = count(*)
		--FROM COTA_LIMITE_COMPRA --FLUXO_CAIXA_LDR_CONTROLE
		--WHERE VENCIMENTO = @VENCIMENTO AND NOT (vencimento BETWEEN '20110421' AND '20110424') 

  --      -- verificacao da data no periodo de rescesso CORPUS-CRISTI
		--SELECT @qtdeRecJUN = count(*)
		--FROM COTA_LIMITE_COMPRA --FLUXO_CAIXA_LDR_CONTROLE
		--WHERE VENCIMENTO = @VENCIMENTO AND NOT (vencimento BETWEEN '20110421' AND '20110424') 

        -- verificacao da data no periodo de rescesso
		SELECT @qtdeRecDEZ = count(*)
		FROM COTA_LIMITE_COMPRA --FLUXO_CAIXA_LDR_CONTROLE
		WHERE VENCIMENTO = @VENCIMENTO AND ((vencimento BETWEEN '20131214' AND '20140103') or
		                                    (vencimento BETWEEN '20141214' AND '20150103'))

        -- testa se data esta no periodo de rescesso ou feriado
		If @qtdeRecDEZ > 0
		Begin
			Select	@errno  = 30002,
				@errmsg = 'Impossível Incluir #CTB_A_PAGAR_PARCELA #porque #COTA_LIMITE_COMPRA# esta no periodo de rescesso ou feriado, sem disponibilidade financeira.'
			GoTo Error
		End

        -- verificacao da disponibilidade de valor na data 
		SELECT @qtdeRecno = count(*)
		FROM COTA_LIMITE_COMPRA --FLUXO_CAIXA_LDR_CONTROLE
		WHERE VENCIMENTO = @VENCIMENTO AND (VALOR_DISPONIVEL >= @valor_original) 

        -- testa se existe disponibilidade financeira
		If @qtdeRecno=0
		Begin
			Select	@errno  = 30002,
				@errmsg = 'Impossível Incluir #CTB_A_PAGAR_PARCELA #porque #COTA_LIMITE_COMPRA# não existe disponibilidade financeira.'
			GoTo Error
		End        
	End
    return
error:
    raiserror @errno @errmsg
    rollback transaction
END

