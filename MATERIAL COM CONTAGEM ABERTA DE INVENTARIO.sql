
SELECT DISTINCT FILIAL,MATERIAL,COR_MATERIAL FROM W_MATERIAL_INVENTARIO_ABRIL_2015


CREATE VIEW W_MATERIAL_INVENTARIO_ABRIL_2015 AS 
select A.FILIAL,B.MATERIAL,B.COR_MATERIAL from ESTOQUE_MAT_CONTAGEM A
JOIN ESTOQUE_MAT_CTG_ITENS B ON B.NOME_CONTAGEM=A.NOME_CONTAGEM
WHERE ESTOQUE_AJUSTADO=0 AND YEAR(EMISSAO)=2015 AND MONTH(EMISSAO)=4

