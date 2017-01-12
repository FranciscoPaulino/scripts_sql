--- DENI RICARDO
SELECT A.*,B.*,C.*,D.* FROM CADASTRO_CLI_FOR A with (nolock)
JOIN CLIENTES_ATACADO B with (nolock) ON B.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN CLIENTE_REPRE C with (nolock) ON C.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN REPRESENTANTES D with (nolock) ON D.REPRESENTANTE=C.REPRESENTANTE
WHERE YEAR(CADASTRAMENTO)=2014 AND PJ_PF='1' AND INDICA_CLIENTE='1' AND A.INATIVO='0' AND D.GERENTE LIKE 'DENI%'


--- MARCUS CARIOCA
SELECT A.*,B.*,C.*,D.* FROM CADASTRO_CLI_FOR A with (nolock)
JOIN CLIENTES_ATACADO B with (nolock) ON B.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN CLIENTE_REPRE C with (nolock) ON C.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN REPRESENTANTES D with (nolock) ON D.REPRESENTANTE=C.REPRESENTANTE
WHERE YEAR(CADASTRAMENTO)=2014 AND PJ_PF='1' AND INDICA_CLIENTE='1' AND A.INATIVO='0' AND D.GERENTE LIKE 'MARCUS%'


--- JOSE MARIO
SELECT A.*,B.*,C.*,D.* FROM CADASTRO_CLI_FOR A with (nolock)
JOIN CLIENTES_ATACADO B with (nolock) ON B.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN CLIENTE_REPRE C with (nolock) ON C.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN REPRESENTANTES D with (nolock) ON D.REPRESENTANTE=C.REPRESENTANTE
WHERE YEAR(CADASTRAMENTO)=2014 AND PJ_PF='1' AND INDICA_CLIENTE='1' AND A.INATIVO='0' AND D.GERENTE LIKE 'JOSE MARIO%'


--- sergio pires
SELECT A.*,B.*,C.*,D.* FROM CADASTRO_CLI_FOR A with (nolock)
JOIN CLIENTES_ATACADO B with (nolock) ON B.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN CLIENTE_REPRE C with (nolock) ON C.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN REPRESENTANTES D with (nolock) ON D.REPRESENTANTE=C.REPRESENTANTE
WHERE YEAR(CADASTRAMENTO)=2014 AND PJ_PF='1' AND INDICA_CLIENTE='1' AND A.INATIVO='0' AND D.GERENTE LIKE 'SERGIO PIRES%'


--- sarmento
SELECT A.*,B.*,C.*,D.* FROM CADASTRO_CLI_FOR A with (nolock)
JOIN CLIENTES_ATACADO B with (nolock) ON B.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN CLIENTE_REPRE C with (nolock) ON C.CLIENTE_ATACADO=A.NOME_CLIFOR
JOIN REPRESENTANTES D with (nolock) ON D.REPRESENTANTE=C.REPRESENTANTE
WHERE YEAR(CADASTRAMENTO)=2014 AND PJ_PF='1' AND INDICA_CLIENTE='1' AND A.INATIVO='0' AND D.GERENTE LIKE 'jose%sarmento%'



SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), representante=rtrim(w_prazo_medio.representante), w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, w_prazo_medio.porc_desconto, w_prazo_medio.pedido, w_prazo_medio.item_produto
FROM w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente In ('MARCUS ROBERTO','MARCUS CARIOCA'))
union all
SELECT w_prazo_medio.emissao, gerente=rtrim(w_prazo_medio.gerente), representante=rtrim(w_prazo_medio.representante), w_prazo_medio.condicao_pgto, w_prazo_medio.media_dias_parcela, w_prazo_medio.porc_desconto, w_prazo_medio.pedido, w_prazo_medio.item_produto
FROM ldr.drvarejo.dbo.w_prazo_medio w_prazo_medio
WHERE (w_prazo_medio.gerente In ('MARCUS ROBERTO','MARCUS CARIOCA'))
