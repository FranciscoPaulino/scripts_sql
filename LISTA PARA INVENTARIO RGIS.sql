SELECT SUBSTRING(PRODUTOS_BARRA.PRODUTO,1,6)+SUBSTRING(PRODUTOS.DESC_PRODUTO,1,27)+SUBSTRING(PRODUTOS_BARRA.GRADE,1,3)+SUBSTRING(CODIGO_BARRA,1,13) 
FROM PRODUTOS_BARRA
JOIN PRODUTOS ON PRODUTOS.PRODUTO=PRODUTOS_BARRA.PRODUTO
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%'

