SELECT * FROM CLASSIF_FISCAL
WHERE CLASSIF_FISCAL='6006.22.00'

LX_CADE_COLUNA ITEM

SELECT * FROM LCF_ITEM
WHERE COD_ITEM_INVENTARIO='15.01.0001'

--- ITEM FISCAL
SELECT B.FILIAL, B.RECEBIMENTO, A.ORIGEM_ITEM,A.NF_ENTRADA,A.SERIE_NF_ENTRADA,a.REFERENCIA,A.NOME_CLIFOR 
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA  AND A.NOME_CLIFOR=B.NOME_CLIFOR 
JOIN CADASTRO_ITEM_FISCAL C ON C.CODIGO_ITEM=A.REFERENCIA
WHERE ORIGEM_ITEM <> 'I' 
and RECEBIMENTO BETWEEN '20160101' AND '20160131'
--WHERE A.REFERENCIA='30.01.0031' AND RECEBIMENTO BETWEEN '20151101' AND '20151130' --AND ORIGEM_ITEM = 'I'


SELECT * FROM MATERIAIS
WHERE MATERIAL='CONHECIMENTO_FRETE'

SELECT * FROM CADASTRO_ITEM_FISCAL
WHERE CODIGO_ITEM='CONHECIMENTO_FRETE'

SELECT * FROM PRODUTOS
WHERE PRODUTO='CONHECIMENTO_FRETE'


UPDATE A
SET A.ORIGEM_ITEM = 'I'
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND B.NOME_CLIFOR=A.NOME_CLIFOR
WHERE CODIGO_ITEM = 'CONHECIMENTO_FRETE' AND B.recebimento BETWEEN '20160101' AND '20160131' AND A.ORIGEM_ITEM IS NULL


SELECT ORIGEM_ITEM,* FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND B.NOME_CLIFOR=A.NOME_CLIFOR
WHERE CODIGO_ITEM = 'CONHECIMENTO_FRETE' AND B.recebimento BETWEEN '20160101' AND '20160131' AND A.ORIGEM_ITEM IS NULL


SELECT ORIGEM_ITEM,* FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND B.NOME_CLIFOR=A.NOME_CLIFOR
WHERE CODIGO_ITEM='CONHECIMENTO_FRETE' AND A.ORIGEM_ITEM <> 'I'


LX_CADE_COLUNA ORIGEM_ITEM


SELECT ORIGEM_ITEM,* FROM LF_REGISTRO_ENTRADA_ITEM A
JOIN  LF_REGISTRO_ENTRADA B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND B.COD_CLIFOR=A.COD_CLIFOR
WHERE CODIGO_ITEM='CONHECIMENTO_FRETE' AND ORIGEM_ITEM is null-- <> 'I'
AND B.EMISSAO BETWEEN '20160101' AND '20160131'






SELECT * FROM LCF_ERRO_NOTA_ENTRADA_ITEM
WHERE CODIGO_ITEM='CONHECIMENTO_FRETE' AND ORIGEM_ITEM <> 'I'


SELECT * FROM LCF_ERRO_NOTA_SAIDA_ITEM
WHERE CODIGO_ITEM='CONHECIMENTO_FRETE' AND ORIGEM_ITEM <> 'I'



SELECT * FROM FATURAMENTO_ITEM
WHERE CODIGO_ITEM='CONHECIMENTO_FRETE'



UPDATE A
SET ORIGEM_ITEM = 'I'
SELECT A.ORIGEM_ITEM FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND B.NOME_CLIFOR=A.NOME_CLIFOR
WHERE CODIGO_ITEM='CONHECIMENTO_FRETE' AND ORIGEM_ITEM <> 'I'





SELECT * FROM CADASTRO_ITEM_FISCAL
WHERE CODIGO_ITEM='57705'  IN
(
'40502',                                             
'43040')



SELECT * FROM MATERIAIS
WHERE MATERIAL='40.03.0029'



--- ITEM FISCAL
UPDATE ENTRADAS_ITEM
SET ORIGEM_ITEM='I'
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA  AND A.NOME_CLIFOR=B.NOME_CLIFOR 
JOIN CADASTRO_ITEM_FISCAL C ON C.CODIGO_ITEM=A.REFERENCIA
WHERE ORIGEM_ITEM <> 'I' and RECEBIMENTO BETWEEN '20151201' AND '20151231' and 
C.CODIGO_ITEM IN(
'1246',
'1277',
'1279',
'1281',
'1282')





--- MATERIA PRIMA
SELECT B.FILIAL, B.RECEBIMENTO,A.COD_TABELA_FILHA,A.ORIGEM_ITEM,A.NF_ENTRADA,A.SERIE_NF_ENTRADA,a.REFERENCIA,A.NOME_CLIFOR 
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND A.NOME_CLIFOR=B.NOME_CLIFOR 
--JOIN MATERIAIS C ON C.MATERIAL=A.REFERENCIA
--WHERE ORIGEM_ITEM <> 'M' and RECEBIMENTO BETWEEN '20151101' AND '20151130'
WHERE RECEBIMENTO BETWEEN '20151201' AND '20151231' --AND ORIGEM_ITEM = 'I'
AND A.REFERENCIA IN(
'40654',
'42620',
'42655',
'45253',
'45661',
'47457',
'50368D1',
'51354K10',
'51364K10',
'51364K3',
'51364K4',
'51661',
'52169D31')



SELECT * FROM PRODUTOS
WHERE PRODUTO IN (
'40654',
'42620',
'42655',
'45253',
'45661',
'47457',
'50368D1',
'51354K10',
'51364K10',
'51364K3',
'51364K4',
'51661',
'52169D31')




lx_cade_coluna item_fiscal

--- PRODUTO ACABADO
SELECT  B.FILIAL, B.RECEBIMENTO,A.COD_TABELA_FILHA, A.ORIGEM_ITEM,A.NF_ENTRADA,A.SERIE_NF_ENTRADA,a.REFERENCIA,A.NOME_CLIFOR 
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND A.NOME_CLIFOR=B.NOME_CLIFOR 
JOIN PRODUTOS C ON C.PRODUTO=A.REFERENCIA
--WHERE ORIGEM_ITEM <> 'P' and RECEBIMENTO BETWEEN '20151201' AND '20151231'
--WHERE A.REFERENCIA='30.01.0031' AND RECEBIMENTO BETWEEN '20151201' AND '20151231' AND ORIGEM_ITEM = 'P'
WHERE RECEBIMENTO BETWEEN '20151201' AND '20151231' AND 
A.REFERENCIA IN(
'40654',
'42620',
'42655',
'45253',
'45661',
'47457',
'50368D1',
'51354K10',
'51364K10',
'51364K3',
'51364K4',
'51661',
'52169D31')


exec sp_executesql N'
/* lx005108spk  CursorAdapter: CUR_V_ENTRADAS_00_ITENS(Alias: v_entradas_00_itens)  */
SELECT ENTRADAS_ITEM.NOME_CLIFOR, ENTRADAS_ITEM.NF_ENTRADA, ENTRADAS_ITEM.SERIE_NF_ENTRADA, ENTRADAS_ITEM.ITEM_IMPRESSAO, ENTRADAS_ITEM.SUB_ITEM_TAMANHO, ENTRADAS_ITEM.DESCRICAO_ITEM, ENTRADAS_ITEM.QTDE_ITEM, ENTRADAS_ITEM.PRECO_UNITARIO, ENTRADAS_ITEM.CODIGO_ITEM, ENTRADAS_ITEM.DESCONTO_ITEM, ENTRADAS_ITEM.VALOR_ITEM, ENTRADAS_ITEM.COD_TABELA_FILHA, ENTRADAS_ITEM.TRIBUT_ICMS, TRIBUT_ICMS.DESCRICAO AS DESC_TRIBUT_ICMS, ENTRADAS_ITEM.TRIBUT_ORIGEM, TRIBUT_ORIGEM.DESCRICAO AS DESC_TRIBUT_ORIGEM, ENTRADAS_ITEM.UNIDADE, ENTRADAS_ITEM.CLASSIF_FISCAL, CLASSIF_FISCAL.DESC_CLASSIFICACAO, ENTRADAS_ITEM.CODIGO_FISCAL_OPERACAO, CTB_LX_NATUREZAS_OPERACAO.DENOMINACAO, ENTRADAS_ITEM.PESO, ENTRADAS_ITEM.CONTA_CONTABIL, CTB_CONTA_PLANO.DESC_CONTA, ENTRADAS_ITEM.QTDE_RETORNAR_BENEFICIAMENTO, ENTRADAS_ITEM.FAIXA, ENTRADAS_ITEM.COMISSAO_ITEM, ENTRADAS_ITEM.COMISSAO_ITEM_GERENTE, ENTRADAS_ITEM.INDICADOR_CFOP, CTB_LX_INDICADOR_CFOP.DESCRICAO_INDICADOR_CFOP, ENTRADAS_ITEM.QTDE_DEVOLVIDA, ENTRADAS_ITEM.PORCENTAGEM_ITEM_RATEIO, ENTRADAS_ITEM.ID_EXCECAO_IMPOSTO, CONVERT(NUMERIC(1),0) AS GERA_IMPOSTO, ENTRADAS_ITEM.REFERENCIA, ENTRADAS_ITEM.REFERENCIA_ITEM, ENTRADAS_ITEM.REFERENCIA_PEDIDO, ENTRADAS_ITEM.DIVERGENTE, ENTRADAS_ITEM.TIMESTAMP, ENTRADAS_ITEM.VALOR_ENCARGOS, ENTRADAS_ITEM.VALOR_DESCONTOS, ENTRADAS_ITEM.NAO_SOMA_VALOR, ENTRADAS_ITEM.VALOR_ENCARGOS_IMPORTACAO, ENTRADAS_ITEM.RATEIO_FILIAL, CTB_FILIAL_RATEIO.DESC_RATEIO_FILIAL, ENTRADAS_ITEM.RATEIO_CENTRO_CUSTO, ENTRADAS_ITEM.COD_REPRESENTANTE, ENTRADAS_ITEM.COD_REPRESENTANTE_GERENTE, CTB_CENTRO_CUSTO_RATEIO.DESC_RATEIO_CENTRO_CUSTO, ISNULL(COMPRAS.COMPRIMENTO_DE_ROLOS,0.00) AS COMPRIMENTO_DE_ROLOS,CADASTRO_ITEM_FISCAL.ITEM_FISCAL_GRUPO, CADASTRO_ITEM_GRUPO.DESC_ITEM_FISCAL_GRUPO, ENTRADAS_ITEM.VALOR_ENCARGOS_ADUANEIROS, ISNULL(CTB_EXCECAO_IMPOSTO.NAO_FATURA, 0) AS NAO_FATURA, ENTRADAS_ITEM.PORC_ITEM_RATEIO_FRETE, ENTRADAS_ITEM.ITEM_NFE, ENTRADAS_ITEM.MPADRAO_SEGURO_ITEM, ENTRADAS_ITEM.MPADRAO_FRETE_ITEM, ENTRADAS_ITEM.MPADRAO_ENCARGO_ITEM, ENTRADAS_ITEM.ORIGEM_ITEM, CONVERT(BIT,0) GERAR_IMPOSTO, ENTRADAS_ITEM.PRECO_UNITARIO_ORIGINAL, ENTRADAS_ITEM.CTB_TIPO_OPERACAO, ENTRADAS_ITEM.ENCARGOS_IMPORT_DIGITADO, ENTRADAS_ITEM.ID_SUB_PROJETO, AF_SUB_PROJETO.NOME_SUB_PROJETO,CASE WHEN ENTRADAS_ITEM.ORIGEM_ITEM=''P'' THEN PRODUTOS.TIPO_ITEM_SPED WHEN ENTRADAS_ITEM.ORIGEM_ITEM=''M'' THEN MATERIAIS.TIPO_ITEM_SPED WHEN ENTRADAS_ITEM.ORIGEM_ITEM=''I'' THEN CADASTRO_ITEM_FISCAL.TIPO_ITEM_SPED END TIPO_ITEM_SPED FROM ENTRADAS_ITEM INNER JOIN TRIBUT_ORIGEM ON ENTRADAS_ITEM.TRIBUT_ORIGEM = TRIBUT_ORIGEM.TRIBUT_ORIGEM INNER JOIN TRIBUT_ICMS ON ENTRADAS_ITEM.TRIBUT_ICMS = TRIBUT_ICMS.TRIBUT_ICMS INNER JOIN CLASSIF_FISCAL ON ENTRADAS_ITEM.CLASSIF_FISCAL = CLASSIF_FISCAL.CLASSIF_FISCAL INNER JOIN CTB_LX_NATUREZAS_OPERACAO ON ENTRADAS_ITEM.CODIGO_FISCAL_OPERACAO = CTB_LX_NATUREZAS_OPERACAO.CODIGO_FISCAL_OPERACAO LEFT JOIN CTB_CONTA_PLANO ON ENTRADAS_ITEM.CONTA_CONTABIL = CTB_CONTA_PLANO.CONTA_CONTABIL LEFT JOIN CTB_LX_INDICADOR_CFOP ON ENTRADAS_ITEM.INDICADOR_CFOP = CTB_LX_INDICADOR_CFOP.INDICADOR_CFOP LEFT JOIN CTB_CENTRO_CUSTO_RATEIO ON ENTRADAS_ITEM.RATEIO_CENTRO_CUSTO = CTB_CENTRO_CUSTO_RATEIO.RATEIO_CENTRO_CUSTO LEFT JOIN CTB_FILIAL_RATEIO ON ENTRADAS_ITEM.RATEIO_FILIAL = CTB_FILIAL_RATEIO.RATEIO_FILIAL LEFT JOIN COMPRAS ON ENTRADAS_ITEM.REFERENCIA_PEDIDO = COMPRAS.PEDIDO LEFT JOIN CADASTRO_ITEM_FISCAL ON CADASTRO_ITEM_FISCAL.CODIGO_ITEM = ENTRADAS_ITEM.CODIGO_ITEM LEFT JOIN CADASTRO_ITEM_GRUPO ON CADASTRO_ITEM_GRUPO.ITEM_FISCAL_GRUPO = CADASTRO_ITEM_FISCAL.ITEM_FISCAL_GRUPO LEFT JOIN CTB_EXCECAO_IMPOSTO ON ENTRADAS_ITEM.ID_EXCECAO_IMPOSTO = CTB_EXCECAO_IMPOSTO.ID_EXCECAO_IMPOSTO   LEFT JOIN AF_SUB_PROJETO ON AF_SUB_PROJETO.ID_SUB_PROJETO = ENTRADAS_ITEM.ID_SUB_PROJETO  LEFT JOIN PRODUTOS ON PRODUTOS.PRODUTO=ENTRADAS_ITEM.REFERENCIA LEFT JOIN MATERIAIS ON MATERIAIS.MATERIAL=ENTRADAS_ITEM.REFERENCIA  WHERE ENTRADAS_ITEM.NF_ENTRADA = @P1 AND ENTRADAS_ITEM.NOME_CLIFOR = @P2 AND ENTRADAS_ITEM.SERIE_NF_ENTRADA = @P3',N'@P1 varchar(4),@P2 varchar(19),@P3 varchar(3)','2564','AFRODITE CONFECCOES','100'


SELECT * FROM PRODUTOS
WHERE PRODUTO='40572'



--- PRODUTO ACABADO
UPDATE ENTRADAS_ITEM
SET ORIGEM_ITEM='P'
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND A.NOME_CLIFOR=B.NOME_CLIFOR 
JOIN PRODUTOS C ON C.PRODUTO=A.REFERENCIA
WHERE ORIGEM_ITEM <> 'P' and RECEBIMENTO BETWEEN '20151201' AND '20151231'
--WHERE A.REFERENCIA='1233' AND RECEBIMENTO BETWEEN '20151101' AND '20151130' AND ORIGEM_ITEM = 'I'


--- MATERIA PRIMA
UPDATE ENTRADAS_ITEM
SET ORIGEM_ITEM='M'
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND A.NOME_CLIFOR=B.NOME_CLIFOR 
JOIN MATERIAIS C ON C.MATERIAL=A.REFERENCIA
WHERE RECEBIMENTO BETWEEN '20151201' AND '20151231' AND ORIGEM_ITEM = 'I'



UPDATE CTB_FECHAMENTO
SET INATIVO=1
WHERE USUARIO='SA' AND INATIVO=0 AND TIPO_FECHAMENTO<>'03'

SELECT * FROM CTB_FECHAMENTO
WHERE INATIVO=0



SELECT A.*, B.FILIAL, B.RECEBIMENTO, A.ORIGEM_ITEM,A.NF_ENTRADA,A.SERIE_NF_ENTRADA 
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND A.NOME_CLIFOR=B.NOME_CLIFOR 
--WHERE B.FILIAL='DR VAREJO' AND ORIGEM_ITEM = '' AND RECEBIMENTO BETWEEN '20151101' AND '20151130'
WHERE B.FILIAL='DR VAREJO' AND RECEBIMENTO BETWEEN '20151101' AND '20151130' AND (A.CODIGO_ITEM='30.01.0046' or a.REFERENCIA='30.01.0046')


SELECT B.FILIAL, B.RECEBIMENTO,A.COD_TABELA_FILHA,A.ORIGEM_ITEM,A.NF_ENTRADA,A.SERIE_NF_ENTRADA,a.REFERENCIA,A.NOME_CLIFOR 
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND A.NOME_CLIFOR=B.NOME_CLIFOR 
--JOIN MATERIAIS C ON C.MATERIAL=A.REFERENCIA
--WHERE ORIGEM_ITEM <> 'M' and RECEBIMENTO BETWEEN '20151101' AND '20151130'
WHERE RECEBIMENTO BETWEEN '20151201' AND '20151231' AND A.COD_TABELA_FILHA <> 'P'
AND A.REFERENCIA IN(
'40654',
'42620',
'42655',
'45253',
'45661',
'47457',
'50368D1',
'51354K10',
'51364K10',
'51364K3',
'51364K4',
'51661',
'52169D31')







UPDATE ENTRADAS_ITEM
SET COD_TABELA_FILHA='P'
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA AND A.NOME_CLIFOR=B.NOME_CLIFOR 
--WHERE B.FILIAL='DR VAREJO' AND ORIGEM_ITEM = '' AND RECEBIMENTO BETWEEN '20151101' AND '20151130'
WHERE RECEBIMENTO BETWEEN '20151201' AND '20151231' AND A.COD_TABELA_FILHA <> 'P'
AND A.REFERENCIA IN(
'40654',
'42620',
'42655',
'45253',
'45661',
'47457',
'50368D1',
'51354K10',
'51364K10',
'51364K3',
'51364K4',
'51661',
'52169D31')





SELECT A.*, B.FILIAL, B.RECEBIMENTO, A.ORIGEM_ITEM,A.NF_ENTRADA,A.SERIE_NF_ENTRADA 
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA
--WHERE B.FILIAL='DR VAREJO' AND ORIGEM_ITEM = '' AND RECEBIMENTO BETWEEN '20151101' AND '20151130'
WHERE B.FILIAL='DR VAREJO' AND RECEBIMENTO BETWEEN '20151201' AND '20151231' AND A.REFERENCIA='52907'


UPDATE ENTRADAS_ITEM
SET ORIGEM_ITEM='P'
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA
WHERE B.FILIAL='DR VAREJO' AND (ORIGEM_ITEM IS NULL OR ORIGEM_ITEM = '') AND RECEBIMENTO BETWEEN '20151101' AND '20151130'


UPDATE ENTRADAS_ITEM
SET ORIGEM_ITEM='P'
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA
WHERE CODIGO_ITEM='CONHECIMENTO_FRETE' and ORIGEM_ITEM is null and RECEBIMENTO BETWEEN '20151101' AND '20151130'


SELECT * FROM ENTRADAS_ITEM
WHERE REFERENCIA='52907'


SELECT * FROM LCF_LX_NCM


SELECT * FROM CADASTRO_ITEM_FISCAL
WHERE CODIGO_ITEM='30.01.0049'

---- INSERT DE NCM QUE N�O EXISTE NA TABELA DE GERAL SPED NCM
INSERT INTO LCF_LX_NCM (COD_NCM,DESC_NCM)
select REPLACE(A.CLASSIF_FISCAL,'.',''),DESC_CLASSIFICACAO FROM CLASSIF_FISCAL A
WHERE NOT EXISTS(SELECT * FROM LCF_LX_NCM WHERE COD_NCM=REPLACE(A.CLASSIF_FISCAL,'.',''))


INSERT INTO CLASSIF_FISCAL ([CLASSIF_FISCAL],[IPI],[DESC_CLASSIFICACAO],[CLASSIF_REDUZIDA]
,[ABATER_ICMS_NO_MEDIO],[ABATER_IPI_NO_MEDIO],[DATA_PARA_TRANSFERENCIA]
,[ABATER_PIS_NO_MEDIO],[ABATER_COFINS_NO_MEDIO]
,[RETE_FUENTE],[RETE_IVA],[RETE_ICA],[CODIGO_SERVICO],[COD_GENERO_SPED],
[CODIGO_CONTRIBUICAO_RECEITA_BRUTA] ,[ID_SERVICO_TIPO] ,[INATIVO] ,[LX_STATUS_REGISTRO])
select DISTINCT top 5 A.COD_NCM,[IPI],DESC_CLASSIFICACAO=SUBSTRING(A.DESC_NCM,1,40),B.[CLASSIF_REDUZIDA]
,B.[ABATER_ICMS_NO_MEDIO],B.[ABATER_IPI_NO_MEDIO],B.[DATA_PARA_TRANSFERENCIA]
,B.[ABATER_PIS_NO_MEDIO],B.[ABATER_COFINS_NO_MEDIO]
,B.[RETE_FUENTE],B.[RETE_IVA],B.[RETE_ICA],B.[CODIGO_SERVICO],B.[COD_GENERO_SPED],
B.[CODIGO_CONTRIBUICAO_RECEITA_BRUTA] ,B.[ID_SERVICO_TIPO] ,B.[INATIVO] ,B.[LX_STATUS_REGISTRO]  
FROM LCF_LX_NCM A
JOIN CLASSIF_FISCAL B ON REPLACE(B.CLASSIF_FISCAL,'.','')=COD_NCM
WHERE NOT EXISTS(SELECT * FROM CLASSIF_FISCAL WHERE CLASSIF_FISCAL=A.COD_NCM)



SELECT * FROM CLASSIF_FISCAL
WHERE DATA_PARA_TRANSFERENCIA>'20151201'




SELECT * FROM #CLASSIF_FISCAL_TMP A
WHERE NOT EXISTS(SELECT * FROM CLASSIF_FISCAL WHERE REPLACE(CLASSIF_FISCAL,'.','')=A.COD_NCM)



SELECT a.CLASSIF_FISCAL, B.FILIAL, B.RECEBIMENTO, A.ORIGEM_ITEM,A.NF_ENTRADA,A.SERIE_NF_ENTRADA 
FROM ENTRADAS_ITEM A
JOIN ENTRADAS B ON B.NF_ENTRADA=A.NF_ENTRADA AND B.SERIE_NF_ENTRADA=A.SERIE_NF_ENTRADA
WHERE B.FILIAL='DR VAREJO' AND RECEBIMENTO BETWEEN '20151101' AND '20151130' 
and NOT EXISTS(SELECT * FROM LCF_LX_NCM WHERE COD_NCM=A.CLASSIF_FISCAL)

BEGIN TRAN
ROLLBACK

UPDATE CLASSIF_FISCAL 
SET CLASSIF_FISCAL=REPLACE(CLASSIF_FISCAL,'.','')


------- S A I D A S ----------------------------

SELECT a.CLASSIF_FISCAL, B.FILIAL, B.EMISSAO, A.ORIGEM_ITEM,A.NF_SAIDA,A.SERIE_NF,A.REFERENCIA 
FROM FATURAMENTO_ITEM A
JOIN FATURAMENTO B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
WHERE B.FILIAL='DR VAREJO' AND EMISSAO BETWEEN '20151201' AND '20151231' AND A.ORIGEM_ITEM<>'P'
AND A.REFERENCIA IN(
'40654',
'42620',
'42655',
'45253',
'45661',
'47457',
'50368D1',
'51354K10',
'51364K10',
'51364K3',
'51364K4',
'51661',
'52169D31')




UPDATE A
SET A.ORIGEM_ITEM = 'P'
FROM FATURAMENTO_ITEM A
JOIN FATURAMENTO B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
WHERE B.FILIAL='DR VAREJO' AND EMISSAO BETWEEN '20151201' AND '20151231' AND A.ORIGEM_ITEM<>'P'
AND A.REFERENCIA IN(
'40654',
'42620',
'42655',
'45253',
'45661',
'47457',
'50368D1',
'51354K10',
'51364K10',
'51364K3',
'51364K4',
'51661',
'52169D31')



