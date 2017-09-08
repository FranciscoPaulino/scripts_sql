select b.filial,b.emissao,b.nome_clifor,a.nf_saida,a.serie_nf,a.pedido,a.produto,e.desc_produto,b.desconto,b.cambio_na_data,qtde=sum(a.qtde),valor=sum(a.valor)
from faturamento_prod a with (nolock)
join faturamento b with (nolock) on b.nf_saida=a.nf_saida and b.serie_nf=a.serie_nf
join clientes_atacado c with (nolock) on c.cliente_atacado=b.nome_clifor
join naturezas_saidas d with (nolock) on d.natureza_saida=b.natureza_saida
join produtos e with (nolock) on e.produto=a.produto
where d.tipo_operacao = 'V' and b.protocolo_autorizacao_nfe is not null and b.emissao > (getdate()-180)
group by b.filial,b.emissao,b.nome_clifor,a.nf_saida,a.serie_nf,a.pedido,a.produto,e.desc_produto,b.desconto,b.cambio_na_data