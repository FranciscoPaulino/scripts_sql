USE [DRLINGERIE]
GO
/****** Object:  Trigger [dbo].[DR_TU_PRODUTO_CORES]    Script Date: 21/06/2017 16:05:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER trigger [dbo].[DR_TU_PRODUTO_CORES] 
on [dbo].[PRODUTO_CORES]
  for UPDATE NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPRODUTO char(12), 
           @insCOR_PRODUTO char(10),
           @delPRODUTO char(12), 
           @delCOR_PRODUTO char(10),
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount

  --- Retirar acentuações da descrição da cor do produto
  if update(DESC_COR_PRODUTO)
  begin
 	 UPDATE	PRODUTO_CORES 
	 SET 	DESC_COR_PRODUTO = DBO.FN_FORMATAR_TEXTO(INSERTED.DESC_COR_PRODUTO)
	 FROM 	PRODUTO_CORES, INSERTED
	 WHERE 	PRODUTO_CORES.PRODUTO = INSERTED.PRODUTO and
            PRODUTO_CORES.COR_PRODUTO = INSERTED.COR_PRODUTO 
  end

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end