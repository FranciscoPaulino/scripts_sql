select * from CADASTRO_CLI_FOR
WHERE NOME_CLIFOR not in (select CLIENTE_ATACADO FROM CLIENTES_ATACADO) 
AND NOME_CLIFOR NOT IN(SELECT FORNECEDOR FROM FORNECEDORES) 
AND NOME_CLIFOR NOT IN (SELECT FILIAL FROM FILIAIS)
AND NOME_CLIFOR NOT IN (SELECT REPRESENTANTE FROM REPRESENTANTES)
ORDER BY NOME_CLIFOR


DELETE from CADASTRO_CLI_FOR
WHERE NOME_CLIFOR not in (select CLIENTE_ATACADO FROM CLIENTES_ATACADO) 
AND NOME_CLIFOR NOT IN(SELECT FORNECEDOR FROM FORNECEDORES) 
AND NOME_CLIFOR NOT IN (SELECT FILIAL FROM FILIAIS)
AND NOME_CLIFOR NOT IN (SELECT REPRESENTANTE FROM REPRESENTANTES)
