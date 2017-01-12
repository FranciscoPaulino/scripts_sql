SELECT ESTOQUE_PRODUTOS.PRODUTO, ESTOQUE_PRODUTOS.COR_PRODUTO, ESTOQUE_PRODUTOS.FILIAL, 
ESTOQUE_PRODUTOS.ESTOQUE, ESTOQUE_PRODUTOS.ES1, ESTOQUE_PRODUTOS.ES2, ESTOQUE_PRODUTOS.ES3, 
ESTOQUE_PRODUTOS.ES4, ESTOQUE_PRODUTOS.ES5,ESTOQUE_PRODUTOS.ES6, ESTOQUE_PRODUTOS.ES7, ESTOQUE_PRODUTOS.ES8, 
ESTOQUE_PRODUTOS.ES9, ESTOQUE_PRODUTOS.ES10, ESTOQUE_PRODUTOS.ES11, ESTOQUE_PRODUTOS.ES12, ESTOQUE_PRODUTOS.ES13, 
ESTOQUE_PRODUTOS.ES14, ESTOQUE_PRODUTOS.ES15,      
ESTOQUE_PRODUTOS.ES16, ESTOQUE_PRODUTOS.ES17, ESTOQUE_PRODUTOS.ES18, ESTOQUE_PRODUTOS.ES19, ESTOQUE_PRODUTOS.ES20,      
ESTOQUE_PRODUTOS.ES21, ESTOQUE_PRODUTOS.ES22, ESTOQUE_PRODUTOS.ES23, ESTOQUE_PRODUTOS.ES24, ESTOQUE_PRODUTOS.ES25,     
ESTOQUE_PRODUTOS.ES26, ESTOQUE_PRODUTOS.ES27, ESTOQUE_PRODUTOS.ES28, ESTOQUE_PRODUTOS.ES29, ESTOQUE_PRODUTOS.ES30,     
ESTOQUE_PRODUTOS.ES31, ESTOQUE_PRODUTOS.ES32, ESTOQUE_PRODUTOS.ES33, ESTOQUE_PRODUTOS.ES34, ESTOQUE_PRODUTOS.ES35,      
ESTOQUE_PRODUTOS.ES36, ESTOQUE_PRODUTOS.ES37, ESTOQUE_PRODUTOS.ES38, ESTOQUE_PRODUTOS.ES39, ESTOQUE_PRODUTOS.ES40,      
ESTOQUE_PRODUTOS.ES41, ESTOQUE_PRODUTOS.ES42, ESTOQUE_PRODUTOS.ES43, ESTOQUE_PRODUTOS.ES44, ESTOQUE_PRODUTOS.ES45,        
ESTOQUE_PRODUTOS.ES46, ESTOQUE_PRODUTOS.ES47, ESTOQUE_PRODUTOS.ES48
FROM ESTOQUE_PRODUTOS
WHERE ESTOQUE_PRODUTOS.FILIAL = 'DR VAREJO'


exec sp_executesql N'
/* CVISUALMENU._3WZ10C2D3.TEXTITEM.CLICK CursorAdapter: cur_v_estoque_prod_sai_00_produtos(Alias: v_estoque_prod_sai_00_produtos)  */
SELECT ESTOQUE_PROD1_SAI.FILIAL,         ESTOQUE_PROD1_SAI.ROMANEIO_PRODUTO,         ESTOQUE_PROD1_SAI.PRODUTO,         
PRODUTOS.DESC_PRODUTO,         PRODUTOS.UNIDADE,         PRODUTOS.GRADE,         ESTOQUE_PROD1_SAI.COR_PRODUTO,         
PRODUTO_CORES.DESC_COR_PRODUTO,         ESTOQUE_PROD1_SAI.QTDE,         ESTOQUE_PROD1_SAI.SA_1,         
ESTOQUE_PROD1_SAI.SA_2,         ESTOQUE_PROD1_SAI.SA_3,         ESTOQUE_PROD1_SAI.SA_4,         
ESTOQUE_PROD1_SAI.SA_5,         ESTOQUE_PROD1_SAI.SA_6,         ESTOQUE_PROD1_SAI.SA_7,         
ESTOQUE_PROD1_SAI.SA_8,         ESTOQUE_PROD1_SAI.SA_9,         ESTOQUE_PROD1_SAI.SA_10,         
ESTOQUE_PROD1_SAI.SA_11,         ESTOQUE_PROD1_SAI.SA_12,         ESTOQUE_PROD1_SAI.SA_13,         
ESTOQUE_PROD1_SAI.SA_14,         ESTOQUE_PROD1_SAI.SA_15,         ESTOQUE_PROD1_SAI.SA_16,         0 AS SA_17,         
0 AS SA_18,         0 AS SA_19,         0 AS SA_20,         0 AS SA_21,         0 AS SA_22,         0 AS SA_23,         
0 AS SA_24,         0 AS SA_25,         0 AS SA_26,         0 AS SA_27,         0 AS SA_28,         0 AS SA_29,         
0 AS SA_30,         0 AS SA_31,         0 AS SA_32,         0 AS SA_33,         0 AS SA_34,         0 AS SA_35,        
0 AS SA_36,         0 AS SA_37,         0 AS SA_38,         0 AS SA_39,         0 AS SA_40,         0 AS SA_41,         
0 AS SA_42,         0 AS SA_43,         0 AS SA_44,         0 AS SA_45,         0 AS SA_46,         0 AS SA_47,         
0 AS SA_48,         PRODUTOS.SORTIMENTO_COR,         ESTOQUE_PROD1_SAI.CUSTO1,         ESTOQUE_PROD1_SAI.CUSTO2,         
ESTOQUE_PROD1_SAI.CUSTO3,         ESTOQUE_PROD1_SAI.CUSTO4,         ESTOQUE_PROD1_SAI.VALOR,         
PRODUTOS.PONTEIRO_PRECO_TAM,         PRODUTOS.VARIA_PRECO_TAM,         ESTOQUE_PROD1_SAI.ID_MODIFICACAO,         
MODIFICACAO_FICHA_TECNICA.DESC_MODIFICACAO,         PRODUTOS.REFER_FABRICANTE  FROM ESTOQUE_PROD1_SAI  
INNER JOIN PRODUTOS ON ESTOQUE_PROD1_SAI.PRODUTO = PRODUTOS.PRODUTO  INNER JOIN PRODUTO_CORES 
ON ESTOQUE_PROD1_SAI.PRODUTO = PRODUTO_CORES.PRODUTO  AND ESTOQUE_PROD1_SAI.COR_PRODUTO = PRODUTO_CORES.COR_PRODUTO  
LEFT JOIN MODIFICACAO_FICHA_TECNICA ON ESTOQUE_PROD1_SAI.ID_MODIFICACAO = MODIFICACAO_FICHA_TECNICA.ID_MODIFICACAO  
WHERE 1=0 AND ESTOQUE_PROD1_SAI.ROMANEIO_PRODUTO = @P1    AND ESTOQUE_PROD1_SAI.FILIAL = @P2',N'@P1 varchar(1),@P2 varchar(1)','',''




SELECT ESTOQUE_PRODUTOS.FILIAL,'' as ROMANEIO_PRODUTO,ESTOQUE_PRODUTOS.PRODUTO,PRODUTOS.DESC_PRODUTO,         
PRODUTOS.UNIDADE,PRODUTOS.GRADE,ESTOQUE_PRODUTOS.COR_PRODUTO,PRODUTO_CORES.DESC_COR_PRODUTO,
ESTOQUE_PRODUTOS.ESTOQUE AS QTDE,ESTOQUE_PRODUTOS.ES1 AS SA_1,ESTOQUE_PRODUTOS.ES2 AS SA_2,         
ESTOQUE_PRODUTOS.ES3 AS SA_3,ESTOQUE_PRODUTOS.ES4 AS SA_4,ESTOQUE_PRODUTOS.ES5 AS SA_5,         
ESTOQUE_PRODUTOS.ES6 AS SA_6,ESTOQUE_PRODUTOS.ES7 AS SA_7,ESTOQUE_PRODUTOS.ES8 AS SA_8,         
ESTOQUE_PRODUTOS.ES9 AS SA_9,ESTOQUE_PRODUTOS.ES10 AS SA_10,ESTOQUE_PRODUTOS.ES11 AS SA_11,         
ESTOQUE_PRODUTOS.ES12 AS SA_12,ESTOQUE_PRODUTOS.ES13 AS SA_13,ESTOQUE_PRODUTOS.ES14 AS SA_14,         
ESTOQUE_PRODUTOS.ES15 AS SA_15,ESTOQUE_PRODUTOS.ES16 AS SA_16,0 AS SA_17,0 AS SA_18,0 AS SA_19,         
0 AS SA_20,0 AS SA_21,0 AS SA_22,0 AS SA_23,0 AS SA_24,0 AS SA_25,0 AS SA_26,0 AS SA_27,         
0 AS SA_28,0 AS SA_29,0 AS SA_30,0 AS SA_31,0 AS SA_32,0 AS SA_33,0 AS SA_34,0 AS SA_35,
0 AS SA_36,0 AS SA_37,0 AS SA_38,0 AS SA_39,0 AS SA_40,0 AS SA_41,0 AS SA_42,0 AS SA_43,         
0 AS SA_44,0 AS SA_45,0 AS SA_46,0 AS SA_47,0 AS SA_48,PRODUTOS.SORTIMENTO_COR,         
ESTOQUE_PRODUTOS.CUSTO_MEDIO1 AS CUSTO1,ESTOQUE_PRODUTOS.CUSTO_MEDIO2 AS CUSTO2,         
ESTOQUE_PRODUTOS.CUSTO_MEDIO3 AS CUSTO3,ESTOQUE_PRODUTOS.CUSTO_MEDIO4 AS CUSTO4,         
ESTOQUE_PRODUTOS.CUSTO_MEDIO4 AS VALOR,PRODUTOS.PONTEIRO_PRECO_TAM,PRODUTOS.VARIA_PRECO_TAM,         
'' AS ID_MODIFICACAO,'' AS DESC_MODIFICACAO,PRODUTOS.REFER_FABRICANTE  
FROM ESTOQUE_PRODUTOS  
INNER JOIN PRODUTOS ON ESTOQUE_PRODUTOS.PRODUTO = PRODUTOS.PRODUTO  
INNER JOIN PRODUTO_CORES ON ESTOQUE_PRODUTOS.PRODUTO = PRODUTO_CORES.PRODUTO  AND ESTOQUE_PRODUTOS.COR_PRODUTO = PRODUTO_CORES.COR_PRODUTO  
WHERE ESTOQUE_PRODUTOS.PRODUTO = '1233' AND ESTOQUE_PRODUTOS.COR_PRODUTO = 'AR0094' AND ESTOQUE_PRODUTOS.FILIAL = 'DR VAREJO'


FILIAL,ROMANEIO_PRODUTO,PRODUTO,DESC_PRODUTO,UNIDADE,GRADE,COR_PRODUTO,DESC_COR_PRODUTO,QTDE,SA_1,SA_2,SA_3,;
SA_4,SA_5,SA_6,SA_7,SA_8,SA_9,SA_10,SA_11,SA_12,SA_13,SA_14,SA_15,SA_16,SA_17,SA_18,SA_19,SA_20,SA_21,SA_22,;
SA_23,SA_24,SA_25,SA_26,SA_27,SA_28,SA_29,SA_30,SA_31,SA_32,SA_33,SA_34,SA_35,SA_36,SA_37,SA_38,SA_39,SA_40,;
SA_41,SA_42,SA_43,SA_44,SA_45,SA_46,SA_47,SA_48,SORTIMENTO_COR,CUSTO1,CUSTO2,CUSTO3,CUSTO4,VALOR,PONTEIRO_PRECO_TAM,;
VARIA_PRECO_TAM,ID_MODIFICACAO,DESC_MODIFICACAO,REFER_FABRICANTE



LX_CADE_COLUNA ID_MODIFICACAO


SELECT * FROM ESTOQUE_PRODUTOS
JOIN ESTOQUE_PROD1_SAI ON ESTOQUE_PROD1_SAI.FILIAL=ESTOQUE_PRODUTOS.FILIAL AND ESTOQUE_PROD1_SAI.PRODUTO=ESTOQUE_PRODUTOS.PRODUTO AND ESTOQUE_PROD1_SAI.COR_PRODUTO=ESTOQUE_PRODUTOS.COR_PRODUTO 
WHERE ESTOQUE_PRODUTOS.PRODUTO='1233' AND ESTOQUE_PRODUTOS.FILIAL='DR VAREJO'





exec sp_executesql N'
/* lx120027spk  CursorAdapter: cur_v_estoque_prod_sai_00_produtos(Alias: v_estoque_prod_sai_00_produtos)  */
SELECT ESTOQUE_PROD1_SAI.FILIAL,         ESTOQUE_PROD1_SAI.ROMANEIO_PRODUTO,         ESTOQUE_PROD1_SAI.PRODUTO,         
PRODUTOS.DESC_PRODUTO,         PRODUTOS.UNIDADE,         
PRODUTOS.GRADE,         ESTOQUE_PROD1_SAI.COR_PRODUTO,         PRODUTO_CORES.DESC_COR_PRODUTO,         
ESTOQUE_PROD1_SAI.QTDE,         ESTOQUE_PROD1_SAI.SA_1,         
ESTOQUE_PROD1_SAI.SA_2,         ESTOQUE_PROD1_SAI.SA_3,         ESTOQUE_PROD1_SAI.SA_4,         
ESTOQUE_PROD1_SAI.SA_5,         ESTOQUE_PROD1_SAI.SA_6,         ESTOQUE_PROD1_SAI.SA_7,         
ESTOQUE_PROD1_SAI.SA_8,         ESTOQUE_PROD1_SAI.SA_9,         ESTOQUE_PROD1_SAI.SA_10,         
ESTOQUE_PROD1_SAI.SA_11,         ESTOQUE_PROD1_SAI.SA_12,         ESTOQUE_PROD1_SAI.SA_13,         
ESTOQUE_PROD1_SAI.SA_14,         ESTOQUE_PROD1_SAI.SA_15,         ESTOQUE_PROD1_SAI.SA_16,         0 AS SA_17,         
0 AS SA_18,         0 AS SA_19,         0 AS SA_20,         0 AS SA_21,         0 AS SA_22,         0 AS SA_23,         
0 AS SA_24,         0 AS SA_25,         0 AS SA_26,         0 AS SA_27,         0 AS SA_28,         0 AS SA_29,         
0 AS SA_30,         0 AS SA_31,         0 AS SA_32,         0 AS SA_33,         0 AS SA_34,         0 AS SA_35,         
0 AS SA_36,         0 AS SA_37,         0 AS SA_38,         0 AS SA_39,         0 AS SA_40,         0 AS SA_41,         
0 AS SA_42,         0 AS SA_43,         0 AS SA_44,         0 AS SA_45,         0 AS SA_46,         0 AS SA_47,         
0 AS SA_48,         PRODUTOS.SORTIMENTO_COR,         ESTOQUE_PROD1_SAI.CUSTO1,         ESTOQUE_PROD1_SAI.CUSTO2,         
ESTOQUE_PROD1_SAI.CUSTO3,         ESTOQUE_PROD1_SAI.CUSTO4,         ESTOQUE_PROD1_SAI.VALOR,         
PRODUTOS.PONTEIRO_PRECO_TAM,         PRODUTOS.VARIA_PRECO_TAM,         ESTOQUE_PROD1_SAI.ID_MODIFICACAO,         
MODIFICACAO_FICHA_TECNICA.DESC_MODIFICACAO,         PRODUTOS.REFER_FABRICANTE  FROM ESTOQUE_PROD1_SAI  
INNER JOIN PRODUTOS ON ESTOQUE_PROD1_SAI.PRODUTO = PRODUTOS.PRODUTO  INNER JOIN PRODUTO_CORES 
ON ESTOQUE_PROD1_SAI.PRODUTO = PRODUTO_CORES.PRODUTO  AND ESTOQUE_PROD1_SAI.COR_PRODUTO = PRODUTO_CORES.COR_PRODUTO  
LEFT JOIN MODIFICACAO_FICHA_TECNICA ON ESTOQUE_PROD1_SAI.ID_MODIFICACAO = MODIFICACAO_FICHA_TECNICA.ID_MODIFICACAO  
WHERE ESTOQUE_PROD1_SAI.ROMANEIO_PRODUTO = @P1    AND ESTOQUE_PROD1_SAI.FILIAL = @P2',N'@P1 varchar(6),@P2 varchar(2)','019002','LD'