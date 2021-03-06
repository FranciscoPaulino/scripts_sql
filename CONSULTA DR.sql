SELECT C.EMISSAO,C.DATA_SAIDA,E.VENCIMENTO_REAL,F.DATA_PAGAMENTO,C.VALOR_TOTAL,C.NUMERO_CONHECIMENTO_RELACIONADO,
C.COMISSAO,C.COMISSAO_VALOR,C.COMISSAO_GERENTE,C.COMISSAO_VALOR_GERENTE,B.PRECO_UNITARIO,I.VALOR_TOTAL AS VALOR_FRETE,
A.ID_IMPOSTO,G.IMPOSTO,B.CODIGO_ITEM,B.REFERENCIA,B.REFERENCIA_ITEM,E.ID_PARCELA,D.FATURA
FROM FATURAMENTO_IMPOSTO A
JOIN FATURAMENTO_ITEM B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF AND B.ITEM_IMPRESSAO=A.ITEM_IMPRESSAO AND B.SUB_ITEM_TAMANHO=A.SUB_ITEM_TAMANHO
JOIN FATURAMENTO C ON C.NF_SAIDA=A.NF_SAIDA AND C.SERIE_NF=A.SERIE_NF 
JOIN CTB_A_RECEBER_FATURA D ON D.LANCAMENTO=C.CTB_LANCAMENTO AND D.ITEM=C.CTB_ITEM
JOIN CTB_A_RECEBER_PARCELA E ON E.LANCAMENTO=D.LANCAMENTO AND E.ITEM=D.ITEM
LEFT JOIN CTB_A_RECEBER_MOV F ON F.LANCAMENTO_MOV=E.LANCAMENTO AND F.ITEM_MOV=E.ITEM
JOIN CTB_LX_IMPOSTO_TIPO G ON G.ID_IMPOSTO=A.ID_IMPOSTO
LEFT JOIN ENTRADAS I ON I.NF_ENTRADA_CONHECIMENTO = C.NUMERO_CONHECIMENTO_RELACIONADO AND I.SERIE_NF_ENTRADA='1'
WHERE A.NF_SAIDA='023373' AND A.SERIE_NF='2'


exec sp_executesql N'
/* lx005109spk  CursorAdapter: CUR_V_ENTRADAS_00_CONHECIMENTOS_REL(Alias: v_entradas_00_conhecimentos_rel)  */
SELECT ''ENTRADA'' AS TIPO, NF_ENTRADA AS NOTA_FISCAL, SERIE_NF_ENTRADA AS SERIE, FILIAL, NOME_CLIFOR AS TERCEIRO, '' '' AS NF_ENTRADA, '' '' AS SERIE_NF_ENTRADA, '' '' AS NOME_CLIFOR 
FROM ENTRADAS 
WHERE NUMERO_CONHECIMENTO_RELACIONADO = @P1 
UNION ALL 
SELECT ''SAIDA'' AS TIPO, NF_SAIDA AS NOTA_FISCAL, SERIE_NF SERIE, FILIAL, NOME_CLIFOR AS TERCEIRO, '' '' AS NF_ENTRADA, '' '' AS SERIE_NF_ENTRADA, '' '' AS NOME_CLIFOR 
FROM FATURAMENTO 
WHERE NUMERO_CONHECIMENTO_RELACIONADO = @P2 ORDER BY 1, 2',N'@P1 varchar(6),@P2 varchar(6)','439944','439944'


