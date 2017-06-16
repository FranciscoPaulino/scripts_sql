CREATE trigger [dbo].[LDR_TI_ESTOQUE_SAI_MAT] on [dbo].[ESTOQUE_SAI_MAT]
  for INSERT NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insREQ_MATERIAL char(8), 
           @insFILIAL varchar(25),
           @delREQ_MATERIAL char(8), 
           @delFILIAL varchar(25),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount

  UPDATE ESTOQUE_SAI_MAT
  SET NF_PENDENTE=1
  from ESTOQUE_SAI_MAT,inserted  
  where        ESTOQUE_SAI_MAT.REQ_MATERIAL = inserted.REQ_MATERIAL and
        ESTOQUE_SAI_MAT.FILIAL = inserted.FILIAL and inserted.NF_SAIDA IS NULL

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

