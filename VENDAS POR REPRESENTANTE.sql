
SELECT DISTINCT F.GRUPO_PRODUTO,REPRESENTANTE=LTRIM(RTRIM(A.REPRESENTANTE)),B.RAZAO_SOCIAL,A.PEDIDO,QTDE_PECAS=A.TOT_QTDE_ORIGINAL,
A.EMISSAO,PERFAT=E.NUMERO_ENTREGA+'-'+CONVERT(CHAR(10),E.ENTREGA,103)+' a '+CONVERT(CHAR(10),E.LIMITE_ENTREGA,103),
VALOR=A.TOT_VALOR_ORIGINAL,DATA_FATURAMENTO=D.EMISSAO,QTDE_PECAS_FAT=D.QTDE_TOTAL,
SALDO=A.TOT_QTDE_ENTREGAR,F.LINHA 
FROM VENDAS A WITH (NOLOCK)
JOIN CADASTRO_CLI_FOR B WITH (NOLOCK) ON B.NOME_CLIFOR=A.CLIENTE_ATACADO
LEFT JOIN FATURAMENTO_PROD C WITH (NOLOCK) ON C.PEDIDO=A.PEDIDO
LEFT JOIN FATURAMENTO D WITH (NOLOCK) ON D.NF_SAIDA=C.NF_SAIDA AND D.SERIE_NF=C.SERIE_NF AND D.FILIAL=C.FILIAL 
JOIN VENDAS_PRODUTO E WITH (NOLOCK) ON E.PEDIDO=A.PEDIDO
JOIN PRODUTOS F WITH (NOLOCK) ON F.PRODUTO=E.PRODUTO
WHERE A.EMISSAO>='20140101' AND A.APROVACAO='A' AND A.TOT_QTDE_CANCELADA = 0 AND A.REPRESENTANTE NOT LIKE '%VENDA%'

