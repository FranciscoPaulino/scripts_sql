select b.VALOR_PROPRIEDADE, a.FILIAL,a.PRODUTO,a.COR_PRODUTO,a.ESTOQUE 
from ESTOQUE_PRODUTOS a
--join PROP_PRODUTOS b on b.PRODUTO=a.PRODUTO
--join PROPRIEDADE c on c.PROPRIEDADE=b.PROPRIEDADE
join PRODUTOS d on d.PRODUTO=a.PRODUTO
where c.DESC_PROPRIEDADE like '%COMPOSI%TECIDO%' and a.FILIAL in ('DR VAREJO','D.R. LINGERIE')


SELECT b.GRUPO_PRODUTO,b.SUBGRUPO_PRODUTO, b.COMPOSICAO,c.DESC_COMPOSICAO, a.FILIAL,a.PRODUTO,b.DESC_PRODUTO,a.COR_PRODUTO,d.desc_cor_produto,a.ESTOQUE,a.grade,
DISPONIVEL= (CASE WHEN A.tamanho='1'  THEN E.d1 
                  WHEN A.tamanho='2'  THEN E.d2 
                  WHEN A.tamanho='3'  THEN E.d3 
                  WHEN A.tamanho='4'  THEN E.d4 
                  WHEN A.tamanho='5'  THEN E.d5 
                  WHEN A.tamanho='6'  THEN E.d6 
                  WHEN A.tamanho='7'  THEN E.d7 
                  WHEN A.tamanho='8'  THEN E.d8 
                  WHEN A.tamanho='9'  THEN E.d9 
                  WHEN A.tamanho='10' THEN E.d10 
                  WHEN A.tamanho='11' THEN E.d11 
                  WHEN A.tamanho='12' THEN E.d12 
                  WHEN A.tamanho='13' THEN E.d13 
                  WHEN A.tamanho='14' THEN E.d14 
                  WHEN A.tamanho='15' THEN E.d15 
                  WHEN A.tamanho='16' THEN E.d16 
             END)
FROM W_ESTOQUE_VERTICAL a
join PRODUTOS b on b.PRODUTO=a.PRODUTO
join MATERIAIS_COMPOSICAO c on c.COMPOSICAO=b.COMPOSICAO
join PRODUTO_CORES d on d.produto=a.produto and d.cor_produto=a.cor_produto
join W_ESTOQUE_DISPONIVEL e on e.produto=a.PRODUTO and e.cor_produto=a.cor_produto and e.filial=a.filial
where a.FILIAL in ('FORA DE LINHA VAREJO','DR VAREJO','D.R. LINGERIE') and A.estoque>0
ORDER BY A.PRODUTO,A.COR_PRODUTO,A.grade



SELECT * FROM FILIAIS
WHERE FILIAL LIKE '%FORA DE LINHA%'

