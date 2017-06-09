update b
set b.entrega='20170526',b.limite_entrega='20170526'
from vendas a
join vendas_produto b on a.pedido=b.pedido
where  a.PEDIDO_CLIENTE in(
	'2237242',
	'2237243',
	'2236967',
	'2250351')
