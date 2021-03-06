CREATE  trigger [dbo].[LDR_TU_SEQUENCIAIS] on [dbo].[SEQUENCIAIS]
  for UPDATE NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPEDIDO char(12),
           @delPEDIDO char(12),
           @errno   int,
           @desconto int,
           @uf      char(2),
           @natureza_saida char(7),
           @errmsg  varchar(255)

  select @numrows = @@rowcount

  if
    update(SEQUENCIA)
  begin
    select @nullcnt = 0

    select @validcnt = inserted.SEQUENCIA 
    from inserted,SEQUENCIAIS
    where inserted.TABELA_COLUNA = 'PRODUTOS_BARRA.CODIGO_EAN'

    if @validcnt > '999'
    begin
      select @errno  = 30007,
             @errmsg = 'Impossível Atualizar  #SEQUENCIAIS #porque excedeu o limite de #CÓDIGO DE BARRAS Válidos, informe ao Administrador do Sistema...'
      goto error
    end
  end
  return
error:
  raiserror @errno @errmsg
  rollback transaction
end
