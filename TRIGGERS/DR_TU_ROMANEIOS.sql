USE [TESTES]
GO
/****** Object:  Trigger [dbo].[DR_TU_ROMANEIOS]    Script Date: 03/11/2016 16:50:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[DR_TU_ROMANEIOS] on [dbo].[ROMANEIOS]
  for UPDATE NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @errno   int,
           @errmsg  varchar(255)

  select @numrows = @@rowcount
  
  -- Verificar se existe reserva do pedido
  if update(LIBERADO_EXPEDICAO)
  begin
    BEGIN TRY
       EXECUTE PROC_WMS_RESERVAS
    END TRY
    BEGIN CATCH 
		begin
		  select @errno  = 30007,
				 @errmsg = 'Erro na execução da procedure #PROC_WMS_RESERVAS#'
		  goto error
		end
    END CATCH
  end
  return
error:
  raiserror @errno @errmsg
end
