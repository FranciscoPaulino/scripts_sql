CREATE trigger [dbo].[LDR_TU_VALIDA_TRANSPORTADORA_ENTRADA] on [dbo].[ENTRADAS] for UPDATE NOT FOR REPLICATION as
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
			@errmsg = 'Imposs�vel Alterar #ENTRADAS #porque #TRANSPORTADORAS #n�o pode ser nula.'
      goto error
    end
  return
error:
  raiserror @errno @errmsg
  rollback transaction
end


