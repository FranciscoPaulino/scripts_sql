--- CONSULTAR EAN FORA DO PRODUTOS_BARRA OU FORA DA GRADE
SELECT * FROM INVENTARIO_RGIS
WHERE EAN NOT IN (SELECT CODIGO_BARRA FROM PRODUTOS_BARRA)


SELECT PB.* FROM PRODUTOS_BARRA PB
JOIN INVENTARIO_RGIS I ON I.EAN=PB.CODIGO_BARRA
WHERE PB.PRODUTO+PB.COR_PRODUTO IN (
select PRODUTO+COR_PRODUTO from ESTOQUE_PROD_CTG_ITENS
where NOME_CONTAGEM='INV RGIS DEZ 2013 FDL')


SELECT SUM(QTDE) FROM INVENTARIO_RGIS 


SELECT * FROM INVENTARIO_RGIS


select SUM(QTDE_CONTAGEM) from ESTOQUE_PROD_CTG_ITENS
where NOME_CONTAGEM='INV RGIS DEZ 2013 FDL'



INSERT INTO INVENTARIO_RGIS (EAN,QTDE)  
SELECT codigo_barra,qtde FROM OPENROWSET ('Microsoft.ACE.OLEDB.12.0',
'EXCEL 8.0;Database=C:\Inventario RGIS Dez2015\FDL.XLS'
,dados$)


delete from INVENTARIO_RGIS

sp_help INVENTARIO_RGIS