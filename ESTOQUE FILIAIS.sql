select a.FILIAL,b.GRUPO_PRODUTO,QTDE=sum(a.estoque)
from ESTOQUE_PRODUTOS a
join produtos b on b.PRODUTO=a.PRODUTO
where a.FILIAL in('D.R. LINGERIE','DR VAREJO','FORA DE LINHA VAREJO','FORA DE LINHA SG')
group by a.filial,b.GRUPO_PRODUTO