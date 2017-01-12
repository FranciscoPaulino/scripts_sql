DELETE FROM LCF_ITEM_CONVERSAO


SELECT SK_ITEM,ID_UNIDADE,COUNT(*) FROM LCF_ITEM_CONVERSAO
GROUP BY SK_ITEM,ID_UNIDADE
ORDER BY COUNT(*)


USE [TESTES]
GO

/****** Object:  Index [XAK1LCF_ITEM_CONVERSAO]    Script Date: 10/13/2015 16:31:48 ******/
CREATE UNIQUE NONCLUSTERED INDEX [XAK1LCF_ITEM_CONVERSAO] ON [dbo].[LCF_ITEM_CONVERSAO] 
(
	[SK_ITEM] ASC,
	[ID_UNIDADE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




USE [TESTES]
GO

/****** Object:  Index [XPKLCF_ITEM_CONVERSAO]    Script Date: 10/13/2015 16:32:01 ******/
ALTER TABLE [dbo].[LCF_ITEM_CONVERSAO] ADD  CONSTRAINT [XPKLCF_ITEM_CONVERSAO] PRIMARY KEY CLUSTERED 
(
	[ID_ITEM_CONVERSAO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


SELECT * FROM W_LF_FATOR_CONVERSAO with (nolock)
WHERE FATOR_CONVERSAO_UNIDADE <>





SELECT ESTOQUE_RET1_MAT.UNIDADE_FORNECEDOR, ENTRADAS_ITEM.NF_ENTRADA,ENTRADAS_ITEM.SERIE_NF_ENTRADA,ENTRADAS_ITEM.CODIGO_ITEM
FROM ENTRADAS_ITEM (NOLOCK)
		JOIN ESTOQUE_RET_MAT (NOLOCK) ON ENTRADAS_ITEM.NF_ENTRADA = ESTOQUE_RET_MAT.NF_ENTRADA AND ENTRADAS_ITEM.SERIE_NF_ENTRADA = ESTOQUE_RET_MAT.SERIE_NF_ENTRADA AND ENTRADAS_ITEM.NOME_CLIFOR = ESTOQUE_RET_MAT.NOME_CLIFOR
		JOIN ESTOQUE_RET1_MAT (NOLOCK) ON ESTOQUE_RET_MAT.REQ_MATERIAL = ESTOQUE_RET1_MAT.REQ_MATERIAL AND ESTOQUE_RET_MAT.FILIAL = ESTOQUE_RET1_MAT.FILIAL AND ENTRADAS_ITEM.ITEM_IMPRESSAO = ESTOQUE_RET1_MAT.ITEM_IMPRESSAO 
		JOIN MATERIAIS (NOLOCK) ON MATERIAIS.MATERIAL = ESTOQUE_RET1_MAT.MATERIAL 
WHERE UNIDADE_FORNECEDOR <> MATERIAIS.UNID_ESTOQUE	AND FATOR_CONVERSAO_UNIDADE <> 1 and UNIDADE_FORNECEDOR=' '


update ESTOQUE_RET1_MAT 
SET UNIDADE_FORNECEDOR='UN'
FROM ENTRADAS_ITEM (NOLOCK)
		JOIN ESTOQUE_RET_MAT (NOLOCK) ON ENTRADAS_ITEM.NF_ENTRADA = ESTOQUE_RET_MAT.NF_ENTRADA AND ENTRADAS_ITEM.SERIE_NF_ENTRADA = ESTOQUE_RET_MAT.SERIE_NF_ENTRADA AND ENTRADAS_ITEM.NOME_CLIFOR = ESTOQUE_RET_MAT.NOME_CLIFOR
		JOIN ESTOQUE_RET1_MAT (NOLOCK) ON ESTOQUE_RET_MAT.REQ_MATERIAL = ESTOQUE_RET1_MAT.REQ_MATERIAL AND ESTOQUE_RET_MAT.FILIAL = ESTOQUE_RET1_MAT.FILIAL AND ENTRADAS_ITEM.ITEM_IMPRESSAO = ESTOQUE_RET1_MAT.ITEM_IMPRESSAO 
		JOIN MATERIAIS (NOLOCK) ON MATERIAIS.MATERIAL = ESTOQUE_RET1_MAT.MATERIAL 
WHERE UNIDADE_FORNECEDOR <> MATERIAIS.UNID_ESTOQUE	AND FATOR_CONVERSAO_UNIDADE <> 1 and UNIDADE_FORNECEDOR=' '


--- DEIXAR FATOR DE CONVERSAO IGUAL AO CADASTRO DO MATERIAL
update ESTOQUE_RET1_MAT
SET ESTOQUE_RET1_MAT.FATOR_CONVERSAO_UNIDADE=MATERIAIS.FATOR_CONVERSAO
FROM ENTRADAS_ITEM (NOLOCK)
		JOIN ESTOQUE_RET_MAT (NOLOCK) ON ENTRADAS_ITEM.NF_ENTRADA = ESTOQUE_RET_MAT.NF_ENTRADA AND ENTRADAS_ITEM.SERIE_NF_ENTRADA = ESTOQUE_RET_MAT.SERIE_NF_ENTRADA AND ENTRADAS_ITEM.NOME_CLIFOR = ESTOQUE_RET_MAT.NOME_CLIFOR
		JOIN ESTOQUE_RET1_MAT (NOLOCK) ON ESTOQUE_RET_MAT.REQ_MATERIAL = ESTOQUE_RET1_MAT.REQ_MATERIAL AND ESTOQUE_RET_MAT.FILIAL = ESTOQUE_RET1_MAT.FILIAL AND ENTRADAS_ITEM.ITEM_IMPRESSAO = ESTOQUE_RET1_MAT.ITEM_IMPRESSAO 
		JOIN MATERIAIS (NOLOCK) ON MATERIAIS.MATERIAL = ESTOQUE_RET1_MAT.MATERIAL 
WHERE UNIDADE_FORNECEDOR <> MATERIAIS.UNID_ESTOQUE	AND FATOR_CONVERSAO_UNIDADE <> 1 


SELECT * FROM MATERIAIS
WHERE MATERIAL='30.02.0002'



SELECT * FROM LCF_ITEM_CONVERSAO

SELECT * FROM LCF_UNIDADE

UPDATE LCF_UNIDADE
SET UNIDADE='UN'
WHERE UNIDADE=''


LX_CADE_COLUNA SK_ITEM
LX_CADE_COLUNA ID_NOTA
LX_CADE_COLUNA ID_UNIDADE
LX_CADE_COLUNA FATOR_CONVERSAO_UNIDADE


SELECT * FROM LCF_NOTA_ENTRADA
WHERE ID_NOTA IN (
'359794',
'359795',
'359863',
'360577',
'360578',
'361036',
'361037')




SELECT * FROM LCF_NOTA_ENTRADA_ITEM
WHERE SK_ITEM IN 
(
'268130',
'268034',
'268034',
'268130',
'268130',
'268034',
'268034',
'268130',
'268130',
'268034',
'268034',
'268130',
'268130',
'268034',
'268034',
'268130',
'268034'
)


SELECT * FROM LCF_NOTA_SAIDA_ITEM
WHERE SK_ITEM IN
(
270155,
270155,
270061,
270061,
270155,
270155,
270061,
270061,
270155,
270155,
270061,
270061,
270155,
270155,
270061,
270061,
270155,
270061
)

SELECT * FROM LCF_NOTA_SAIDA
WHERE ID_NOTA 
IN (
477728,
477729,
477532,
477761,
477308,
478016,
477535,
478017,
477996
)


Esse � um erro do campo origem item das notas fiscais. 

� um problema recorrente que o desenvolvimento j� est� tratando para que seja resolvido em definitivo.

Segue script liberado para que esse problema seja resolvido.

BEGIN TRAN ATUALIZA_ORIGEM_ITEM
 
ALTER TABLE FATURAMENTO_ITEM DISABLE TRIGGER LXU_FATURAMENTO_ITEM
 
UPDATE I
SET    I.ORIGEM_ITEM = 'P'
FROM   DBO.FATURAMENTO_ITEM AS I (NOLOCK)
       INNER JOIN DBO.PRODUTOS AS P (NOLOCK)
               ON COALESCE(I.REFERENCIA, I.CODIGO_ITEM) = P.PRODUTO
 
UPDATE I
SET    I.ORIGEM_ITEM = 'M'
FROM   DBO.FATURAMENTO_ITEM AS I (NOLOCK)
       INNER JOIN DBO.MATERIAIS AS M (NOLOCK)
               ON COALESCE(I.REFERENCIA, I.CODIGO_ITEM) = M.MATERIAL
 
UPDATE I
SET    I.ORIGEM_ITEM = 'I'
FROM   DBO.FATURAMENTO_ITEM AS I (NOLOCK)
       INNER JOIN DBO.CADASTRO_ITEM_FISCAL AS C (NOLOCK)
               ON COALESCE(I.REFERENCIA, I.CODIGO_ITEM) = C.CODIGO_ITEM
 
ALTER TABLE FATURAMENTO_ITEM ENABLE TRIGGER LXU_FATURAMENTO_ITEM
 
ALTER TABLE ENTRADAS_ITEM DISABLE TRIGGER LXU_ENTRADAS_ITEM
 
UPDATE I
SET    I.ORIGEM_ITEM = 'P'
FROM   DBO.ENTRADAS_ITEM AS I (NOLOCK)
       INNER JOIN DBO.PRODUTOS AS P (NOLOCK)
               ON COALESCE(I.REFERENCIA, I.CODIGO_ITEM) = P.PRODUTO
 
UPDATE I
SET    I.ORIGEM_ITEM = 'M'
FROM   DBO.ENTRADAS_ITEM AS I (NOLOCK)
       INNER JOIN DBO.MATERIAIS AS M (NOLOCK)
               ON COALESCE(I.REFERENCIA, I.CODIGO_ITEM) = M.MATERIAL
 
UPDATE I
SET    I.ORIGEM_ITEM = 'I'
FROM   DBO.ENTRADAS_ITEM AS I (NOLOCK)
       INNER JOIN DBO.CADASTRO_ITEM_FISCAL AS C (NOLOCK)
               ON COALESCE(I.REFERENCIA, I.CODIGO_ITEM) = C.CODIGO_ITEM
 
ALTER TABLE ENTRADAS_ITEM ENABLE TRIGGER LXU_ENTRADAS_ITEM
 
UPDATE A
SET    A.ORIGEM_ITEM = 'P'
FROM   DBO.LOJA_NOTA_FISCAL_ITEM AS A
       INNER JOIN DBO.PRODUTOS AS B (NOLOCK)
               ON ISNULL(A.CODIGO_ITEM, A.REFERENCIA) = B.PRODUTO
 
UPDATE A
SET    A.ORIGEM_ITEM = 'I'
FROM   DBO.LOJA_NOTA_FISCAL_ITEM AS A
WHERE  A.ORIGEM_ITEM IS NULL
 
UPDATE A
SET    A.ORIGEM_ITEM = B.ORIGEM_ITEM
FROM   DBO.LF_REGISTRO_SAIDA_ITEM AS A
       INNER JOIN DBO.FILIAIS AS FIL (NOLOCK)
               ON A.COD_FILIAL = FIL.COD_FILIAL
       INNER JOIN DBO.FATURAMENTO_ITEM AS B (NOLOCK)
               ON A.NF_SAIDA = B.NF_SAIDA
                  AND A.SERIE_NF = B.SERIE_NF
                  AND FIL.FILIAL = B.FILIAL
                  AND A.ITEM_IMPRESSAO = B.ITEM_IMPRESSAO
                  AND A.SUB_ITEM_TAMANHO = B.SUB_ITEM_TAMANHO
 
UPDATE A
SET    A.ORIGEM_ITEM = B.ORIGEM_ITEM
FROM   DBO.LF_REGISTRO_SAIDA_ITEM AS A
       INNER JOIN DBO.FILIAIS AS FIL (NOLOCK)
               ON A.COD_FILIAL = FIL.COD_FILIAL
       INNER JOIN DBO.LOJAS_VAREJO AS LV (NOLOCK)
               ON FIL.FILIAL = LV.FILIAL
       INNER JOIN DBO.LOJA_NOTA_FISCAL_ITEM AS B (NOLOCK)
               ON A.NF_SAIDA = B.NF_NUMERO
                  AND A.SERIE_NF = B.SERIE_NF
                  AND LV.CODIGO_FILIAL = B.CODIGO_FILIAL
                  AND A.ITEM_IMPRESSAO = B.ITEM_IMPRESSAO
                  AND A.SUB_ITEM_TAMANHO = B.SUB_ITEM_TAMANHO
 
UPDATE A
SET    A.ORIGEM_ITEM = B.ORIGEM_ITEM
FROM   DBO.LF_REGISTRO_ENTRADA_ITEM AS A
       INNER JOIN DBO.CADASTRO_CLI_FOR AS CLI_FOR (NOLOCK)
               ON A.COD_CLIFOR = CLI_FOR.COD_CLIFOR
       INNER JOIN DBO.ENTRADAS_ITEM AS B (NOLOCK)
               ON A.NF_ENTRADA = B.NF_ENTRADA
                  AND A.SERIE_NF_ENTRADA = B.SERIE_NF_ENTRADA
                  AND CLI_FOR.NOME_CLIFOR = B.NOME_CLIFOR
                  AND A.ITEM_IMPRESSAO = B.ITEM_IMPRESSAO
                  AND A.SUB_ITEM_TAMANHO = B.SUB_ITEM_TAMANHO
 
UPDATE A
SET    A.ORIGEM_ITEM = B.ORIGEM_ITEM
FROM   DBO.LF_REGISTRO_ENTRADA_ITEM AS A
       INNER JOIN DBO.LF_REGISTRO_ENTRADA AS LRE (NOLOCK)
               ON A.ID_FISCAL = LRE.ID_FISCAL
       INNER JOIN DBO.FILIAIS AS FIL (NOLOCK)
               ON LRE.COD_FILIAL = FIL.COD_FILIAL
       INNER JOIN DBO.LOJAS_VAREJO AS LV (NOLOCK)
               ON FIL.FILIAL = LV.FILIAL
       INNER JOIN DBO.LOJA_NOTA_FISCAL_ITEM AS B (NOLOCK)
               ON A.NF_ENTRADA = B.NF_NUMERO
                  AND A.SERIE_NF_ENTRADA = B.SERIE_NF
                  AND LV.CODIGO_FILIAL = B.CODIGO_FILIAL
                  AND A.ITEM_IMPRESSAO = B.ITEM_IMPRESSAO
                  AND A.SUB_ITEM_TAMANHO = B.SUB_ITEM_TAMANHO
 
COMMIT TRAN ATUALIZA_ORIGEM_ITEM

