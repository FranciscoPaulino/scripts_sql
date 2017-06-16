CREATE trigger [dbo].[LDR_TI_VALIDA_TRANSPORTADORA_ENTRADA] on [dbo].[ENTRADAS] for INSERT NOT FOR REPLICATION as
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount

  if 
     (select count(*) from inserted where
     (inserted.TRANSPORTADORA_A_PAGAR is null or inserted.TRANSPORTADORA_A_PAGAR='') AND inserted.NF_ENTRADA_PROPRIA=1) > 0
    begin
      select @errno  = 30002,
			@errmsg = 'Impossível Incluir #ENTRADAS #porque #TRANSPORTADORAS #não pode ser nula.'
      goto error
    end

  if 
     update(MOEDA)
  begin
    if (select count(*) from inserted where inserted.MOEDA <> 'R$') > 0
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Incluir #ENTRADAS #porque Moeda a Pagar não pode ser diferente de R$'
      goto error
    end
  end
  return
error:
  raiserror @errno @errmsg
  rollback transaction
end



