CREATE TRIGGER [dbo].[DR_TI_REPRESENTANTES] 
on [dbo].[REPRESENTANTES]
  for INSERT NOT FOR REPLICATION 
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insREPRESENTANTE varchar(25),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount

/*---LINX-INSERT---------------------------------------------------------------------------------------*/
	UPDATE 	REPRESENTANTES 
	SET 	TIPO = 'VAREJO-UNISSEX'
	FROM 	REPRESENTANTES, INSERTED
	WHERE 	REPRESENTANTES.REPRESENTANTE = INSERTED.REPRESENTANTE 
		AND RTRIM(INSERTED.TIPO) <> 'VAREJO-UNISSEX'
/*-----------------------------------------------------------------------------------------------------*/
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

