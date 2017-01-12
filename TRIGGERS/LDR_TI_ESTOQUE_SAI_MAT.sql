USE [DRLINGERIE]
GO
/****** Object:  Trigger [dbo].[LDR_TI_ESTOQUE_SAI_MAT]    Script Date: 01/06/2016 12:53:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[LDR_TI_ESTOQUE_SAI_MAT] on [dbo].[ESTOQUE_SAI_MAT]
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
  from ESTOQUE_SAI_MAT,deleted
  where
        ESTOQUE_SAI_MAT.REQ_MATERIAL = deleted.REQ_MATERIAL and
        ESTOQUE_SAI_MAT.FILIAL = deleted.FILIAL

  return
error:
    raiserror @errno @errmsg
    rollback transaction
end