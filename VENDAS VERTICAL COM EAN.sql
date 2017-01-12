SELECT VENDAS.CLIENTE_ATACADO,VENDAS.PEDIDO,VENDAS_PRODUTO.ITEM_PEDIDO,
PRODUTOS.PRODUTO AS COD_FORN,
PRODUTOS.DESC_PRODUTO, 
PRODUTOS_BARRA.CODIGO_BARRA,
PRODUTOS.CLASSIF_FISCAL AS NCM,
PRODUTOS.PRODUTO AS MODELO,
PRODUTO_CORES.DESC_COR_PRODUTO AS COR,
PRODUTOS_BARRA.GRADE,
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
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' 
AND (VENDAS.CLIENTE_ATACADO LIKE '%DAFITI%' 
OR VENDAS.CLIENTE_ATACADO LIKE '%SHIBATA%'
OR VENDAS.CLIENTE_ATACADO LIKE '%KACYUMARA%'
OR VENDAS.CLIENTE_ATACADO LIKE '%ENXUTO%' 
OR VENDAS.CLIENTE_ATACADO LIKE '%MACRO PAMPA%' 
OR VENDAS.CLIENTE_ATACADO LIKE '%ANGELONI%'
OR VENDAS.CLIENTE_ATACADO = 'SUPERMERCADO CASA GRANDE'
OR VENDAS.CLIENTE_ATACADO = 'CELSO AFONSO FIDELIS JR'  
OR VENDAS.CLIENTE_ATACADO = 'EDUARDO LUIZ BAPTISTA'    
) 
AND VENDAS_PRODUTO.QTDE_ENTREGAR>0
ORDER BY VENDAS.PEDIDO