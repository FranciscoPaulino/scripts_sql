CREATE trigger [dbo].[DR_TU_CTB_A_PAGAR_PARCELA] on [dbo].[CTB_A_PAGAR_PARCELA] 
FOR UPDATE  NOT FOR REPLICATION as
BEGIN
    DECLARE  @NULLCNT INT,
             @VALIDCNT INT,
             @NUMROWS INT,
             @errno int,
             @errmsg varchar(255),
             @epgto int,
			 @periodo_folha_pgto char(1),
			 @valor_disponivel numeric(18,2),
			 @valor_original_padrao numeric(18,2),
             @vencimento_real date

    select @numrows = @@rowcount

	IF	UPDATE(VALOR_ORIGINAL_PADRAO) or UPDATE(VENCIMENTO_REAL) OR UPDATE(VENCIMENTO)
	Begin
        -- Verificar se o vencimento_real est� no per�odo de folha de pagamento 
        SELECT @periodo_folha_pgto = COUNT(*)
        FROM Inserted, SAW_CALENDARIO_PGTO
        WHERE SAW_CALENDARIO_PGTO.VENCIMENTO=inserted.VENCIMENTO_REAL AND SAW_CALENDARIO_PGTO.PERIODO_FOLHA_PGTO=1

		If @periodo_folha_pgto > 0 --AND (SUSER_NAME() NOT IN ('AGEU'))
		Begin
			Select	@errno  = 30002,
				@errmsg = 'Imposs�vel Atualizar #CTB_A_PAGAR_PARCELA# porque #VENCIMENTO_REAL# est� no per�odo de Folha de Pagamento, veja outra data com Disponibilidade Financeira'
			GoTo Error
		End  

  --      -- Verificar se existe disponibilidade financeira
		--SELECT @valor_disponivel = VALOR_DISPONIVEL,@valor_original_padrao = VALOR_ORIGINAL_PADRAO, @vencimento_real = inserted.VENCIMENTO_REAL
		--FROM inserted,SAW_LIMITE_PGTO_DIARIO
		--WHERE SAW_LIMITE_PGTO_DIARIO.VENCIMENTO=inserted.VENCIMENTO_REAL

		--If (@valor_original_padrao > @valor_disponivel) --AND (SUSER_NAME() NOT IN ('AGEU'))
		--Begin
		--	Select	@errno  = 30002,
		--		@errmsg = 'Imposs�vel Incluir #CTB_A_PAGAR_PARCELA# porque #VENCIMENTO_REAL('+convert(char(10), @vencimento_real,103) +')#  est� sem Disponibilidade Financeira, veja outra data com Disponibilidade Financeira'
		--	GoTo Error
		--End 
	End
    return
error:
    raiserror @errno @errmsg 
    rollback transaction
END

