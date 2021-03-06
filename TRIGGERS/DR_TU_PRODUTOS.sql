CREATE TRIGGER [dbo].[DR_TU_PRODUTOS] ON [dbo].[PRODUTOS]
FOR UPDATE NOT FOR REPLICATION
As 
Begin
	Declare	
		@numrows	Int,
		@nullcnt	Int,
		@validcnt	Int,
		@insPRODUTO char(12) ,
		@delPRODUTO char(12) ,
		@errno      Int,
		@errmsg     varchar(255)

	Select @numrows = @@rowcount

	  if 
		 update(SEXO_TIPO)
	  begin
		select @nullcnt = 0

		select @nullcnt = count(*) from inserted where
		  inserted.SEXO_TIPO is null
		if @nullcnt > 0
		begin
		  select @errno  = 30002,
				 @errmsg = 'Imposs�vel Atualizar #PRODUTOS #porque #SEXO_TIPO #n�o existe.'
		  goto error
		end
	  end
	return
Error:
	raiserror (@errmsg, 16, 1)
	rollback transaction
End

