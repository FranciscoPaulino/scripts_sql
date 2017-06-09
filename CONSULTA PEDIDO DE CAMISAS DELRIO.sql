select 
a.pedido as 'Número do pedido',
emissao as 'Data de emissão',
razao_social as 'Razão social',
cidade as 'Cidade',
uf as 'Estado',
produto as 'Camisa',
TOT_QTDE_ORIGINAL as 'Quantidade de camisas.'
from vendas a
join CADASTRO_CLI_FOR b on b.NOME_CLIFOR=a.CLIENTE_ATACADO
join vendas_produto c on c.PEDIDO=a.PEDIDO
where c.produto in ('CAMRIOMAN','CAMMISS','CAMLING')
