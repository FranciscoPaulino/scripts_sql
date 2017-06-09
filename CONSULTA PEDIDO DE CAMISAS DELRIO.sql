select 
a.pedido as 'N�mero do pedido',
emissao as 'Data de emiss�o',
razao_social as 'Raz�o social',
cidade as 'Cidade',
uf as 'Estado',
produto as 'Camisa',
TOT_QTDE_ORIGINAL as 'Quantidade de camisas.'
from vendas a
join CADASTRO_CLI_FOR b on b.NOME_CLIFOR=a.CLIENTE_ATACADO
join vendas_produto c on c.PEDIDO=a.PEDIDO
where c.produto in ('CAMRIOMAN','CAMMISS','CAMLING')
