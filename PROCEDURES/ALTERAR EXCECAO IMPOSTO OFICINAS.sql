use deltamatriz

select * from faturamento_item a
join faturamento b on b.nf_saida=a.nf_saida and b.serie_nf=a.serie_nf
where INDICADOR_CFOP='10' and b.emissao between '20170801' and '20170831' and a.nao_soma_valor=1

begin tran

update a
set a.ID_EXCECAO_IMPOSTO='58'
from faturamento_item a
join faturamento b on b.nf_saida=a.nf_saida and b.serie_nf=a.serie_nf
where INDICADOR_CFOP='10' and b.emissao between '20170801' and '20170831' and a.nao_soma_valor=1

commit

SELECT * FROM FATURAMENTO
WHERE NF_SAIDA='0000726' and SERIE_NF='112'

SELECT * FROM ENTRADAS_ITEM
WHERE TRIBUT_ICMS IS NULL



select * from entradas_item a
join entradas b on b.nf_entrada=a.nf_entrada and b.serie_nf_entrada=a.serie_nf_entrada
--where b.emissao between '20170801' and '20170831' and a.indicador_cfop=10 and a.nao_soma_valor=0 and b.NATUREZA='230.01'
where b.emissao between '20170801' and '20170831' and a.indicador_cfop=10 and a.nao_soma_valor=0 and b.NATUREZA='230.01' and a.ID_EXCECAO_IMPOSTO=59

update a
set ID_EXCECAO_IMPOSTO=28
from entradas_item a
join entradas b on b.nf_entrada=a.nf_entrada and b.serie_nf_entrada=a.serie_nf_entrada
where b.emissao between '20170801' and '20170831' and a.indicador_cfop=10 and a.nao_soma_valor=0 and b.NATUREZA='230.01' and a.ID_EXCECAO_IMPOSTO=59


select * from entradas
where nf_entrada='0052623' and SERIE_NF_ENTRADA='56'


select * from entradas_item
where nf_entrada='0052623' and SERIE_NF_ENTRADA='56'

update entradas_item
set CONTA_CONTABIL='11401', INDICADOR_CFOP='10'
where nf_entrada='0052623' and SERIE_NF_ENTRADA='56'

select * from entradas_iMPOSTO
where nf_entrada='0052623' and SERIE_NF_ENTRADA='56'

EXEC LX_GERA_IMPOSTOS_ENTRADA 'D.R. LINGERIE','0052623','56',1,1,1