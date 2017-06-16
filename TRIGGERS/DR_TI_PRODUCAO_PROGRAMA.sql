CREATE trigger [dbo].[DR_TI_PRODUCAO_PROGRAMA] 
on [dbo].[PRODUCAO_PROGRAMA]
  for INSERT NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
		   @usr_confirma_programacao varchar(100),
		   @tipo_programacao int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount

  if 
     update(TIPO_PROGRAMACAO)
  begin
    select @usr_confirma_programacao = VALOR_ATUAL 
	from PARAMETROS 
	where PARAMETRO = 'USR_CONFIRMA_PROGRAMACAO'

	select @tipo_programacao = inserted.TIPO_PROGRAMACAO 
	from inserted

    if (@tipo_programacao = 2) AND (CHARINDEX(SUSER_NAME(), @usr_confirma_programacao) = 0)
    begin
      select @errno  = 30002,
             @errmsg = 'Imposs�vel Incluir #PRODUCAO_PROGRAMA #porque #USU�RIO #n�o tem permiss�o para CONFIRMAR programa��o'
      goto error
    end
  end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

