--- MOTIVOS DE CANCELAMENTOS
SELECT PERIODO_PCP,NUMERO_ENTREGA,* FROM (
SELECT VENDAS_CANCELAMENTO.TIPO_CANCELAMENTO, VENDAS_CANC_PROD.NUM_CANCELAMENTO,PEDIDO,QTDE_CANCELADA FROM VENDAS_CANC_PROD
JOIN VENDAS_CANCELAMENTO ON VENDAS_CANCELAMENTO.NUM_CANCELAMENTO=VENDAS_CANC_PROD.NUM_CANCELAMENTO
WHERE VENDAS_CANC_PROD.PEDIDO IN (SELECT PEDIDO FROM VENDAS WHERE TOT_QTDE_CANCELADA>0)) AS CANCELAMENTOS
JOIN VENDAS ON VENDAS.PEDIDO = CANCELAMENTOS.PEDIDO
