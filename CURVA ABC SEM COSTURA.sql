SELECT DISTINCT F.FILIAL,
F.NF_SAIDA,
F.SERIE_NF,
F.PRODUTO,
B.GRIFFE,
b.CARTELA,
B.GRUPO_PRODUTO,
B.SUBGRUPO_PRODUTO,
V.DATA_FATURAMENTO_RELATIVO AS AGENDA,
F.PEDIDO_CLIENTE,
CA.MATRIZ_CLIENTE,
F.NOME_CLIFOR,
F.COR_PRODUTO,
F.TIPO_FATURAMENTO,
MES_FATURAMENTO=DATENAME(M,D.EMISSAO),
EXP_01.PREV_EXP_01,
EXP_02.PREV_EXP_02,
EXP_03.PREV_EXP_03,
F.ITEM,
B.TIPO_PRODUTO,
D.EMISSAO,
EMBARQUE.PORTARIA_SAIDA,
EMBARQUE.HORA_SAIDA,
C.ORDEM AS ORDEM_TAMANHO,
C.GRADE,
C.TAMANHO,
	QTDE = CASE C.ORDEM
		WHEN 1 THEN F.F1		WHEN 2 THEN F.F2		WHEN 3 THEN F.F3		WHEN 4 THEN F.F4
		WHEN 5 THEN F.F5		WHEN 6 THEN F.F6		WHEN 7 THEN F.F7		WHEN 8 THEN F.F8
		WHEN 9 THEN F.F9		WHEN 10 THEN F.F10	WHEN 11 THEN F.F11	WHEN 12 THEN F.F12
		WHEN 13 THEN F.F13	WHEN 14 THEN F.F14	WHEN 15 THEN F.F15	WHEN 16 THEN F.F16
		WHEN 17 THEN F.F17	WHEN 18 THEN F.F18	WHEN 19 THEN F.F19	WHEN 20 THEN F.F20
		WHEN 21 THEN F.F21	WHEN 22 THEN F.F22	WHEN 23 THEN F.F23	WHEN 24 THEN F.F24
		WHEN 25 THEN F.F25	WHEN 26 THEN F.F26	WHEN 27 THEN F.F27	WHEN 28 THEN F.F28
		WHEN 29 THEN F.F29	WHEN 30 THEN F.F30	WHEN 31 THEN F.F31	WHEN 32 THEN F.F32
		WHEN 33 THEN F.F33	WHEN 34 THEN F.F34	WHEN 35 THEN F.F35	WHEN 36 THEN F.F36
		WHEN 37 THEN F.F37	WHEN 38 THEN F.F38	WHEN 39 THEN F.F39	WHEN 40 THEN F.F40
		WHEN 41 THEN F.F41	WHEN 42 THEN F.F42	WHEN 43 THEN F.F43	WHEN 44 THEN F.F44
		WHEN 45 THEN F.F45	WHEN 46 THEN F.F46	WHEN 47 THEN F.F47	WHEN 48 THEN F.F48  ELSE 0 END,
	F.PEDIDO_COR,F.CAIXA,F.PEDIDO,F.ENTREGA,F.DESCONTO_ITEM,F.PRECO,F.PACKS,F.ROMANEIO,F.CUSTO_NA_DATA,F.MOEDA,F.CAMBIO_NA_DATA
FROM W_FATURAMENTO_PROD_02 F WITH (NOLOCK)
	JOIN PRODUTOS B WITH (NOLOCK)ON B.PRODUTO=F.PRODUTO
	JOIN VENDAS V WITH (NOLOCK) ON V.PEDIDO=F.PEDIDO
	JOIN W_FATURAMENTO_06 D WITH (NOLOCK) ON D.NF_SAIDA=F.NF_SAIDA AND D.SERIE_NF=F.SERIE_NF AND D.FILIAL=F.FILIAL
	JOIN CLIENTES_ATACADO CA WITH (NOLOCK) ON CA.CLIENTE_ATACADO=F.NOME_CLIFOR
	JOIN W_PRODUTOS_TAMANHOS_VERTICAL C WITH (NOLOCK) ON C.GRADE=B.GRADE
	LEFT JOIN (
         SELECT NF_SAIDA, FILIAL, PROPRIEDADE, VALOR_PROPRIEDADE AS DATA_EMBARQUE,
         PORTARIA_SAIDA=SUBSTRING(RTRIM(VALOR_PROPRIEDADE),1,10), HORA_SAIDA=SUBSTRING(RTRIM(VALOR_PROPRIEDADE),11,50)
         FROM PROP_FATURAMENTO
         WHERE PROPRIEDADE='00238' AND VALOR_PROPRIEDADE<>'99/99/9999'
) AS EMBARQUE ON EMBARQUE.NF_SAIDA=F.NF_SAIDA AND EMBARQUE.FILIAL=F.FILIAL   
LEFT JOIN (
         SELECT PEDIDO, PROPRIEDADE, CONVERT (DATETIME, VALOR_PROPRIEDADE,103) AS PREV_EXP_01
         FROM PROP_VENDAS
         WHERE PROPRIEDADE='00249' AND VALOR_PROPRIEDADE<>'99/99/9999'
) AS EXP_01 ON EXP_01.PEDIDO=F.PEDIDO  
LEFT JOIN (
         SELECT PEDIDO, PROPRIEDADE, CONVERT (DATETIME, VALOR_PROPRIEDADE,103) AS PREV_EXP_02
         FROM PROP_VENDAS
         WHERE PROPRIEDADE='00270' AND VALOR_PROPRIEDADE<>'99/99/9999'
) AS EXP_02 ON EXP_02.PEDIDO=F.PEDIDO   
LEFT JOIN (
         SELECT PEDIDO, PROPRIEDADE, CONVERT (DATETIME, VALOR_PROPRIEDADE,103) AS PREV_EXP_03
         FROM PROP_VENDAS
         WHERE PROPRIEDADE='00272' AND VALOR_PROPRIEDADE<>'99/99/9999'
) AS EXP_03 ON EXP_03.PEDIDO=F.PEDIDO    

WHERE CASE C.ORDEM
		WHEN 1 THEN F.F1		WHEN 2 THEN F.F2		WHEN 3 THEN F.F3		WHEN 4 THEN F.F4
		WHEN 5 THEN F.F5		WHEN 6 THEN F.F6		WHEN 7 THEN F.F7		WHEN 8 THEN F.F8
		WHEN 9 THEN F.F9		WHEN 10 THEN F.F10	WHEN 11 THEN F.F11	WHEN 12 THEN F.F12
		WHEN 13 THEN F.F13	WHEN 14 THEN F.F14	WHEN 15 THEN F.F15	WHEN 16 THEN F.F16
		WHEN 17 THEN F.F17	WHEN 18 THEN F.F18	WHEN 19 THEN F.F19	WHEN 20 THEN F.F20
		WHEN 21 THEN F.F21	WHEN 22 THEN F.F22	WHEN 23 THEN F.F23	WHEN 24 THEN F.F24
		WHEN 25 THEN F.F25	WHEN 26 THEN F.F26	WHEN 27 THEN F.F27	WHEN 28 THEN F.F28
		WHEN 29 THEN F.F29	WHEN 30 THEN F.F30	WHEN 31 THEN F.F31	WHEN 32 THEN F.F32
		WHEN 33 THEN F.F33	WHEN 34 THEN F.F34	WHEN 35 THEN F.F35	WHEN 36 THEN F.F36
		WHEN 37 THEN F.F37	WHEN 38 THEN F.F38	WHEN 39 THEN F.F39	WHEN 40 THEN F.F40
		WHEN 41 THEN F.F41	WHEN 42 THEN F.F42	WHEN 43 THEN F.F43	WHEN 44 THEN F.F44
		WHEN 45 THEN F.F45	WHEN 46 THEN F.F46	WHEN 47 THEN F.F47	WHEN 48 THEN F.F48  ELSE 0 END <> 0 AND 
		F.TIPO_OPERACAO='V' AND D.EMISSAO >='20160301' AND D.EMISSAO <= '20170301' and (b.COD_PRODUTO_SEGMENTO=5 OR B.COD_PRODUTO_SOLUCAO=300)

