SELECT GERENTE=RTRIM(B.GERENTE), 
       REPRESENTANTE=RTRIM(B.REPRESENTANTE),
       D.UF,
       CIDADE=RTRIM(D.CIDADE),
       D.RAZAO_SOCIAL,
       B.TIPO, 
       A.PRODUTO, 
       C.LINHA, 
       ANO=YEAR(B.EMISSAO),
       MONTH=MONTH(B.EMISSAO),
       case MONTH(B.EMISSAO) 
       when 1 then 'Jan' 
       when 2 then 'Fev' 
       when 3 then 'Mar'
       when 4 then 'Abr'
       when 5 then 'Mai'
       when 6 then 'Jun'
       when 7 then 'Jul'
       when 8 then 'Ago'
       when 9 then 'Set'
       when 10 then 'Out'
       when 11 then 'Nov'
       when 12 then 'Dez'        
       end as MES,
       QTDE=SUM(A.QTDE_ORIGINAL), 
       VALOR=SUM(A.VALOR_ORIGINAL)
FROM VENDAS_PRODUTO A, 
     VENDAS B, 
     PRODUTOS C, 
     CADASTRO_CLI_FOR D
WHERE A.PEDIDO = B.PEDIDO AND 
      C.PRODUTO = A.PRODUTO AND 
      B.CLIENTE_ATACADO = D.NOME_CLIFOR AND 
      ((B.TABELA_FILHA='VENDAS_PRODUTO') AND (B.EMISSAO>='20090101')) AND
      B.APROVACAO='A' AND A.PEDIDO NOT IN (SELECT DISTINCT A.PEDIDO FROM VENDAS_CANC_PROD A
JOIN VENDAS_CANCELAMENTO B ON B.NUM_CANCELAMENTO=A.NUM_CANCELAMENTO AND B.TIPO_CANCELAMENTO IN ('SOLICIT. REPRESENTANTE','SOLICIT.CLIENTE'))
GROUP BY B.GERENTE, 
         B.REPRESENTANTE,
         D.UF,
         D.CIDADE,
         D.RAZAO_SOCIAL, 
         B.TIPO, 
         A.PRODUTO, 
         C.LINHA, 
         YEAR(B.EMISSAO),
         MONTH(B.EMISSAO)
HAVING (B.GERENTE IN ('MARCUS ROBERTO','MARCUS CARIOCA'))