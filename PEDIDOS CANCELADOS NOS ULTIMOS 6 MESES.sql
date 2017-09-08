SELECT B.NUM_CANCELAMENTO,B.DATA, A.PEDIDO,B.TIPO_CANCELAMENTO, VALOR_CANCELADO=SUM(A.VALOR_CANCELADO) 
FROM (SELECT DISTINCT PEDIDO,NUM_CANCELAMENTO,VALOR_CANCELADO FROM VENDAS_CANC_PROD)  A
JOIN VENDAS_CANCELAMENTO B ON B.NUM_CANCELAMENTO=A.NUM_CANCELAMENTO
JOIN VENDAS C ON C.PEDIDO=A.PEDIDO
WHERE  C.APROVACAO='A' AND C.FILIAL='DR VAREJO' AND B.DATA BETWEEN (GETDATE()-180) AND (GETDATE())
GROUP BY B.NUM_CANCELAMENTO,B.DATA, A.PEDIDO,B.TIPO_CANCELAMENTO

