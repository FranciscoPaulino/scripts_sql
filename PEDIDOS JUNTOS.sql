
update vendas
set pedido_venda_origem = '95601'
where pedido in (
'95601',
'95837')

update vendas
set pedido_venda_origem = NULL
where pedido in (
'95602',
'95839')