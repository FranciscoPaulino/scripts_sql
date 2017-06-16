CREATE TRIGGER [dbo].[DR_TD_VENDAS_PROD_EMBALADO] ON [dbo].[VENDAS_PROD_EMBALADO]
FOR DELETE NOT FOR REPLICATION
AS
begin

	Declare	@numrows Int,
			@errno Int,
			@errmsg varchar(255),
			@pedido char(15)

	--if exists ( select 1 from deleted a join W_WMS_PEDIDO b on case when CHARindex('/',b.pedcn_pedido)>0 then substring(b.pedcn_pedido,1,CHARindex('/',b.pedcn_pedido)-1) else b.pedcn_pedido end=a.pedido ) and (SUSER_NAME() IN ('SA','MARIADEFATIMA','JU','THICIANNE','NILO'))
	--Begin
	--	select top 1 @pedido=a.PEDIDO
	--	from deleted a
	--	join W_WMS_PEDIDO b on case when CHARindex('/',b.pedcn_pedido)>0 then substring(b.pedcn_pedido,1,CHARindex('/',b.pedcn_pedido)-1) else b.pedcn_pedido end=a.pedido		
					
	--	Select	@errno  = 30002,
	--	@errmsg = 'Imposs�vel Excluir o pedido '+''''+rtrim(@pedido)+''''+' porque j� foi enviado ao sistema WMS.'
	--	GoTo Error
	--End

	return
Error:
	raiserror (@errmsg, 16, 1)
	rollback transaction
End

