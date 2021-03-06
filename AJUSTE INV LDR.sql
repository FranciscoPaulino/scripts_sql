update PRODUTOS
set INATIVO=0


--- IMPORTA PRODUTOS E ESTOQUES DR VAREJO
INSERT INTO ESTOQUE_PROD_CTG_ITENS (NOME_CONTAGEM,PRODUTO,COR_PRODUTO,
S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,SALDO_CONTAGEM,DATA_PARA_TRANSFERENCIA)
SELECT 'INV RGIS DEZ 2015',W_ESTOQUE_PRODUTOS_00.PRODUTO,COR_PRODUTO,ES1,ES2,ES3,ES4,ES5,ES6,ES7,ES8,ES9,ES10,ES11,ES12,ES13,ES14,ES15,ES16,ES17,ES18,ES19,ES20,ES21,ES22,ES23,
(ES1+ES2+ES3+ES4+ES5+ES6+ES7+ES8+ES9+ES10+ES11+ES12+ES13+ES14+ES15+ES16+ES17+ES18+ES19+ES20+ES21+ES22+ES23),GETDATE()
FROM W_ESTOQUE_PRODUTOS_00 
JOIN PRODUTOS ON W_ESTOQUE_PRODUTOS_00.PRODUTO=PRODUTOS.PRODUTO 
JOIN FILIAIS ON W_ESTOQUE_PRODUTOS_00.FILIAL = FILIAIS.FILIAL 
WHERE W_ESTOQUE_PRODUTOS_00.FILIAL = 'DR VAREJO'

DELETE FROM  ESTOQUE_PROD_CTG_ITENS
WHERE NOME_CONTAGEM='INV RGIS DEZ 2015'

-----
DELETE A 
FROM ESTOQUE_PROD_CTG_ITENS A
JOIN PRODUTOS B ON B.PRODUTO=A.PRODUTO
WHERE B.GRUPO_PRODUTO='MERCHANDISING' AND NOME_CONTAGEM='INV RGIS DEZ 2015'
------


--- IMPORTA PRODUTOS E ESTOQUES LD
INSERT INTO ESTOQUE_PROD_CTG_ITENS (NOME_CONTAGEM,PRODUTO,COR_PRODUTO,
S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,SALDO_CONTAGEM,DATA_PARA_TRANSFERENCIA)
SELECT 'INV RGIS DEZ 2015 LD',W_ESTOQUE_PRODUTOS_00.PRODUTO,COR_PRODUTO,ES1,ES2,ES3,ES4,ES5,ES6,ES7,ES8,ES9,ES10,ES11,ES12,ES13,ES14,ES15,ES16,ES17,ES18,ES19,ES20,ES21,ES22,ES23,
(ES1+ES2+ES3+ES4+ES5+ES6+ES7+ES8+ES9+ES10+ES11+ES12+ES13+ES14+ES15+ES16+ES17+ES18+ES19+ES20+ES21+ES22+ES23),GETDATE()
FROM W_ESTOQUE_PRODUTOS_00 
JOIN PRODUTOS ON W_ESTOQUE_PRODUTOS_00.PRODUTO=PRODUTOS.PRODUTO 
JOIN FILIAIS ON W_ESTOQUE_PRODUTOS_00.FILIAL = FILIAIS.FILIAL 
WHERE W_ESTOQUE_PRODUTOS_00.FILIAL = 'LD'


DELETE FROM  ESTOQUE_PROD_CTG_ITENS
WHERE NOME_CONTAGEM='INV RGIS DEZ 2015 LD'

select * from ESTOQUE_PROD_CONTAGEM
where NOME_CONTAGEM='INV RGIS DEZ 2015 LD'

--- IMPORTA PRODUTOS E ESTOQUES FORA DE LINHA
INSERT INTO ESTOQUE_PROD_CTG_ITENS (NOME_CONTAGEM,PRODUTO,COR_PRODUTO,
S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,SALDO_CONTAGEM,DATA_PARA_TRANSFERENCIA)
SELECT 'INV RGIS DEZ 2015 FDL',W_ESTOQUE_PRODUTOS_00.PRODUTO,COR_PRODUTO,ES1,ES2,ES3,ES4,ES5,ES6,ES7,ES8,ES9,ES10,ES11,ES12,ES13,ES14,ES15,ES16,ES17,ES18,ES19,ES20,ES21,ES22,ES23,
(ES1+ES2+ES3+ES4+ES5+ES6+ES7+ES8+ES9+ES10+ES11+ES12+ES13+ES14+ES15+ES16+ES17+ES18+ES19+ES20+ES21+ES22+ES23),GETDATE()
FROM W_ESTOQUE_PRODUTOS_00 
JOIN PRODUTOS ON W_ESTOQUE_PRODUTOS_00.PRODUTO=PRODUTOS.PRODUTO 
JOIN FILIAIS ON W_ESTOQUE_PRODUTOS_00.FILIAL = FILIAIS.FILIAL 
WHERE W_ESTOQUE_PRODUTOS_00.FILIAL = 'FORA DE LINHA'


DELETE FROM  ESTOQUE_PROD_CTG_ITENS
WHERE NOME_CONTAGEM='INV RGIS DEZ 2015 FDL'



-----

UPDATE MATERIAIS
SET INATIVO=0


select * from ESTOQUE_MAT_CTG_ITENS


SELECT * FROM CTB_BORDERO_LOG
WHERE LANCAMENTO='398628'


LX_CADE_COLUNA NOME_CONTAGEM 

SELECT Estoque_mat_ctg_itens.NOME_CONTAGEM, Estoque_mat_ctg_itens.MATERIAL, Estoque_mat_ctg_itens.COR_MATERIAL, Estoque_mat_ctg_itens.QTDE_ESTOQUE_AUX, Estoque_mat_ctg_itens.QTDE_ESTOQUE, Estoque_mat_ctg_itens.AJUSTE_ESTOQUE, Estoque_mat_ctg_itens.AJUSTE_ESTOQUE_AUX, Estoque_mat_ctg_itens.SALDO_AJUSTE, Estoque_mat_ctg_itens.SALDO_AJUSTE_AUX, Estoque_mat_contagem.EMISSAO, Estoque_mat_contagem.RESPONSAVEL, Estoque_mat_contagem.ESTOQUE_AJUSTADO, Estoque_mat_contagem.DATA_AJUSTE, Estoque_mat_contagem.FILIAL, Filiais.EMPRESA 
FROM  dbo.ESTOQUE_MAT_CTG_ITENS Estoque_mat_ctg_itens, dbo.ESTOQUE_MAT_CONTAGEM Estoque_mat_contagem  
INNER JOIN dbo.FILIAIS Filiais  ON  Estoque_mat_contagem.FILIAL = Filiais.FILIAL 
WHERE  Estoque_mat_contagem.NOME_CONTAGEM = Estoque_mat_ctg_itens.NOME_CONTAGEM AND  ( (  Estoque_mat_ctg_itens.MATERIAL = ( '95.05.0026' ) AND  Estoque_mat_ctg_itens.COR_MATERIAL = ( 'UNICA' ) ) AND  Estoque_mat_contagem.FILIAL = ( 'DR VAREJO' ) )


SELECT * FROM Estoque_mat_contagem
WHERE NOME_CONTAGEM='ARTIGOS VARIADOS 2'



UPDATE Estoque_mat_contagem
SET DATA_AJUSTE='20100318'
WHERE NOME_CONTAGEM='ARTIGOS VARIADOS 2'

SELECT * FROM Estoque_mat_ctg_itens
WHERE NOME_CONTAGEM='ARTIGOS VARIADOS 2'
