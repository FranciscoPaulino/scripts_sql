SELECT A.PRODUTO,A.COR_PRODUTO,B.ESTOQUE,EMBALADA=SUM(A.QTDE_EMBALADA) 
FROM VENDAS_PROD_EMBALADO A
RIGHT JOIN ESTOQUE_PRODUTOS B 
ON B.FILIAL=A.FILIAL AND B.PRODUTO=A.PRODUTO AND 
B.COR_PRODUTO=A.COR_PRODUTO
--WHERE B.PRODUTO='43256'
GROUP BY A.PRODUTO,A.COR_PRODUTO,B.ESTOQUE
HAVING SUM(A.QTDE_EMBALADA) > B.ESTOQUE

SELECT * FROM ESTOQUE_PRODUTOS
WHERE PRODUTO='43256'




SELECT DISTINCT PEDIDO FROM VENDAS_PRODUTO
WHERE PRODUTO IN (
'7202',        
'45253',       
'47463',     
'43256',       
'42462',       
'55213'       
) AND QTDE_EMBALADA>0 AND QTDE_ENTREGUE>0



SELECT 