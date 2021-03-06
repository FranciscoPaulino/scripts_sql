SELECT PRODUTOS.CLASSIF_FISCAL, VENDAS.CLIENTE_ATACADO,VENDAS.PEDIDO,VENDAS_PRODUTO.ITEM_PEDIDO,
PRODUTOS.PRODUTO AS COD_FORN,
PRODUTOS.DESC_PRODUTO, 
PRODUTOS_BARRA.CODIGO_BARRA,
PRODUTOS.PRODUTO AS MODELO,
PRODUTO_CORES.DESC_COR_PRODUTO AS COR,
PRODUTOS_BARRA.GRADE,
QTDE = (CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN VENDAS_PRODUTO.VO1 
                     WHEN PRODUTOS_BARRA.tamanho='2'  THEN VENDAS_PRODUTO.VO2 
                     WHEN PRODUTOS_BARRA.tamanho='3'  THEN VENDAS_PRODUTO.VO3 
                     WHEN PRODUTOS_BARRA.tamanho='4'  THEN VENDAS_PRODUTO.VO4 
                     WHEN PRODUTOS_BARRA.tamanho='5'  THEN VENDAS_PRODUTO.VO5 
                     WHEN PRODUTOS_BARRA.tamanho='6'  THEN VENDAS_PRODUTO.VO6 
                     WHEN PRODUTOS_BARRA.tamanho='7'  THEN VENDAS_PRODUTO.VO7 
                     WHEN PRODUTOS_BARRA.tamanho='8'  THEN VENDAS_PRODUTO.VO8 
                     WHEN PRODUTOS_BARRA.tamanho='9'  THEN VENDAS_PRODUTO.VO9 
                     WHEN PRODUTOS_BARRA.tamanho='10' THEN VENDAS_PRODUTO.VO10 
                     WHEN PRODUTOS_BARRA.tamanho='11' THEN VENDAS_PRODUTO.VO11 
                     WHEN PRODUTOS_BARRA.tamanho='12' THEN VENDAS_PRODUTO.VO12 
                     WHEN PRODUTOS_BARRA.tamanho='13' THEN VENDAS_PRODUTO.VO13 
                     WHEN PRODUTOS_BARRA.tamanho='14' THEN VENDAS_PRODUTO.VO14 
                     WHEN PRODUTOS_BARRA.tamanho='15' THEN VENDAS_PRODUTO.VO15 
                     WHEN PRODUTOS_BARRA.tamanho='16' THEN VENDAS_PRODUTO.VO16 
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
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' AND PRODUTOS_BARRA.CODIGO_BARRA_PADRAO=1
AND (VENDAS.cliente_atacado LIKE '%PINTOS%' or VENDAS.cliente_atacado LIKE '%MEGA%' or VENDAS.cliente_atacado LIKE '%nazare%') 
AND VENDAS_PRODUTO.QTDE_ENTREGAR>0
ORDER BY VENDAS.PEDIDO