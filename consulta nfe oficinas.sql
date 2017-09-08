use sigma

select * from drlingerie.dbo.faturamento a
left join entradas b on b.chave_nfe=a.chave_nfe
where a.emissao between '20170801' and '20170831' and a.NOME_CLIFOR='sigma condominio' and a.NATUREZA_SAIDA ='130.01' and b.CHAVE_NFE is null

select * from drlingerie.dbo.faturamento a
join entradas b on b.chave_nfe=a.chave_nfe
where a.emissao between '20170801' and '20170831' and a.NOME_CLIFOR='sigma condominio' and a.NATUREZA_SAIDA ='130.01' and a.VALOR_TOTAL<>b.VALOR_TOTAL

select sum(a.VALOR_TOTAL),sum(b.VALOR_TOTAL) from drlingerie.dbo.faturamento a
join entradas b on b.chave_nfe=a.chave_nfe
where a.emissao between '20170801' and '20170831' and a.NOME_CLIFOR='sigma condominio' and a.NATUREZA_SAIDA ='130.01' and a.VALOR_TOTAL<>b.VALOR_TOTAL



select sum(valor_item) from entradas_item
where nf_entrada='0049554' and serie_nf_entrada='56' and NAO_SOMA_VALOR=0

select sum(VALOR_CONTABIL) from LF_REGISTRO_ENTRADA_ITEM
where nf_entrada='0049554' and serie_nf_entrada='56' and ID_IMPOSTO=1

begin tran

update a
set a.id_excecao_imposto=10
--select A.* 
from ENTRADAS_ITEM a
join entradas b on b.NF_ENTRADA=a.NF_ENTRADA and b.SERIE_NF_ENTRADA=a.SERIE_NF_ENTRADA
where INDICADOR_CFOP=10 and NAO_SOMA_VALOR=0 and b.FILIAL='SIGMA CONDOMINIO' AND A.ID_EXCECAO_IMPOSTO=46 

commit


select * from entradas
where nf_entrada='0050323' and serie_nf_entrada='56'

select * from entradas_item
where nf_entrada='0050323' and serie_nf_entrada='56'

select * from entradas_item
where nf_entrada='0051604' and serie_nf_entrada='56'

EXEC LX_GERA_IMPOSTOS_ENTRADA 'D.R. LINGERIE','0051604','56',1,1,1
