SELECT * FROM VENDAS_LOTE_COPIA_PEDIDO
WHERE PEDIDO_EXTERNO='024s.001156 '


SELECT LEN(SEQUENCIAL_DIGITACAO),REPLICATE('0',(4-LEN(SEQUENCIAL_DIGITACAO)))+CAST(SEQUENCIAL_DIGITACAO AS CHAR(4)),* FROM VENDAS_PRODUTO
WHERE PEDIDO='549582'
ORDER BY SEQUENCIAL_DIGITACAO


UPDATE VENDAS_PRODUTO
SET ITEM_PEDIDO=REPLICATE('0',(4-LEN(SEQUENCIAL_DIGITACAO)))+CAST(SEQUENCIAL_DIGITACAO AS CHAR(4))
WHERE PEDIDO='549582'


SELECT * FROM VENDAS_PRODUTO
WHERE PEDIDO LIKE ''


SELECT * FROM VENDAS_PRODUTO


SELECT * FROM #TMP

SELECT IDENTITY(Int, 1,1) As SEQ,* INTO #TMP FROM VENDAS_PRODUTO
WHERE PEDIDO='548535'
