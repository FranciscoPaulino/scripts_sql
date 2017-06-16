CREATE trigger [dbo].[DR_TI_PRODUTOS] 
on [dbo].[PRODUTOS]
  for INSERT NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPRODUTO char(12),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  if 
     update(SEXO_TIPO)
  begin
    select @nullcnt = 0

    select @nullcnt = count(*) from inserted where
      inserted.SEXO_TIPO is null
    if @nullcnt > 0
    begin
      select @errno  = 30002,
             @errmsg = 'Imposs�vel Incluir #PRODUTOS #porque #SEXO_TIPO #n�o existe.'
      goto error
    end
  end
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

