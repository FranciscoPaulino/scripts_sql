select CADASTRO_CLI_FOR.CADASTRAMENTO,NOME_CLIFOR,CLIENTES_ATACADO.CONCEITO from CLIENTES_ATACADO
join CADASTRO_CLI_FOR on CADASTRO_CLI_FOR.NOME_CLIFOR=CLIENTES_ATACADO.CLIENTE_ATACADO
where CONCEITO='cliente novo'
order by 1

update CLIENTES_ATACADO
set CONCEITO='BOM'
where CONCEITO='cliente novo'



---- CLIENTE NOVO
UPDATE CLIENTES_ATACADO
SET CONCEITO='CLIENTE NOVO'
FROM CLIENTES_ATACADO
JOIN CADASTRO_CLI_FOR on CADASTRO_CLI_FOR.NOME_CLIFOR=CLIENTES_ATACADO.CLIENTE_ATACADO
WHERE CLIENTES_ATACADO.CLIENTE_ATACADO IN (
SELECT CLIENTE_ATACADO FROM (
SELECT VENDAS.CLIENTE_ATACADO,QTDE=COUNT(PEDIDO) FROM VENDAS
JOIN CLIENTES_ATACADO ON CLIENTES_ATACADO.CLIENTE_ATACADO=VENDAS.CLIENTE_ATACADO
WHERE APROVACAO='A' AND CLIENTES_ATACADO.TIPO = 'VAREJO' 
AND VENDAS.TABELA_FILHA='VENDAS_PRODUTO' AND CLIENTES_ATACADO.CONCEITO='CLIENTE NOVO'
GROUP BY VENDAS.CLIENTE_ATACADO
HAVING COUNT(*) <= 3
) AS CLIENTES
)


--- MUDAN�A DE CONCEITO DO CLIENTE
UPDATE CLIENTES_ATACADO
SET CONCEITO='BOM'
FROM CLIENTES_ATACADO
JOIN CADASTRO_CLI_FOR on CADASTRO_CLI_FOR.NOME_CLIFOR=CLIENTES_ATACADO.CLIENTE_ATACADO
WHERE CLIENTES_ATACADO.CLIENTE_ATACADO IN (
SELECT CLIENTE_ATACADO FROM (
SELECT VENDAS.CLIENTE_ATACADO,QTDE=COUNT(PEDIDO) FROM VENDAS
JOIN CLIENTES_ATACADO ON CLIENTES_ATACADO.CLIENTE_ATACADO=VENDAS.CLIENTE_ATACADO
WHERE APROVACAO='A' AND CLIENTES_ATACADO.TIPO = 'VAREJO' 
AND VENDAS.TABELA_FILHA='VENDAS_PRODUTO' AND CLIENTES_ATACADO.CONCEITO='CLIENTE NOVO'
GROUP BY VENDAS.CLIENTE_ATACADO
HAVING COUNT(*) > 3
) AS CLIENTES
)
