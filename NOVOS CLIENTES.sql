SELECT A.CADASTRAMENTO,A.RAZAO_SOCIAL,B.TIPO,B.CONCEITO,B.REGIAO,C.REPRESENTANTE,D.GERENTE FROM CADASTRO_CLI_FOR A
JOIN CLIENTES_ATACADO B ON B.COD_CLIENTE=A.CLIFOR
JOIN CLIENTE_REPRE C ON C.CLIENTE_ATACADO=B.CLIENTE_ATACADO
JOIN REPRESENTANTES D ON D.REPRESENTANTE=C.REPRESENTANTE
WHERE C.REPRESENTANTE_PRINCIPAL=1 AND A.CADASTRAMENTO >= '20141001' AND A.CADASTRAMENTO <='20141031'