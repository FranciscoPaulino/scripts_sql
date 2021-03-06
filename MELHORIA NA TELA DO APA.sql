SELECT PERIODO_PCP, NUMERO_ENTREGA, ENTREGA, LIMITE,DIAS_RESTANTE, 
QTDE_EMBALADA, QTDE_RESERVADA,QTDE_A_RESERVAR,QTDE_ORIGINAL, QTDE_ENTREGUE,
PERC_FAT=CAST(CAST(QTDE_ENTREGUE AS NUMERIC) / CAST(QTDE_ORIGINAL AS NUMERIC) * 100 AS NUMERIC(10 , 2)), 
TOTAL = (QTDE_EMBALADA + QTDE_RESERVADA + QTDE_A_RESERVAR) 
FROM W_ACOMPANHAMENTO_CARTEIRA_NEW AS A 
WHERE (ENTREGA >= CONVERT(DATE,'01/01/2014',103)) AND (LIMITE <= CONVERT(DATE,'31/12/2014',103)) AND (QTDE_EMBALADA + QTDE_RESERVADA + QTDE_A_RESERVAR)>0 
ORDER BY NUMERO_ENTREGA



SELECT 
PERIODO_PCP=RTRIM(VENDAS.PERIODO_PCP),    
PRODUTOS_PERIODOS_ENTREGAS.NUMERO_ENTREGA,    
PRODUTOS_PERIODOS_ENTREGAS.ENTREGA,    
PRODUTOS_PERIODOS_ENTREGAS.LIMITE,    
DIAS_RESTANTE=DATEPART(dayofyear, PRODUTOS_PERIODOS_ENTREGAS.LIMITE)-DATEPART(dayofyear, GETDATE()),
QTDE_ORIGINAL=SUM(VENDAS_PRODUTO.QTDE_ORIGINAL),    
QTDE_ENTREGUE=SUM(VENDAS_PRODUTO.QTDE_ENTREGUE),    
QTDE_EMBALADA = CASE CAIXA_FECHADA 
WHEN 1 THEN ISNULL(SUM(VENDAS_PROD_EMBALADO.QTDE_EMBALADA),0) END,    
QTDE_RESERVADA = CASE CAIXA_FECHADA 
WHEN 0 THEN ISNULL(SUM(VENDAS_PROD_EMBALADO.QTDE_EMBALADA),0) END,
QTDE_A_RESERVAR=SUM(VENDAS_PRODUTO.QTDE_ENTREGAR-VENDAS_PRODUTO.QTDE_EMBALADA)
FROM VENDAS_PROD_EMBALADO WITH (NOLOCK)   
JOIN VENDAS_PRODUTO WITH (NOLOCK)  ON VENDAS_PRODUTO.PEDIDO=VENDAS_PROD_EMBALADO.PEDIDO AND VENDAS_PRODUTO.PRODUTO=VENDAS_PROD_EMBALADO.PRODUTO AND VENDAS_PRODUTO.COR_PRODUTO = VENDAS_PROD_EMBALADO.COR_PRODUTO    
JOIN VENDAS WITH (NOLOCK)  ON VENDAS.PEDIDO = VENDAS_PROD_EMBALADO.PEDIDO     
JOIN PRODUTOS_PERIODOS_ENTREGAS WITH (NOLOCK)  ON PRODUTOS_PERIODOS_ENTREGAS.NUMERO_ENTREGA=VENDAS.NUMERO_ENTREGA AND PRODUTOS_PERIODOS_ENTREGAS.PERIODO_PCP=VENDAS.PERIODO_PCP    
GROUP BY VENDAS.PERIODO_PCP,PRODUTOS_PERIODOS_ENTREGAS.NUMERO_ENTREGA,PRODUTOS_PERIODOS_ENTREGAS.ENTREGA,PRODUTOS_PERIODOS_ENTREGAS.LIMITE,VENDAS_PROD_EMBALADO.ENTREGA,CAIXA_FECHADA    
HAVING PRODUTOS_PERIODOS_ENTREGAS.ENTREGA >= '20130101'  
ORDER BY NUMERO_ENTREGA

