SELECT PRODUTO,COR_PRODUTO,TAMANHO,GRADE,QTDE=SUM(QTDE) FROM (

SELECT VENDAS.CLIENTE_ATACADO,VENDAS.PEDIDO,VENDAS_PRODUTO.ITEM_PEDIDO,
PRODUTOS.PRODUTO,
PRODUTOS.DESC_PRODUTO, 
PRODUTO_CORES.COR_PRODUTO,
PRODUTOS_BARRA.GRADE,
PRODUTOS_BARRA.TAMANHO,
QTDE = (CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN VENDAS_PRODUTO.Vo1 
                     WHEN PRODUTOS_BARRA.tamanho='2'  THEN VENDAS_PRODUTO.Vo2 
                     WHEN PRODUTOS_BARRA.tamanho='3'  THEN VENDAS_PRODUTO.Vo3 
                     WHEN PRODUTOS_BARRA.tamanho='4'  THEN VENDAS_PRODUTO.Vo4 
                     WHEN PRODUTOS_BARRA.tamanho='5'  THEN VENDAS_PRODUTO.Vo5 
                     WHEN PRODUTOS_BARRA.tamanho='6'  THEN VENDAS_PRODUTO.Vo6 
                     WHEN PRODUTOS_BARRA.tamanho='7'  THEN VENDAS_PRODUTO.Vo7 
                     WHEN PRODUTOS_BARRA.tamanho='8'  THEN VENDAS_PRODUTO.Vo8 
                     WHEN PRODUTOS_BARRA.tamanho='9'  THEN VENDAS_PRODUTO.Vo9 
                     WHEN PRODUTOS_BARRA.tamanho='10' THEN VENDAS_PRODUTO.Vo10 
                     WHEN PRODUTOS_BARRA.tamanho='11' THEN VENDAS_PRODUTO.Vo11 
                     WHEN PRODUTOS_BARRA.tamanho='12' THEN VENDAS_PRODUTO.Vo12 
                     WHEN PRODUTOS_BARRA.tamanho='13' THEN VENDAS_PRODUTO.Vo13 
                     WHEN PRODUTOS_BARRA.tamanho='14' THEN VENDAS_PRODUTO.Vo14 
                     WHEN PRODUTOS_BARRA.tamanho='15' THEN VENDAS_PRODUTO.Vo15 
                     WHEN PRODUTOS_BARRA.tamanho='16' THEN VENDAS_PRODUTO.Vo16 
                     END),
VENDAS_PRODUTO.PRECO1                     
FROM PRODUTOS_BARRA PRODUTOS_BARRA 
JOIN PRODUTOS PRODUTOS ON PRODUTOS_BARRA.PRODUTO=PRODUTOS.PRODUTO 
JOIN PRODUTO_CORES PRODUTO_CORES ON PRODUTO_CORES.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND PRODUTO_CORES.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
LEFT JOIN (SELECT * FROM VENDAS_PRODUTO) AS VENDAS_PRODUTO
  ON VENDAS_PRODUTO.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND VENDAS_PRODUTO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
JOIN VENDAS ON VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO  
JOIN CLIENTES_ATACADO ON CLIENTES_ATACADO.CLIENTE_ATACADO=VENDAS.CLIENTE_ATACADO
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' and CLIENTES_ATACADO.CLIFOR='018521' AND VENDAS.NUMERO_ENTREGA='11' AND PRODUTOS_BARRA.CODIGO_BARRA_PADRAO=1 AND VENDAS_PRODUTO.QTDE_ENTREGAR>0

) VENDAS_PRODUTO  

GROUP BY PRODUTO,COR_PRODUTO,TAMANHO,GRADE
ORDER BY PRODUTO,COR_PRODUTO,TAMANHO

