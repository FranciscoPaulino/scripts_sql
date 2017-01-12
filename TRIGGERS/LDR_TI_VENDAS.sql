USE [DRVAREJO]
GO

/****** Object:  Trigger [dbo].[LDR_TI_VENDAS]    Script Date: 02/28/2014 14:57:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [dbo].[LDR_TI_VENDAS] 
on [dbo].[VENDAS]
  for INSERT NOT FOR REPLICATION
  as
begin
  declare  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPEDIDO char(12),
           @errno   int,
           @errmsg  varchar(255)
           
  select @insPEDIDO = PEDIDO from inserted         
/*----------------------------------------------------------------------------------------------------------------*/
	INSERT INTO SAW_CADASTRO_PEDIDO_ENVIO_EMAIL (PEDIDO,ENVIADO,EMAIL_DATA_ENVIO)
	SELECT INSERTED.PEDIDO,0,NULL FROM VENDAS, inserted WHERE VENDAS.PEDIDO=inserted.PEDIDO AND VENDAS.TABELA_FILHA='VENDAS_PRODUTO'
/*----------------------------------------------------------------------------------------------------------------*/
    IF UPDATE(PERIODO_PCP) OR UPDATE(NUMERO_ENTREGA)
       IF(SELECT COUNT(*) FROM COTA_LIMITE_PERFAT, inserted
				   WHERE COTA_LIMITE_PERFAT.NUMERO_ENTREGA=inserted.NUMERO_ENTREGA AND
                   COTA_LIMITE_PERFAT.PERIODO_PCP=inserted.PERIODO_PCP AND 
                   COTA_LIMITE_PERFAT.FECHADO=1) > 0
         EXEC SP_PEDIDO_PERFAT_FECHADO_ENVIAR_EMAIL_PCP @insPEDIDO
/*----------------------------------------------------------------------------------------------------------------*/
  return
error:
    raiserror @errno @errmsg
    rollback transaction
end

GO


