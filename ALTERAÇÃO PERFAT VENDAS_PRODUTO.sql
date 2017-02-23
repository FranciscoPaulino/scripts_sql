
--- altera entrega e limite_entrega do pedido por informações da capa
update a
set a.entrega=c.entrega, a.limite_entrega=c.limite, a.numero_entrega=c.numero_entrega
--select b.numero_entrega,c.entrega,c.limite,a.* 
from vendas_produto a
join vendas b on b.PEDIDO=a.PEDIDO
join PRODUTOS_PERIODOS_ENTREGAS c on c.NUMERO_ENTREGA=b.NUMERO_ENTREGA and c.PERIODO_PCP=b.PERIODO_PCP
where a.pedido='84638'

select * from SoftlogWMS.dbo.W_WMS_LINX_RESERVA_ITEM
where pedido='84638'











select * from VENDAS_LOTE_COPIA_PEDIDO
where PEDIDO_EXTERNO='0021t.400112'
