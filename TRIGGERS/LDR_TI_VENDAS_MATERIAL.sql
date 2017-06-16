CREATE trigger [dbo].[LDR_TI_VENDAS_MATERIAL] on [dbo].[VENDAS_MATERIAL] for INSERT NOT FOR REPLICATION as
/* INSERT trigger on VENDAS_MATERIAL */
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPEDIDO char(12), 
           @insMATERIAL char(11), 
           @insCOR_MATERIAL char(10), 
           @insENTREGA datetime,
           @errno   int,
           @errmsg  varchar(255),
           @q_original numeric(9,3),
           @v_original numeric(17,5)

  select @numrows = @@rowcount
  /* MATERIAIS_CORES R/1271 VENDAS_MATERIAL ON CHILD INSERT RESTRICT */
  if 
     update(QTDE_ORIGINAL) or 
     update(VALOR_ORIGINAL)
  begin
    select @nullcnt = 0
    select @q_original=QTDE_ORIGINAL, @v_original=VALOR_ORIGINAL
      from inserted
    
    if @q_original = 0 or @v_original = 0
    begin
      select @errno  = 30002,
             @errmsg = 'Impossível Incluir #VENDAS_MATERIAL #porque #QTDE_ORIGINAL ou #VALOR_ORIGINAL #não pode ser ZERO.'
      goto error
    end
  end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

