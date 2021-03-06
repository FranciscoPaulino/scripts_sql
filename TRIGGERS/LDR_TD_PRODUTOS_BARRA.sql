USE [DRVAREJO]
GO
/****** Object:  Trigger [dbo].[LDR_TD_PRODUTOS_BARRA]    Script Date: 05/07/2013 16:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[LDR_TD_PRODUTOS_BARRA] on [dbo].[PRODUTOS_BARRA]
  for DELETE NOT FOR REPLICATION
  as

begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount

  if exists (
     select SUM(ESTOQUE) from deleted,ESTOQUE_PRODUTOS
     where
       ESTOQUE_PRODUTOS.PRODUTO = deleted.PRODUTO
   )
   begin
     select @errno  = 30005,
            @errmsg = 'Impossível Excluir #PRODUTOS_BARRA #porque existem registros em #ESTOQUE_PRODUTOS#.'
     goto error
   end
 return
error:
    raiserror @errno @errmsg
    rollback transaction
end
