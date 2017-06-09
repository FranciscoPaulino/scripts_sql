USE [DRLINGERIE]
GO
/****** Object:  Trigger [dbo].[DR_TD_VENDAS_PROD_EMBALADO]    Script Date: 04/05/2017 09:00:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[DR_TD_VENDAS_PROD_EMBALADO] ON [dbo].[VENDAS_PROD_EMBALADO]
FOR DELETE NOT FOR REPLICATION
AS
begin

	Declare	@numrows Int,
			@errno Int,
			@errmsg varchar(255),
			@pedido char(15)

--if exists ( select 1 from deleted a join lkd65.softlogWMS.dbo.WMS_PEDIDO b on b.PEDCN_PEDIDO=a.pedido )
--	Begin
--		select top 1 @pedido=a.PEDIDO
--		from deleted a
--		join lkd65.softlogWMS.dbo.WMS_PEDIDO b on case when CHARindex('/',b.pedcn_pedido)>0 then substring(b.pedcn_pedido,1,CHARindex('/',b.pedcn_pedido)-1) else b.pedcn_pedido end=a.pedido		
					
--		Select	@errno  = 30002,
--		@errmsg = 'Impossível excluir o pedido '+''''+rtrim(@pedido)+''''+' porque já foi enviado ao WMS.'
--		GoTo Error
--	End

	return
Error:
	raiserror (@errmsg, 16, 1)
	rollback transaction
End