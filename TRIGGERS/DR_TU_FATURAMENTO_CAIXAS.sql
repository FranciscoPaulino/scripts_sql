create trigger [dbo].[DR_TU_FATURAMENTO_CAIXAS] 
on [dbo].[FATURAMENTO_CAIXAS]
  for UPDATE NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPEDIDO char(12),
           @errno   int,

		   @qtde_caixa int,
		   @max_qtde_pecas_venda_func int,
		   @filial_loja_func varchar(25),
		   @filial varchar(25),
		   @qtde_venda_mes int,
           @errmsg  varchar(255)
           
  -- Verificar se qtde_caixa � maior que 3 pe�as
  if update(QTDE_CAIXA)
  begin
    select @nullcnt = 0

    --- Busca parametro para verificar a filial utilizada para venda a funcion�rios
	select @filial_loja_func = VALOR_ATUAL 
	from parametros where PARAMETRO='FILIAL_LOJA_FUNC'

	--- Busca filial digita��o do pedido
	SELECT @filial=RTRIM(VENDAS.FILIAL) 
	FROM inserted, VENDAS
	WHERE inserted.NOME_CLIFOR=VENDAS.CLIENTE_ATACADO and inserted.DATA_EMBALAGEM=vendas.EMISSAO
	
	-- Busca qtde_caixa do pedido 
    select @qtde_caixa = qtde_caixa
    from inserted

	-- Busca qtde j� vendida no m�s corrente para o funcion�rio
	select @qtde_venda_mes = ISNULL(sum(vendas.TOT_QTDE_ORIGINAL),0) from VENDAS, inserted
	where VENDAS.CLIENTE_ATACADO = inserted.NOME_CLIFOR and
	      month(vendas.EMISSAO) = month(getdate())

	-- Verifica se � filial venda � funcion�rios
	if (@filial = @filial_loja_func) 
		begin
			--- Busca parametro para verificar a M�xima qtde de pe�as permitida para venda a funcion�rios
			select @max_qtde_pecas_venda_func = VALOR_ATUAL 
			from parametros where PARAMETRO='MAX_QTDE_PECAS_VENDA_FUNC'

			if (@qtde_venda_mes + @qtde_caixa) > @max_qtde_pecas_venda_func
			begin
			  select @errno  = 30007,
					 @errmsg = 'Imposs�vel Alterar #VENDAS_PROD_EMBALADO# Porque quantidade de pe�as est� maior que permitido ('+ rtrim(cast(@max_qtde_pecas_venda_func as char(10))) +') p�s'
			  goto error
			end
		end
  end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end


