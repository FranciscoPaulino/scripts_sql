SELECT VENDAS.GERENTE,VENDAS.REPRESENTANTE,VENDAS_PRODUTO.PRODUTO,
VENDAS_PRODUTO.COR_PRODUTO,
PRODUTOS_BARRA.GRADE,
QTDE_ORIGINAL= (CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN VENDAS_PRODUTO.Vo1 
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
QTDE_ENTREGUE= (CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN FATURAMENTO_PROD.F1 
                     WHEN PRODUTOS_BARRA.tamanho='2'  THEN FATURAMENTO_PROD.F2
                     WHEN PRODUTOS_BARRA.tamanho='3'  THEN FATURAMENTO_PROD.F3
                     WHEN PRODUTOS_BARRA.tamanho='4'  THEN FATURAMENTO_PROD.F4
                     WHEN PRODUTOS_BARRA.tamanho='5'  THEN FATURAMENTO_PROD.F5 
                     WHEN PRODUTOS_BARRA.tamanho='6'  THEN FATURAMENTO_PROD.F6 
                     WHEN PRODUTOS_BARRA.tamanho='7'  THEN FATURAMENTO_PROD.F7
                     WHEN PRODUTOS_BARRA.tamanho='8'  THEN FATURAMENTO_PROD.F8
                     WHEN PRODUTOS_BARRA.tamanho='9'  THEN FATURAMENTO_PROD.F9
                     WHEN PRODUTOS_BARRA.tamanho='10' THEN FATURAMENTO_PROD.F10
                     WHEN PRODUTOS_BARRA.tamanho='11' THEN FATURAMENTO_PROD.F11
                     WHEN PRODUTOS_BARRA.tamanho='12' THEN FATURAMENTO_PROD.F12
                     WHEN PRODUTOS_BARRA.tamanho='13' THEN FATURAMENTO_PROD.F13
                     WHEN PRODUTOS_BARRA.tamanho='14' THEN FATURAMENTO_PROD.F14
                     WHEN PRODUTOS_BARRA.tamanho='15' THEN FATURAMENTO_PROD.F15
                     WHEN PRODUTOS_BARRA.tamanho='16' THEN FATURAMENTO_PROD.F16
                     END)
FROM PRODUTOS_BARRA PRODUTOS_BARRA 
JOIN (SELECT PEDIDO,PRODUTO,COR_PRODUTO,SUM(VO1) AS VO1,SUM(VO2) AS VO2,SUM(VO3) AS VO3,SUM(VO4) AS VO4, 
SUM(VO5) AS VO5,SUM(VO6) AS VO6,SUM(VO7) AS VO7,SUM(VO8) AS VO8,SUM(VO9) AS VO9,SUM(VO10) AS VO10,
SUM(VO11) AS VO11,SUM(VO12) AS VO12,SUM(VO13) AS VO13,SUM(VO14) AS VO14,SUM(VO15) AS VO15,SUM(VO16) AS VO16
FROM VENDAS_PRODUTO 
WHERE PEDIDO='551532'
GROUP BY PEDIDO,PRODUTO,COR_PRODUTO) AS VENDAS_PRODUTO
  ON VENDAS_PRODUTO.PRODUTO=PRODUTOS_BARRA.PRODUTO 
 AND VENDAS_PRODUTO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO 
JOIN VENDAS ON VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO  
JOIN (SELECT PEDIDO,PRODUTO,COR_PRODUTO,SUM(F1) AS F1,SUM(F2) AS F2,SUM(F3) AS F3,SUM(F4) AS F4,SUM(F5) AS F5,SUM(F6) AS F6, 
SUM(F7) AS F7,SUM(F8) AS F8,SUM(F9) AS F9,SUM(F10) AS F10,SUM(F11) AS F11,SUM(F12) AS F12, 
SUM(F13) AS F13,SUM(F14) AS F14,SUM(F15) AS F15,SUM(F16) AS F16
FROM FATURAMENTO_PROD WHERE PEDIDO='551532'
GROUP BY PEDIDO,PRODUTO,COR_PRODUTO) AS FATURAMENTO_PROD
  ON FATURAMENTO_PROD.PEDIDO=VENDAS_PRODUTO.PEDIDO AND FATURAMENTO_PROD.PRODUTO=VENDAS_PRODUTO.PRODUTO AND FATURAMENTO_PROD.COR_PRODUTO=VENDAS_PRODUTO.COR_PRODUTO
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' AND VENDAS.PEDIDO= '551532'
AND PRODUTOS_BARRA.PRODUTO IN (
40354       
40002       
40040       
40501       
40502       
40644       
40705       
40707       
42620       
44040       
46109       
50040       
50614       
51611       
51806-KIT   
40153       
40354       
40501       
40604       
40607.1     
40614       
40644       
40707       
40903       
42153       
42604       
42620       
42911       
45160       
45828       
50501       
50514       
50604       
50614       
51153       
51611       
51903       
52153       
52604       
52903.1     
40903       
42911       
51903       
52903.1     
40002       
51169 DUO   
52169 DUO   
51169 DUO   
52169 DUO   
52169 DUO   
51169 DUO   
40705       
51355 KIT   
51356 KIT   
45352       
51352       
50514       
40354       
40604       
42604       
45252       
50252       
50604       
52252       
52604       
40603       
40607.1     
42620       
45828       
50514       
50614       
51607.1     
51611       
40501       
40502       
40603       
40604       
40607.1     
42604       
42620       
42911       
43601       
45160       
45828       
50501       
50514       
50604       
50614       
51160       
51607.1     
51611       
53027       
53603       
53605       
40354       
45252       
50252       
52252       
40607.1     
45352       
51352       
45353       
51353       
45353       
51353       
40603       
40153       
40501       
40502       
40604       
40607.1     
40644       
40705       
40903       
42153       
42604       
42620       
42911       
43040       
43601       
44040       
45160       
45352       
45828       
50040       
50252       
50501       
50514       
50614       
51153       
51160       
51352       
51611       
51903       
52153       
52252       
52903.1     
40040       
40502       
40604       
42604       
45252       
50040       
50252       
52252       
45352       
51352       





SELECT PEDIDO,PRODUTO,COR_PRODUTO,SUM(VO1) AS VO1,SUM(VO2) AS VO2,SUM(VO3) AS VO3,SUM(VO4) AS VO4, 
SUM(VO5) AS VO5,SUM(VO6) AS VO6,SUM(VO7) AS VO7,SUM(VO8) AS VO8,SUM(VO9) AS VO9,SUM(VO10) AS VO10,
SUM(VO11) AS VO11,SUM(VO12) AS VO12,SUM(VO13) AS VO13,SUM(VO14) AS VO14,SUM(VO15) AS VO15,SUM(VO16) AS VO16
FROM VENDAS_PRODUTO 
WHERE PEDIDO='586422'
GROUP BY PEDIDO,PRODUTO,COR_PRODUTO

SELECT PEDIDO,PRODUTO,COR_PRODUTO,SUM(F1) AS F1,SUM(F2) AS F2,SUM(F3) AS F3,SUM(F4) AS F4,SUM(F5) AS F5,SUM(F6) AS F6, 
SUM(F7) AS F7,SUM(F8) AS F8,SUM(F9) AS F9,SUM(F10) AS F10,SUM(F11) AS F11,SUM(F12) AS F12, 
SUM(F13) AS F13,SUM(F14) AS F14,SUM(F15) AS F15,SUM(F16) AS F16
FROM FATURAMENTO_PROD WHERE PEDIDO='551532'
GROUP BY PEDIDO,PRODUTO,COR_PRODUTO
