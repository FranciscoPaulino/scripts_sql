select NOME_CLIFOR from CADASTRO_CLI_FOR
WHERE INDICA_CLIENTE=1 AND NOT EXISTS 
(
	SELECT CLIENTE_ATACADO FROM CLIENTES_ATACADO
)