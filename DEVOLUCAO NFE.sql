SELECT B.RAZAO_SOCIAL,A.NF_SAIDA,A.SERIE_NF FROM FATURAMENTO A WITH (NOLOCK)
JOIN CADASTRO_CLI_FOR B WITH (NOLOCK) ON B.NOME_CLIFOR = A.NOME_CLIFOR
WHERE B.CGC_CPF = '79379491000183' AND NF_SAIDA='001188' AND SERIE_NF='1'
 







