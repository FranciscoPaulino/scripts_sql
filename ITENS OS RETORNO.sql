SELECT FATURAMENTO_ITEM.QTDE_ITEM,c.qtde_total, ROUND(FATURAMENTO_ITEM.QTDE_ITEM/c.qtde_total,3), FILIAL='', FATURAMENTO_ITEM.NF_SAIDA, FATURAMENTO_ITEM.SERIE_NF, ITEM_IMPRESSAO,
FATURAMENTO_ITEM.SUB_ITEM_TAMANHO, FATURAMENTO_ITEM.DESCRICAO_ITEM, 
QTDE_ITEM = ROUND( (FATURAMENTO_ITEM.QTDE_ITEM/c.qtde_total)*120,3) , FATURAMENTO_ITEM.CODIGO_ITEM, FATURAMENTO_ITEM.COD_TABELA_FILHA, TRIBUT_ICMS='', 
FATURAMENTO_ITEM.TRIBUT_ORIGEM, FATURAMENTO_ITEM.UNIDADE, VALOR_ITEM = ROUND((FATURAMENTO_ITEM.PRECO_UNITARIO * (ROUND(FATURAMENTO_ITEM.QTDE_ITEM/c.qtde_total,3) * 120)),2), FATURAMENTO_ITEM.CLASSIF_FISCAL,
FATURAMENTO_ITEM.PRECO_UNITARIO, FATURAMENTO_ITEM.PORCENTAGEM_ITEM_RATEIO, 
CODIGO_FISCAL_OPERACAO='5902', FATURAMENTO_ITEM.DESCONTO_ITEM, FATURAMENTO_ITEM.PESO, FATURAMENTO_ITEM.CONTA_CONTABIL, 
QTDE_RETORNAR_BENEFICIAMENTO = ROUND( (FATURAMENTO_ITEM.QTDE_ITEM/c.qtde_total)*120,3), FATURAMENTO_ITEM.MPADRAO_PRECO_UNITARIO, FATURAMENTO_ITEM.MPADRAO_DESCONTO_ITEM,
MPADRAO_VALOR_ITEM = ROUND((FATURAMENTO_ITEM.PRECO_UNITARIO * ((FATURAMENTO_ITEM.QTDE_ITEM/c.qtde_total) * 120)),2), FATURAMENTO_ITEM.FAIXA, FATURAMENTO_ITEM.COMISSAO_ITEM, FATURAMENTO_ITEM.COMISSAO_ITEM_GERENTE, 
FATURAMENTO_ITEM.INDICADOR_CFOP, FATURAMENTO_ITEM.QTDE_DEVOLVIDA, ID_EXCECAO_IMPOSTO='1035', FATURAMENTO_ITEM.REFERENCIA, FATURAMENTO_ITEM.REFERENCIA_ITEM, 
FATURAMENTO_ITEM.REFERENCIA_PEDIDO, CTB_LX_INDICADOR_CFOP.DESCRICAO_INDICADOR_CFOP, TRIBUT_ORIGEM_DESCRICAO=TRIBUT_ORIGEM.DESCRICAO, TRIBUT_ICMS_DESCRICAO=  TRIBUT_ICMS.DESCRICAO, 
CTB_CONTA_PLANO.DESC_CONTA, CLASSIF_FISCAL.DESC_CLASSIFICACAO, CONVERT(BIT, 0) AS GERAR_IMPOSTO, ISNULL(FATURAMENTO_ITEM.MPADRAO_VALOR_ENCARGOS, 0)  AS MPADRAO_VALOR_ENCARGOS, 
ISNULL(FATURAMENTO_ITEM.MPADRAO_VALOR_DESCONTOS, 0) AS MPADRAO_VALOR_DESCONTOS, ISNULL(FATURAMENTO_ITEM.NAO_SOMA_VALOR, 0) AS NAO_SOMA_VALOR, CONVERT(BIT, 0) AS POSSUI_SUBS_TRIBUTARIA, 
CASE WHEN (FATURAMENTO_ITEM.PRECO_UNITARIO + FATURAMENTO_ITEM.DESCONTO_ITEM) = 0 THEN 0  ELSE CONVERT(NUMERIC(8, 4), (FATURAMENTO_ITEM.DESCONTO_ITEM / (FATURAMENTO_ITEM.PRECO_UNITARIO + 
FATURAMENTO_ITEM.DESCONTO_ITEM)) * 100) END PORC_DESCONTO_ITEM, CONVERT(NUMERIC(14, 2), FATURAMENTO_ITEM.PRECO_UNITARIO  + FATURAMENTO_ITEM.DESCONTO_ITEM) AS PRECO_BRUTO, 
CONVERT(NUMERIC(14, 2), FATURAMENTO_ITEM.MPADRAO_PRECO_UNITARIO + FATURAMENTO_ITEM.MPADRAO_DESCONTO_ITEM) AS MPADRAO_PRECO_BRUTO, FATURAMENTO_ITEM.OBS_ITEM, CADASTRO_ITEM_FISCAL.ITEM_FISCAL_GRUPO, 
CADASTRO_ITEM_GRUPO.DESC_ITEM_FISCAL_GRUPO, FATURAMENTO_ITEM.ITEM_NFE, FIMP.NAO_FATURA, FATURAMENTO_ITEM.MPADRAO_SEGURO_ITEM, FATURAMENTO_ITEM.MPADRAO_FRETE_ITEM, FATURAMENTO_ITEM.MPADRAO_ENCARGO_ITEM, 
CTB_FILIAL_RATEIO.RATEIO_FILIAL, FATURAMENTO_ITEM.RATEIO_CENTRO_CUSTO, CTB_FILIAL_RATEIO.DESC_RATEIO_FILIAL, CTB_CENTRO_CUSTO_RATEIO.DESC_RATEIO_CENTRO_CUSTO, FATURAMENTO_ITEM.ORIGEM_ITEM, 
FATURAMENTO_ITEM.VALOR_IMPOSTO_ITEM, FATURAMENTO_ITEM.PRECO_UNITARIO_ORIGINAL, FATURAMENTO_ITEM.CODIGO_FCI,            
FATURAMENTO_ITEM.ID_SUB_PROJETO, AF_SUB_PROJETO.NOME_SUB_PROJETO, CASE  WHEN FATURAMENTO_ITEM.ORIGEM_ITEM='P' THEN PRODUTOS.TIPO_ITEM_SPED  WHEN FATURAMENTO_ITEM.ORIGEM_ITEM='M' THEN MATERIAIS.TIPO_ITEM_SPED 
 WHEN FATURAMENTO_ITEM.ORIGEM_ITEM='I' THEN CADASTRO_ITEM_FISCAL.TIPO_ITEM_SPED END TIPO_ITEM_SPED, FATURAMENTO_ITEM.VALOR_IMPOSTO_ITEM_MUNICIPAL, FATURAMENTO_ITEM.VALOR_IMPOSTO_ITEM_ESTADUAL, 
FATURAMENTO_ITEM.ID_CEST_NCM, TABELA_LX_CEST.DESCRICAO FROM      FATURAMENTO_ITEM  JOIN      TRIBUT_ICMS ON        FATURAMENTO_ITEM.TRIBUT_ICMS = TRIBUT_ICMS.TRIBUT_ICMS JOIN      TRIBUT_ORIGEM ON       
FATURAMENTO_ITEM.TRIBUT_ORIGEM = TRIBUT_ORIGEM.TRIBUT_ORIGEM JOIN      CTB_LX_INDICADOR_CFOP  ON        FATURAMENTO_ITEM.INDICADOR_CFOP = CTB_LX_INDICADOR_CFOP.INDICADOR_CFOP JOIN      CLASSIF_FISCAL ON  
FATURAMENTO_ITEM.CLASSIF_FISCAL = CLASSIF_FISCAL.CLASSIF_FISCAL LEFT JOIN CTB_CONTA_PLANO ON        FATURAMENTO_ITEM.CONTA_CONTABIL = CTB_CONTA_PLANO.CONTA_CONTABIL 
LEFT JOIN CADASTRO_ITEM_FISCAL ON  ( CADASTRO_ITEM_FISCAL.CODIGO_ITEM=FATURAMENTO_ITEM.CODIGO_ITEM) LEFT JOIN CADASTRO_ITEM_GRUPO ON ( CADASTRO_ITEM_GRUPO.ITEM_FISCAL_GRUPO=CADASTRO_ITEM_FISCAL.ITEM_FISCAL_GRUPO) 
LEFT JOIN CTB_EXCECAO_IMPOSTO AS FIMP ON        ( FATURAMENTO_ITEM.ID_EXCECAO_IMPOSTO= FIMP.ID_EXCECAO_IMPOSTO) LEFT JOIN CTB_FILIAL_RATEIO ON        'SIGMA CONDOMINIO' = 
CTB_FILIAL_RATEIO.RATEIO_FILIAL LEFT JOIN CTB_CENTRO_CUSTO_RATEIO ON        FATURAMENTO_ITEM.RATEIO_CENTRO_CUSTO = CTB_CENTRO_CUSTO_RATEIO.RATEIO_CENTRO_CUSTO 
LEFT JOIN AF_SUB_PROJETO ON        AF_SUB_PROJETO.ID_SUB_PROJETO = FATURAMENTO_ITEM.ID_SUB_PROJETO LEFT JOIN PRODUTOS ON        PRODUTOS.PRODUTO=FATURAMENTO_ITEM.REFERENCIA LEFT JOIN MATERIAIS ON 
MATERIAIS.MATERIAL=FATURAMENTO_ITEM.REFERENCIA LEFT JOIN CEST_NCM ON		  CEST_NCM.ID=FATURAMENTO_ITEM.ID_CEST_NCM LEFT JOIN TABELA_LX_CEST ON		  TABELA_LX_CEST.ID = CEST_NCM.ID_CEST 
JOIN (select distinct nf_saida,serie_nf,material,ORDEM_PRODUCAO from estoque_sai1_mat with (nolock) where NF_SAIDA is not null and ORDEM_PRODUCAO is not null ) b on b.NF_SAIDA=FATURAMENTO_ITEM.NF_SAIDA 
and b.SERIE_NF=FATURAMENTO_ITEM.SERIE_NF and b.MATERIAL=FATURAMENTO_ITEM.CODIGO_ITEM 
JOIN producao_ordem c on c.ordem_producao=b.ordem_producao WHERE c.ORDEM_PRODUCAO='235488' AND FATURAMENTO_ITEM.COD_TABELA_FILHA='M' 

use DRLINGERIE

select round(VALOR_TOTAL,3),MPADRAO_VALOR_SUB_ITENS,MPADRAO_VALOR_TOTAL 
from FATURAMENTO
WHERE NF_SAIDA='004073' AND SERIE_NF='100'

select VALOR_ITEM,MPADRAO_VALOR_ITEM 
from FATURAMENTO_ITEM
WHERE NF_SAIDA='004073' AND SERIE_NF='100' AND COD_TABELA_FILHA='T'

select sum(VALOR_ITEM),sum(MPADRAO_VALOR_ITEM)
from FATURAMENTO_ITEM
WHERE NF_SAIDA='0000718' AND SERIE_NF='112' AND COD_TABELA_FILHA='T'


DELETE FATURAMENTO_ITEM
WHERE NF_SAIDA='004073' AND SERIE_NF='100' AND COD_TABELA_FILHA='T' AND ITEM_IMPRESSAO IN('1004','1005','1006')

UPDATE FATURAMENTO_ITEM
SET PRECO_UNITARIO_ORIGINAL=PRECO_UNITARIO
WHERE NF_SAIDA='004073' AND SERIE_NF='100' AND COD_TABELA_FILHA='T'

--- AJUSTE NFE SAIDA DAS OFICINAS

DELETE FATURAMENTO_ITEM
WHERE NF_SAIDA='0000826' 
AND SERIE_NF='112' 
AND COD_TABELA_FILHA='T' 
AND VALOR_ITEM=0.01


UPDATE FATURAMENTO_ITEM
SET VALOR_ITEM=PRECO_UNITARIO*QTDE_ITEM, MPADRAO_VALOR_ITEM=PRECO_UNITARIO*QTDE_ITEM
WHERE NF_SAIDA='0001039' 
AND SERIE_NF='112' 
AND COD_TABELA_FILHA='T' 


UPDATE A
SET A.VALOR_TOTAL=B.VALOR_TOTAL, A.MPADRAO_VALOR_TOTAL=B.MPADRAO_VALOR_ITEM, A.VALOR_SUB_ITENS=B.MPADRAO_VALOR_ITEM, A.MPADRAO_VALOR_SUB_ITENS=B.MPADRAO_VALOR_ITEM
FROM FATURAMENTO A
JOIN (SELECT NF_SAIDA, SERIE_NF, VALOR_TOTAL=SUM(VALOR_ITEM),MPADRAO_VALOR_ITEM=SUM(MPADRAO_VALOR_ITEM) 
FROM FATURAMENTO_ITEM WITH (NOLOCK) 
WHERE NF_SAIDA='0001039' AND SERIE_NF='112' AND NAO_SOMA_VALOR = 0 GROUP BY NF_SAIDA,SERIE_NF) B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
WHERE A.NF_SAIDA='0001039' 
AND A.SERIE_NF='112' 


SELECT * FROM FATURAMENTO
WHERE NF_SAIDA='0001039' AND SERIE_NF='112'



UPDATE A
SET A.VALOR_TOTAL=B.VALOR_TOTAL, A.MPADRAO_VALOR_TOTAL=B.MPADRAO_VALOR_ITEM
SELECT A.* FROM FATURAMENTO A
JOIN (SELECT NF_SAIDA, SERIE_NF, VALOR_TOTAL=SUM(VALOR_ITEM),MPADRAO_VALOR_ITEM=SUM(MPADRAO_VALOR_ITEM) 
FROM FATURAMENTO_ITEM WITH (NOLOCK) 
WHERE NF_SAIDA='0000718' AND SERIE_NF='112' AND NAO_SOMA_VALOR = 0 GROUP BY NF_SAIDA,SERIE_NF) B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
WHERE A.NF_SAIDA='0000718' 
AND A.SERIE_NF='112' 




update cadastro_cli_for
set cgc_cpf='00000000004'
where clifor='513793'


select QTDE_ITEM,PRECO_UNITARIO,VALOR_ITEM from FATURAMENTO_ITEM
WHERE NF_SAIDA='0002906' AND SERIE_NF='105'

select QTDE_TOTAL,VALOR_TOTAL 
from FATURAMENTO
WHERE NF_SAIDA='0002906' AND SERIE_NF='105'

select * FROM FATURAMENTO_ITEM
WHERE NF_SAIDA='0089266' AND SERIE_NF='55'

UPDATE FATURAMENTO_ITEM
SET UNIDADE='UN'
WHERE NF_SAIDA='0089266' AND SERIE_NF='55'



select * from ESTOQUE_SAI_MAT
where req_material='0212920'

EXEC SP_AJUSTE_NFE_OFICINA_RETORNO_ITENS '0003218','105' 
EXEC SP_AJUSTE_NFE_OFICINA_RETORNO_ITENS '0003181','105' 
EXEC SP_AJUSTE_NFE_OFICINA_RETORNO_ITENS '0003184','105' 

EXEC SP_AJUSTE_NFE_OFICINA_RETORNO_ITENS '0003153','105' 
EXEC SP_AJUSTE_NFE_OFICINA_RETORNO_ITENS '0003160','105' 
EXEC SP_AJUSTE_NFE_OFICINA_RETORNO_ITENS '0003170','105' 




--- CRIA��O DE PROCEDURE PARA RECALCULAR VALORES
CREATE PROC SP_AJUSTE_NFE_OFICINA_RETORNO_ITENS 
@NF_SAIDA CHAR(20),@SERIE_NF CHAR(5)
AS 
UPDATE FATURAMENTO_ITEM
SET VALOR_ITEM=PRECO_UNITARIO*QTDE_ITEM, MPADRAO_VALOR_ITEM=PRECO_UNITARIO*QTDE_ITEM
WHERE NF_SAIDA=@NF_SAIDA--'0001039' 
AND SERIE_NF=@SERIE_NF--'112' 
AND COD_TABELA_FILHA='T' 

UPDATE A
SET A.VALOR_TOTAL=B.VALOR_TOTAL, A.MPADRAO_VALOR_TOTAL=B.MPADRAO_VALOR_ITEM, A.VALOR_SUB_ITENS=B.MPADRAO_VALOR_ITEM, A.MPADRAO_VALOR_SUB_ITENS=B.MPADRAO_VALOR_ITEM
FROM FATURAMENTO A
JOIN (SELECT NF_SAIDA, SERIE_NF, VALOR_TOTAL=SUM(VALOR_ITEM),MPADRAO_VALOR_ITEM=SUM(MPADRAO_VALOR_ITEM) 
FROM FATURAMENTO_ITEM WITH (NOLOCK) 
WHERE NF_SAIDA=@NF_SAIDA AND SERIE_NF=@SERIE_NF AND NAO_SOMA_VALOR = 0 GROUP BY NF_SAIDA,SERIE_NF) B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
WHERE A.NF_SAIDA=@NF_SAIDA
AND A.SERIE_NF=@SERIE_NF



UPDATE CADASTRO_CLI_FOR
SET IE_RG='ISENTO'
WHERE PJ_PF ='0' OR PJ_PF = ''

SELECT * FROM CADASTRO_CLI_FOR
WHERE NOME_CLIFOR LIKE 'FRANCISCO PAULINO%'   (PJ_PF ='0') AND (RG_IE = '' OR RG_IE = '0') AND NOME_CLIFOR LIKE 'FRANCISCO PAULINO%'







select * from VENDAS_LOTE