create trigger [dbo].[DR_TI_ENTRADAS_ITEM]
on [dbo].[ENTRADAS_ITEM]
for INSERT NOT FOR REPLICATION 
as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @condicao_pgto_forn char(3),
		   @condicao_pgto_pedido char(3),
		   @cod_tabela_filha CHAR(1),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount

  if 
     update(REFERENCIA_PEDIDO)  
  begin
    select @condicao_pgto_forn = RTRIM(ENTRADAS.CONDICAO_PGTO),
	       @condicao_pgto_pedido = RTRIM(COMPRAS.CONDICAO_PGTO),
		   @cod_tabela_filha = inserted.COD_TABELA_FILHA
      from inserted,ENTRADAS,COMPRAS
     where 
           inserted.NF_ENTRADA = ENTRADAS.NF_ENTRADA AND
		   inserted.SERIE_NF_ENTRADA = ENTRADAS.SERIE_NF_ENTRADA AND
		   inserted.NOME_CLIFOR = ENTRADAS.NOME_CLIFOR AND
		   inserted.REFERENCIA_PEDIDO = COMPRAS.PEDIDO
    
    if (@condicao_pgto_forn != @condicao_pgto_pedido) AND @cod_tabela_filha = 'C'
    begin
      select @errno  = 30002,             
			 @errmsg = 'Imposs��vel Incluir #ENTRADAS_ITEM #porque #Condi��o de Pagamento# est� diferente do #PEDIDO de COMPRA#, verifique'
      goto error
    end
  end

  return
error:
    raiserror (@errmsg, 16, 1)
    rollback transaction
end