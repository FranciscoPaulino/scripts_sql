-- verificar qual nfe tem valor contabil diferente
select a.NF_ENTRADA,a.QTDE_TOTAL,a.VALOR_TOTAL,c.VALOR_CONTABIL,sum(b.qtde_item),sum(valor_item) from ENTRADAS a
join ENTRADAS_ITEM b on b.NF_ENTRADA=a.NF_ENTRADA and b.SERIE_NF_ENTRADA=a.SERIE_NF_ENTRADA
join W_LF_REGISTRO_ENTRADA_IMPOSTO c on c.NF_ENTRADA=b.NF_ENTRADA and c.SERIE_NF_ENTRADA=b.SERIE_NF_ENTRADA
where a.EMISSAO between '20170201' and '20170228' and TIPO_ENTRADAS='BENEFICIAMENTO' and DATA_DIGITACAO='20170303' and IMPOSTO = 'ICMS'
group by a.NF_ENTRADA,a.QTDE_TOTAL,a.VALOR_TOTAL,c.VALOR_CONTABIL
having c.VALOR_CONTABIL<>a.VALOR_TOTAL


-- verificar a qtde de itens com imposto
select b.NF_ENTRADA,b.SERIE_NF_ENTRADA, a.ITEM_IMPRESSAO,qtde_impostos=count(*) 
from ENTRADAS_IMPOSTO a
join W_LF_REGISTRO_ENTRADA_IMPOSTO b on b.NF_ENTRADA=a.NF_ENTRADA and b.SERIE_NF_ENTRADA=a.SERIE_NF_ENTRADA
where b.EMISSAO between '20170201' and '20170228' 
and IMPOSTO = 'ICMS' 
--and b.NF_ENTRADA='0031104'
group by b.NF_ENTRADA,b.SERIE_NF_ENTRADA, a.ITEM_IMPRESSAO
having count(*)<>4


