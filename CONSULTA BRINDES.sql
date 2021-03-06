SELECT DATA_EM_ABERTO=DBO.Titulo_em_atraso(CADASTRO_CLI_FOR.CLIFOR),VENDAS.PEDIDO, VENDAS.COLECAO, VENDAS.CODIGO_TAB_PRECO, 
VENDAS.CONDICAO_PGTO, VENDAS.CLIENTE_ATACADO, VENDAS.REPRESENTANTE, 
VENDAS.GERENTE, VENDAS.EMISSAO, VENDAS.TOT_VALOR_ORIGINAL, VENDAS.TOT_VALOR_ENTREGUE, 
VENDAS.TOT_VALOR_CANCELADO, VENDAS.TOT_VALOR_DEVOLVIDO, VENDAS.TOT_VALOR_ENTREGAR, 
VENDAS.DESCONTO, VENDAS.PRIORIDADE, VENDAS.STATUS, VENDAS.APROVACAO, VENDAS.APROVADO_POR, 
VENDAS.PORC_DESCONTO, VENDAS.PORC_DESCONTO_BRUTO, VENDAS.PORC_DESCONTO_DIGITADO, 
VENDAS.DESCONTO_COND_PGTO, VENDAS.TIPO, VENDAS_PRODUTO.PEDIDO, VENDAS_PRODUTO.ENTREGA, 
VENDAS_PRODUTO.LIMITE_ENTREGA, VENDAS_PRODUTO.QTDE_ORIGINAL, VENDAS_PRODUTO.QTDE_EMBALADA, 
QTDE_A_RESERVAR=ISNULL(ROMANEIOS_RESERVAS.QTDE_R,0), 
VENDAS_PRODUTO.QTDE_ENTREGAR, VENDAS_PRODUTO.QTDE_ENTREGUE, VENDAS_PRODUTO.QTDE_DEVOLVIDA, 
VENDAS_PRODUTO.QTDE_CANCELADA, COLECOES.COLECAO, COLECOES.DESC_COLECAO, COND_ATAC_PGTOS.CONDICAO_PGTO, 
COND_ATAC_PGTOS.DESC_COND_PGTO, VENDAS_PRODUTO.PRODUTO,
QTDE_PRODUTO_FALTA=DBO.QTDE_FALTA_PRODUTO(VENDAS.PEDIDO)
FROM VENDAS_PRODUTO VENDAS_PRODUTO
JOIN VENDAS VENDAS ON VENDAS.PEDIDO = VENDAS_PRODUTO.PEDIDO
JOIN COLECOES COLECOES ON COLECOES.COLECAO = VENDAS.COLECAO
JOIN COND_ATAC_PGTOS COND_ATAC_PGTOS ON COND_ATAC_PGTOS.CONDICAO_PGTO = VENDAS.CONDICAO_PGTO
LEFT JOIN ROMANEIOS_RESERVAS ROMANEIOS_RESERVAS ON ROMANEIOS_RESERVAS.PEDIDO = VENDAS_PRODUTO.PEDIDO AND ROMANEIOS_RESERVAS.PRODUTO = VENDAS_PRODUTO.PRODUTO AND ROMANEIOS_RESERVAS.COR_PRODUTO = VENDAS_PRODUTO.COR_PRODUTO
JOIN CADASTRO_CLI_FOR ON CADASTRO_CLI_FOR.NOME_CLIFOR = VENDAS.CLIENTE_ATACADO
JOIN CLIENTES_ATACADO ON CLIENTES_ATACADO.CLIENTE_ATACADO = CADASTRO_CLI_FOR.NOME_CLIFOR
WHERE ((VENDAS.EMISSAO>={ts '2013-01-01 00:00:00'}) AND (VENDAS.TOT_VALOR_ENTREGAR>0) AND (VENDAS_PRODUTO.ENTREGA>={ts '2013-01-01 00:00:00'})) and (CLIENTES_ATACADO.TIPO LIKE 'BALC%')