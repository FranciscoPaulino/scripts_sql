select clifor,cidade from cadastro_cli_for
where cidade not in (select desc_municipio from lcf_lx_municipio)
order by cidade


update cadastro_cli_for
set cidade='FORTALEZA'
where cidade like '000%'


SELECT * FROM LCF_LX_MUNICIPIO
WHERE DESC_MUNICIPIO LIKE '%QUEMES%'

SELECT * FROM LCF_LX_UF

select * from faturamento
where nome_clifor='2M C.A.                  '



select clifor,nome_clifor,razao_social,cidade,entrega_cidade,cobranca_cidade,ddd1,telefone1,email
from cadastro_cli_for 
where nome_clifor in (select nome_clifor from faturamento where emissao between '20120101' and '20121231') 
and inativo=0 
and (cidade not in (select desc_municipio from lcf_lx_municipio) or entrega_cidade not in (select desc_municipio from lcf_lx_municipio) or cobranca_cidade not in (select desc_municipio from lcf_lx_municipio))
order by razao_social


select regiao,a.clifor,razao_social,cidade,entrega_cidade,cobranca_cidade,ddd1,telefone1,email
from cadastro_cli_for a
join clientes_atacado on clientes_atacado.cliente_atacado=a.nome_clifor
where a.nome_clifor in (select nome_clifor from faturamento where emissao between '20110101' and '20121231') 
and a.inativo=0 
and (cidade not in (select desc_municipio from lcf_lx_municipio) or entrega_cidade not in (select desc_municipio from lcf_lx_municipio) or cobranca_cidade not in (select desc_municipio from lcf_lx_municipio) or telefone1='')
order by regiao,razao_social
