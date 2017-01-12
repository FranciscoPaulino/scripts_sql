SELECT TOP 100 RAZAO_SOCIAL,ANO,QTDE_REF=COUNT(PRODUTO),QTDE_PCS=SUM(QTDE),VALOR=SUM(VALOR) FROM (

SELECT D.RAZAO_SOCIAL,
       A.PRODUTO, 
       ANO=YEAR(B.EMISSAO), 
       QTDE=SUM(A.QTDE_ORIGINAL), 
       VALOR=SUM(A.VALOR_ORIGINAL)
FROM VENDAS_PRODUTO A with (nolock), 
     VENDAS B with (nolock), 
     PRODUTOS C with (nolock), 
     CADASTRO_CLI_FOR D with (nolock)
WHERE A.PEDIDO = B.PEDIDO AND 
      C.PRODUTO = A.PRODUTO AND 
      B.CLIENTE_ATACADO = D.NOME_CLIFOR AND 
      ((B.TABELA_FILHA='VENDAS_PRODUTO') AND (B.EMISSAO>='20140101')) AND
      B.APROVACAO='A' AND B.CLIENTE_ATACADO NOT LIKE '%HAVAN%' AND C.GRUPO_PRODUTO<>'MERCHANDISING' --AND D.RAZAO_SOCIAL='PINTOS LTDA'
GROUP BY D.RAZAO_SOCIAL, 
         A.PRODUTO, 
         YEAR(B.EMISSAO)
) FINAL
GROUP BY RAZAO_SOCIAL,ANO
ORDER BY SUM(QTDE) DESC


SP_HELP VENDAS