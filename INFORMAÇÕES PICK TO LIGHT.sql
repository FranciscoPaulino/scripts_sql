
-- PEDIDOS ATENDIDOS DIARIAMENTE
SELECT EMISSAO,COUNT(PEDIDO) FROM (
SELECT DISTINCT B.EMISSAO,A.PEDIDO FROM FATURAMENTO_PROD A
JOIN FATURAMENTO B ON B.NF_SAIDA = A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
WHERE B.EMISSAO >= '20130520' AND B.EMISSAO <= '20130525') AS FINAL
GROUP BY EMISSAO
ORDER BY EMISSAO


-- PEDIDOS ATENDIDOS DIARIAMENTE (LINHA)
SELECT EMISSAO,PEDIDO,COUNT(LINHA) FROM (
SELECT DISTINCT B.EMISSAO,C.LINHA,A.PEDIDO FROM FATURAMENTO_PROD A
JOIN FATURAMENTO B ON B.NF_SAIDA = A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
JOIN PRODUTOS C ON C.PRODUTO = A.PRODUTO
WHERE B.EMISSAO >= '20130520' AND B.EMISSAO <= '20130525') AS FINAL
GROUP BY EMISSAO,PEDIDO
ORDER BY EMISSAO


-- SKUS POR LINHA
SELECT B.LINHA,A.PRODUTO,A.COR_PRODUTO,A.GRADE FROM PRODUTOS_BARRA A
JOIN PRODUTOS B ON B.PRODUTO=A.PRODUTO
WHERE B.LINHA='CLASSIC'
GROUP BY B.LINHA

SELECT B.LINHA,COUNT(A.GRADE) FROM PRODUTOS_BARRA A
JOIN PRODUTOS B ON B.PRODUTO=A.PRODUTO
GROUP BY B.LINHA


--- ESTOQUE (SKUS) 

select * from PRODUTOS_BARRA PB
JOIN PRODUTOS P ON P.PRODUTO=PB.PRODUTO
WHERE P.COD_CATEGORIA='01' AND P.COD_SUBCATEGORIA='01' AND PB.CODIGO_BARRA_PADRAO=1



-- ITENS SEPARADOS POR MES
SELECT MONTH(EMISSAO),SUM(QTDE) FROM (
SELECT B.EMISSAO,A.PRODUTO,A.COR_PRODUTO,QTDE FROM FATURAMENTO_PROD A
JOIN FATURAMENTO B ON B.NF_SAIDA = A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
JOIN PRODUTOS C ON C.PRODUTO = A.PRODUTO
WHERE B.EMISSAO >= '20120101' AND B.EMISSAO <= '20121231') AS FINAL
GROUP BY MONTH(EMISSAO)
ORDER BY EMISSAO


--- QTDE DE CX POR PEDIDO
SELECT A.CAIXA
 FROM VENDAS_PROD_EMBALADO A
JOIN FATURAMENTO_CAIXAS B ON B.CAIXA=A.CAIXA

SELECT AVG(QTDE_CAIXA) FROM FATURAMENTO_CAIXAS




