CREATE VIEW W_FATURAMENTO_HISTORICO_VAREJO AS 

SELECT B.CGC_CPF,B.RAZAO_SOCIAL, C.REPRESENTANTE,A.GERENTE,A.NF_SAIDA,A.SERIE_NF,B.BANCO,B.CC_AGENCIA,B.CC_CONTA 
FROM FATURAMENTO A WITH (NOLOCK) 
JOIN CADASTRO_CLI_FOR B WITH (NOLOCK) ON B.NOME_CLIFOR = A.NOME_CLIFOR 
JOIN CLIENTE_REPRE C WITH (NOLOCK) ON C.CLIENTE_ATACADO=A.NOME_CLIFOR 
JOIN NATUREZAS_SAIDAS D WITH (NOLOCK) ON D.NATUREZA_SAIDA=A.NATUREZA_SAIDA
WHERE A.FILIAL='DR VAREJO' AND D.TIPO_OPERACAO='V' AND DATEDIFF(DAY, A.EMISSAO, GETDATE()) <= 365 AND A.TABELA_FILHA='FATURAMENTO_PROD' 

UNION ALL

SELECT B.CGC_CPF,B.RAZAO_SOCIAL, C.REPRESENTANTE,A.GERENTE,A.NF_SAIDA,A.SERIE_NF,B.BANCO,B.CC_AGENCIA,B.CC_CONTA 
FROM LDR.DRVAREJO.DBO.FATURAMENTO A WITH (NOLOCK) 
JOIN LDR.DRVAREJO.DBO.CADASTRO_CLI_FOR B WITH (NOLOCK) ON B.NOME_CLIFOR = A.NOME_CLIFOR 
JOIN LDR.DRVAREJO.DBO.CLIENTE_REPRE C WITH (NOLOCK) ON C.CLIENTE_ATACADO=A.NOME_CLIFOR 
JOIN LDR.DRVAREJO.DBO.NATUREZAS_SAIDAS D WITH (NOLOCK) ON D.NATUREZA_SAIDA=A.NATUREZA_SAIDA
WHERE A.FILIAL='DR VAREJO' AND D.TIPO_OPERACAO='V' AND DATEDIFF(DAY, A.EMISSAO, GETDATE()) <= 365 AND A.TABELA_FILHA='FATURAMENTO_PROD' 