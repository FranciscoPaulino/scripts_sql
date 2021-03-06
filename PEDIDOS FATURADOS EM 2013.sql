-- NO PRAZO
SELECT 'NO PRAZO' AS SITUACAO,VENDAS_PRODUTO.NUMERO_ENTREGA,VENDAS_PRODUTO.PEDIDO,QTDE_ORIGINAL=SUM(VENDAS_PRODUTO.QTDE_ORIGINAL),QTDE_ENTREGUE=SUM(VENDAS_PRODUTO.QTDE_ENTREGUE),QTDE_CALCELADA=SUM(VENDAS_PRODUTO.QTDE_CANCELADA),QTDE_FAT=SUM(FAT_PROD.QTDE)
FROM VENDAS_PRODUTO
JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO AND FAT_PROD.PRODUTO = VENDAS_PRODUTO.PRODUTO AND FAT_PROD.COR_PRODUTO = VENDAS_PRODUTO.COR_PRODUTO
JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
WHERE VENDAS.APROVACAO = 'A' 
AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
AND VENDAS.EMISSAO >='20130101' 
AND FATURAMENTO.EMISSAO BETWEEN VENDAS_PRODUTO.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA
GROUP BY VENDAS_PRODUTO.NUMERO_ENTREGA,VENDAS_PRODUTO.PEDIDO 
UNION ALL
SELECT 'ANTECIPADOS' AS SITUACAO,VENDAS_PRODUTO.NUMERO_ENTREGA,VENDAS_PRODUTO.PEDIDO,QTDE_ORIGINAL=SUM(VENDAS_PRODUTO.QTDE_ORIGINAL),QTDE_ENTREGUE=SUM(VENDAS_PRODUTO.QTDE_ENTREGUE),QTDE_CALCELADA=SUM(VENDAS_PRODUTO.QTDE_CANCELADA),QTDE_FAT=SUM(FAT_PROD.QTDE)
FROM VENDAS_PRODUTO
JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO AND FAT_PROD.PRODUTO = VENDAS_PRODUTO.PRODUTO AND FAT_PROD.COR_PRODUTO = VENDAS_PRODUTO.COR_PRODUTO
JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
WHERE VENDAS.APROVACAO = 'A' 
AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
AND VENDAS.EMISSAO >='20130101' 
AND FATURAMENTO.EMISSAO < VENDAS_PRODUTO.ENTREGA
GROUP BY VENDAS_PRODUTO.NUMERO_ENTREGA,VENDAS_PRODUTO.PEDIDO
UNION ALL
SELECT 'ATRASADOS' AS SITUACAO,VENDAS_PRODUTO.NUMERO_ENTREGA,VENDAS_PRODUTO.PEDIDO,QTDE_ORIGINAL=SUM(VENDAS_PRODUTO.QTDE_ORIGINAL),QTDE_ENTREGUE=SUM(VENDAS_PRODUTO.QTDE_ENTREGUE),QTDE_CALCELADA=SUM(VENDAS_PRODUTO.QTDE_CANCELADA),QTDE_FAT=SUM(FAT_PROD.QTDE)
FROM VENDAS_PRODUTO
JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO AND FAT_PROD.PRODUTO = VENDAS_PRODUTO.PRODUTO AND FAT_PROD.COR_PRODUTO = VENDAS_PRODUTO.COR_PRODUTO
JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
WHERE VENDAS.APROVACAO = 'A' 
AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
AND VENDAS.EMISSAO >='20130101' 
AND FATURAMENTO.EMISSAO > VENDAS_PRODUTO.LIMITE_ENTREGA
GROUP BY VENDAS_PRODUTO.NUMERO_ENTREGA,VENDAS_PRODUTO.PEDIDO


-- PEDIDOS FATUIRADOS NO PRAZO, ANTECIPADOS E ATRASADO
SELECT A.PERIODO_PCP,A.NUMERO_ENTREGA,A.ENTREGA,A.LIMITE,
ATRASO = ( SELECT COUNT(DISTINCT VENDAS_PRODUTO.PEDIDO)
		   FROM VENDAS_PRODUTO
		   JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
		   JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD 
	       ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO 
	       JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
	       WHERE VENDAS.APROVACAO = 'A' 
	       AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
	       AND VENDAS.EMISSAO >='20130101' 
	       AND FATURAMENTO.EMISSAO > VENDAS_PRODUTO.LIMITE_ENTREGA AND VENDAS_PRODUTO.ENTREGA=A.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA=A.LIMITE),
ANTECIPADOS=(SELECT COUNT(DISTINCT VENDAS_PRODUTO.PEDIDO)
			 FROM VENDAS_PRODUTO
			 JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
			 JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD 
			 ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO 
			 JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
			 WHERE VENDAS.APROVACAO = 'A' 
			 AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
			 AND VENDAS.EMISSAO >='20130101' 
			 AND FATURAMENTO.EMISSAO < VENDAS_PRODUTO.ENTREGA AND VENDAS_PRODUTO.ENTREGA=A.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA=A.LIMITE), 
NO_PRAZO=(SELECT COUNT(DISTINCT VENDAS_PRODUTO.PEDIDO)
		  FROM VENDAS_PRODUTO
		  JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
		  JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD 
		  ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO 
		  JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
		  WHERE VENDAS.APROVACAO = 'A' 
		  AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
		  AND VENDAS.EMISSAO >='20130101' 
		  AND FATURAMENTO.EMISSAO BETWEEN VENDAS_PRODUTO.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA AND VENDAS_PRODUTO.ENTREGA=A.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA=A.LIMITE)
FROM W_ACOMPANHAMENTO_CARTEIRA A 
--WHERE A.PERIODO_PCP='2013 maio'
GROUP BY A.PERIODO_PCP,A.NUMERO_ENTREGA,A.ENTREGA,LIMITE
ORDER BY PERIODO_PCP,NUMERO_ENTREGA


SELECT * FROM W_ACOMPANHAMENTO_CARTEIRA


-- ATRASO
SELECT COUNT(DISTINCT VENDAS_PRODUTO.PEDIDO)
FROM VENDAS_PRODUTO
JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD 
ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO 
JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
WHERE VENDAS.APROVACAO = 'A' 
AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
AND VENDAS.EMISSAO >='20130101' 
AND FATURAMENTO.EMISSAO > VENDAS_PRODUTO.LIMITE_ENTREGA
-- ANTECIPADO
SELECT DISTINCT VENDAS_PRODUTO.PEDIDO
FROM VENDAS_PRODUTO
JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD 
ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO 
JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
WHERE VENDAS.APROVACAO = 'A' 
AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
AND VENDAS.EMISSAO >='20130101' 
AND FATURAMENTO.EMISSAO < VENDAS_PRODUTO.ENTREGA

-- NO PRAZO
SELECT COUNT(DISTINCT VENDAS_PRODUTO.PEDIDO)
FROM VENDAS_PRODUTO
JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD 
ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO 
JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
WHERE VENDAS.APROVACAO = 'A' 
AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
AND VENDAS.EMISSAO >='20130101' 
AND FATURAMENTO.EMISSAO BETWEEN VENDAS_PRODUTO.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA


SELECT DISTINCT PEDIDO FROM FATURAMENTO_PROD A
JOIN FATURAMENTO B ON B.PEDIDO=A.PEDIDO
WHERE B.EMISSAO > 


SELECT * FROM FATURAMENTO_PROD
  
  
--- por quantidade de pe�as

-- PEDIDOS FATUIRADOS NO PRAZO, ANTECIPADOS E ATRASADO
SELECT A.PERIODO_PCP,A.NUMERO_ENTREGA,A.ENTREGA,A.LIMITE,
QTDE_PECAS_ATRASO = ( SELECT SUM(VENDAS_PRODUTO.QTDE_ENTREGUE)
					   FROM VENDAS_PRODUTO
					   JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
					   JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD 
				       ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO 
				       JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
				       WHERE VENDAS.APROVACAO = 'A' 
				       AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
				       AND VENDAS.EMISSAO >='20130101' 
				       AND FATURAMENTO.EMISSAO > VENDAS_PRODUTO.LIMITE_ENTREGA AND VENDAS_PRODUTO.ENTREGA=A.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA=A.LIMITE),
QTDE_PECAS_ANTECIPADOS=(SELECT SUM(VENDAS_PRODUTO.QTDE_ENTREGUE)
						 FROM VENDAS_PRODUTO
						 JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
						 JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD 
						 ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO 
						 JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
						 WHERE VENDAS.APROVACAO = 'A' 
						 AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
						 AND VENDAS.EMISSAO >='20130101' 
						 AND FATURAMENTO.EMISSAO < VENDAS_PRODUTO.ENTREGA AND VENDAS_PRODUTO.ENTREGA=A.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA=A.LIMITE), 
QTDE_PECAS_NO_PRAZO=(SELECT SUM(VENDAS_PRODUTO.QTDE_ENTREGUE)
					  FROM VENDAS_PRODUTO
					  JOIN VENDAS ON VENDAS.PEDIDO=VENDAS_PRODUTO.PEDIDO 
					  JOIN (SELECT NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO,QTDE=SUM(QTDE) FROM FATURAMENTO_PROD GROUP BY NF_SAIDA,SERIE_NF,PEDIDO,PRODUTO,COR_PRODUTO) AS FAT_PROD 
					  ON FAT_PROD.PEDIDO = VENDAS_PRODUTO.PEDIDO 
					  JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA = FAT_PROD.NF_SAIDA AND FATURAMENTO.SERIE_NF = FAT_PROD.SERIE_NF
					  WHERE VENDAS.APROVACAO = 'A' 
					  AND TIPO NOT IN ('AMOSTRA','BONIFICACAO','BRINDE','MATERIAL PROMOCIONAL','TROCA DE PE�AS','VENDA INTERNA') 
					  AND VENDAS.EMISSAO >='20130101' 
					  AND FATURAMENTO.EMISSAO BETWEEN VENDAS_PRODUTO.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA AND VENDAS_PRODUTO.ENTREGA=A.ENTREGA AND VENDAS_PRODUTO.LIMITE_ENTREGA=A.LIMITE)
FROM W_ACOMPANHAMENTO_CARTEIRA A 
--WHERE A.PERIODO_PCP='2013 maio'
GROUP BY A.PERIODO_PCP,A.NUMERO_ENTREGA,A.ENTREGA,LIMITE
ORDER BY NUMERO_ENTREGA
  