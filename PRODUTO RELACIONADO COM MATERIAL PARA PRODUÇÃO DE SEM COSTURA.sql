-- para Déa
select a.filial,c.PRODUTO,b.MATERIAL,b.DESC_MATERIAL, a.COR_MATERIAL,a.QTDE_ESTOQUE 
from ESTOQUE_MATERIAIS a
join MATERIAIS b on b.MATERIAL=a.MATERIAL
join PRODUTOS c on c.PRODUTO=substring(b.DESC_MATERIAL,1,(len(rtrim(c.produto)))) 
where a.FILIAL='d.r. lingerie' and b.TIPO = 'SEAMLESS' and c.PRODUTO='bx6401'
order by c.PRODUTO


-- para Sem Costura
select a.filial,c.PRODUTO,b.MATERIAL,b.DESC_MATERIAL, a.COR_MATERIAL,a.QTDE_ESTOQUE 
from ESTOQUE_MATERIAIS a
join MATERIAIS b on b.MATERIAL=a.MATERIAL
join PRODUTOS c on c.PRODUTO=substring(b.DESC_MATERIAL, charindex(RTRIM(c.produto), b.DESC_MATERIAL), (len(rtrim(c.produto)))) 
where a.FILIAL='d.r. lingerie' 
and b.TIPO = 'SEAMLESS' 
--and c.PRODUTO='bx6401'
order by c.PRODUTO

