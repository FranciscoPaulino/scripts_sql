--- com parametros de filtros
SELECT ROMANEIOS_RESERVAS.PRODUTO, ROMANEIOS_RESERVAS.COR_PRODUTO, ROMANEIOS_RESERVAS.COR_PEDIDO, ROMANEIOS_RESERVAS.ENTREGA, ROMANEIOS_RESERVAS.PEDIDO, ROMANEIOS_RESERVAS.FILIAL, ROMANEIOS_RESERVAS.ROMANEIO, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, 
R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31, R32, R33, R34, R35, R36, R37, R38, R39, R40, R41, R42, R43, R44, R45, R46, R47, R48, QTDE_R, VENDAS_PRODUTO.VE1, VENDAS_PRODUTO.VE2, VENDAS_PRODUTO.VE3, VENDAS_PRODUTO.VE4, 
VENDAS_PRODUTO.VE5, VENDAS_PRODUTO.VE6, VENDAS_PRODUTO.VE7, VENDAS_PRODUTO.VE8, VENDAS_PRODUTO.VE9, VENDAS_PRODUTO.VE10, VENDAS_PRODUTO.VE11, VENDAS_PRODUTO.VE12, VENDAS_PRODUTO.VE13, VENDAS_PRODUTO.VE14, VENDAS_PRODUTO.VE15, VENDAS_PRODUTO.VE16, VENDAS_PRODUTO.VE17, 
VENDAS_PRODUTO.VE18, VENDAS_PRODUTO.VE19, VENDAS_PRODUTO.VE20, VENDAS_PRODUTO.VE21, VENDAS_PRODUTO.VE22, VENDAS_PRODUTO.VE23, VENDAS_PRODUTO.VE24, VENDAS_PRODUTO.VE25, VENDAS_PRODUTO.VE26, VENDAS_PRODUTO.VE27, VENDAS_PRODUTO.VE28,VENDAS_PRODUTO.VE29, 
VENDAS_PRODUTO.VE30, VENDAS_PRODUTO.VE31, VENDAS_PRODUTO.VE32, VENDAS_PRODUTO.VE33, VENDAS_PRODUTO.VE34, VENDAS_PRODUTO.VE35, VENDAS_PRODUTO.VE36, VENDAS_PRODUTO.VE37, VENDAS_PRODUTO.VE38, VENDAS_PRODUTO.VE39, VENDAS_PRODUTO.VE40, VENDAS_PRODUTO.VE41, 
VENDAS_PRODUTO.VE42, VENDAS_PRODUTO.VE43, VENDAS_PRODUTO.VE44, VENDAS_PRODUTO.VE45, VENDAS_PRODUTO.VE46, VENDAS_PRODUTO.VE47, VENDAS_PRODUTO.VE48, VENDAS_PRODUTO.QTDE_ENTREGAR, ISNULL(W_VENDAS_PROD_EMBALADO.E1, 0) E1, ISNULL(W_VENDAS_PROD_EMBALADO.E2, 0) E2, 
ISNULL(W_VENDAS_PROD_EMBALADO.E3, 0) E3, ISNULL(W_VENDAS_PROD_EMBALADO.E4, 0) E4, ISNULL(W_VENDAS_PROD_EMBALADO.E5, 0) E5, ISNULL(W_VENDAS_PROD_EMBALADO.E6, 0) E6, ISNULL(W_VENDAS_PROD_EMBALADO.E7, 0) E7, ISNULL(W_VENDAS_PROD_EMBALADO.E8, 0) E8, 
ISNULL(W_VENDAS_PROD_EMBALADO.E9, 0) E9, ISNULL(W_VENDAS_PROD_EMBALADO.E10, 0) E10, ISNULL(W_VENDAS_PROD_EMBALADO.E11, 0) E11, ISNULL(W_VENDAS_PROD_EMBALADO.E12, 0) E12, ISNULL(W_VENDAS_PROD_EMBALADO.E13, 0) E13, ISNULL(W_VENDAS_PROD_EMBALADO.E14, 0) E14, ISNULL(W_VENDAS_PROD_EMBALADO.E15, 0) E15, ISNULL(W_VENDAS_PROD_EMBALADO.E16, 0) E16, ISNULL(W_VENDAS_PROD_EMBALADO.E17, 0) E17, ISNULL(W_VENDAS_PROD_EMBALADO.E18, 0) E18, ISNULL(W_VENDAS_PROD_EMBALADO.E19, 0) E19, ISNULL(W_VENDAS_PROD_EMBALADO.E20, 0) E20, ISNULL(W_VENDAS_PROD_EMBALADO.E21, 0) E21, ISNULL(W_VENDAS_PROD_EMBALADO.E22, 0) E22, ISNULL(W_VENDAS_PROD_EMBALADO.E23, 0) E23, ISNULL(W_VENDAS_PROD_EMBALADO.E24, 0) E24, ISNULL(W_VENDAS_PROD_EMBALADO.E25, 0) E25, ISNULL(W_VENDAS_PROD_EMBALADO.E26, 0) E26, ISNULL(W_VENDAS_PROD_EMBALADO.E27, 0) E27, ISNULL(W_VENDAS_PROD_EMBALADO.E28, 0) E28, ISNULL(W_VENDAS_PROD_EMBALADO.E29, 0) E29, ISNULL(W_VENDAS_PROD_EMBALADO.E30, 0) E30, ISNULL(W_VENDAS_PROD_EMBALADO.E31, 0) E31, ISNULL(W_VENDAS_PROD_EMBALADO.E32, 0) E32, ISNULL(W_VENDAS_PROD_EMBALADO.E33, 0) E33, ISNULL(W_VENDAS_PROD_EMBALADO.E34, 0) E34, ISNULL(W_VENDAS_PROD_EMBALADO.E35, 0) E35, ISNULL(W_VENDAS_PROD_EMBALADO.E36, 0) E36, ISNULL(W_VENDAS_PROD_EMBALADO.E37, 0) E37, ISNULL(W_VENDAS_PROD_EMBALADO.E38, 0) E38, ISNULL(W_VENDAS_PROD_EMBALADO.E39, 0) E39, ISNULL(W_VENDAS_PROD_EMBALADO.E40, 0) E40, ISNULL(W_VENDAS_PROD_EMBALADO.E41, 0) E41, ISNULL(W_VENDAS_PROD_EMBALADO.E42, 0) E42, ISNULL(W_VENDAS_PROD_EMBALADO.E43, 0) E43, ISNULL(W_VENDAS_PROD_EMBALADO.E44, 0) E44, ISNULL(W_VENDAS_PROD_EMBALADO.E45, 0) E45, ISNULL(W_VENDAS_PROD_EMBALADO.E46, 0) E46, ISNULL(W_VENDAS_PROD_EMBALADO.E47, 0) E47, ISNULL(W_VENDAS_PROD_EMBALADO.E48, 0) E48, ISNULL(W_VENDAS_PROD_EMBALADO.QTDE_EMBALADA, 0) QTDE_EMBALADA, ROMANEIOS_PRODUTO.ORDEM_PRODUCAO, VENDAS.CLIENTE_ATACADO, VENDAS.NOME_CLIFOR_ENTREGA, PRODUTOS.DESC_PRODUTO, PRODUTOS.PERIODO_PCP, PRODUTOS.TABELA_OPERACOES, PRODUTOS.FATOR_OPERACOES, PRODUTOS.CLASSIF_FISCAL, PRODUTOS.TIPO_PRODUTO, PRODUTOS.TABELA_MEDIDAS, PRODUTOS.GRUPO_PRODUTO, PRODUTOS.SUBGRUPO_PRODUTO, PRODUTOS.COLECAO, PRODUTOS.GRADE, PRODUTOS.LINHA, PRODUTOS.GRIFFE, PRODUTOS.CARTELA, PRODUTOS.UNIDADE, PRODUTOS.PESO, PRODUTOS.REVENDA, PRODUTOS.REFER_FABRICANTE, PRODUTOS.MODELAGEM, PRODUTOS.SORTIMENTO_COR, PRODUTOS.SORTIMENTO_TAMANHO, 
PRODUTOS.VARIA_PRECO_COR, PRODUTOS.VARIA_PRECO_TAM, PRODUTOS.PONTEIRO_PRECO_TAM, PRODUTOS.ESTILISTA, PRODUTOS.MODELISTA, PRODUTOS.MODELO, PRODUTO_CORES.DESC_COR_PRODUTO, CLIENTES_ATACADO.REGIAO, CLIENTES_ATACADO.PONTUALIDADE, CLIENTES_ATACADO.CONCEITO, 
CLIENTES_ATACADO.TIPO, CLIENTES_ATACADO.TIPO_BLOQUEIO, CLIENTES_ATACADO.CLIFOR, CLIENTES_ATACADO.LIMITE_CREDITO, CLIENTES_ATACADO.BLOQUEIO_EXPEDICAO, CLIENTES_ATACADO.BLOQUEIO_PEDIDOS, CLIENTES_ATACADO.BLOQUEIO_FATURAMENTO, CADASTRO_CLI_FOR.CGC_CPF, 
CADASTRO_CLI_FOR.RAZAO_SOCIAL, CADASTRO_CLI_FOR.RG_IE, CADASTRO_CLI_FOR.CEP, CADASTRO_CLI_FOR.ENDERECO, CADASTRO_CLI_FOR.BAIRRO, CADASTRO_CLI_FOR.CIDADE, CADASTRO_CLI_FOR.UF, CADASTRO_CLI_FOR.TELEFONE1, CADASTRO_CLI_FOR.PAIS, CADASTRO_CLI_FOR.DDI, 
CADASTRO_CLI_FOR.TELEFONE2, CADASTRO_CLI_FOR.FAX, CADASTRO_CLI_FOR.DDD1, CADASTRO_CLI_FOR.RAMAL1, CADASTRO_CLI_FOR.RAMAL2, CADASTRO_CLI_FOR.DDD2, CADASTRO_CLI_FOR.COBRANCA_ENDERECO, CADASTRO_CLI_FOR.COBRANCA_CIDADE, CADASTRO_CLI_FOR.COBRANCA_BAIRRO, 
CADASTRO_CLI_FOR.DDDFAX, CADASTRO_CLI_FOR.COBRANCA_UF, CADASTRO_CLI_FOR.COBRANCA_CEP, CADASTRO_CLI_FOR.COBRANCA_TELEFONE, CADASTRO_CLI_FOR.ENTREGA_ENDERECO, CADASTRO_CLI_FOR.ENTREGA_CIDADE, CADASTRO_CLI_FOR.ENTREGA_UF, CADASTRO_CLI_FOR.ENTREGA_BAIRRO, 
CADASTRO_CLI_FOR.ENTREGA_CEP, CADASTRO_CLI_FOR.ENTREGA_TELEFONE, CADASTRO_CLI_FOR.COBRANCA_DDD, CADASTRO_CLI_FOR.CONTATO, CADASTRO_CLI_FOR.COBRANCA_CGC, CADASTRO_CLI_FOR.COBRANCA_IE, CADASTRO_CLI_FOR.ENTREGA_DDD, CADASTRO_CLI_FOR.ENTREGA_CGC, 
CADASTRO_CLI_FOR.ENTREGA_IE, CADASTRO_CLI_FOR.REF_ANTERIOR, CADASTRO_CLI_FOR.EMAIL, CADASTRO_CLI_FOR.INATIVO, CADASTRO_CLI_FOR.ENTREGA_PAIS, COBRANCA_PAIS, VENDAS.PEDIDO_CLIENTE, VENDAS.OBS AS OBSERVACAO_PEDIDO, PRECO1, PRECO2, PRECO3, PRECO4, VENDAS_PRODUTO.PACKS, 
CONVERT(NUMERIC(14, 2), 0) VALOR_R, DESCONTO_ITEM, VENDAS_PRODUTO.IPI, FILIAIS.EMPRESA ,LIBERADO_EXPEDICAO   FROM ROMANEIOS_RESERVAS   LEFT JOIN W_VENDAS_PROD_EMBALADO ON ROMANEIOS_RESERVAS.PEDIDO = W_VENDAS_PROD_EMBALADO.PEDIDO   AND ROMANEIOS_RESERVAS.PRODUTO = W_VENDAS_PROD_EMBALADO.PEDIDO_PRODUTO   AND ROMANEIOS_RESERVAS.COR_PRODUTO = W_VENDAS_PROD_EMBALADO.PEDIDO_COR_PRODUTO   AND ROMANEIOS_RESERVAS.ENTREGA = W_VENDAS_PROD_EMBALADO.ENTREGA   AND ROMANEIOS_RESERVAS.ITEM_PEDIDO = W_VENDAS_PROD_EMBALADO.ITEM_PEDIDO    JOIN ROMANEIOS_PRODUTO ON ROMANEIOS_RESERVAS.PRODUTO = ROMANEIOS_PRODUTO.PRODUTO   AND ROMANEIOS_RESERVAS.COR_PRODUTO = ROMANEIOS_PRODUTO.COR_PRODUTO   AND ROMANEIOS_RESERVAS.ROMANEIO = ROMANEIOS_PRODUTO.ROMANEIO   AND ROMANEIOS_RESERVAS.FILIAL = ROMANEIOS_PRODUTO.FILIAL     JOIN PRODUTOS ON ROMANEIOS_RESERVAS.PRODUTO = PRODUTOS.PRODUTO   JOIN PRODUTO_CORES ON ROMANEIOS_RESERVAS.PRODUTO = PRODUTO_CORES.PRODUTO   AND ROMANEIOS_RESERVAS.COR_PRODUTO = PRODUTO_CORES.COR_PRODUTO   JOIN VENDAS ON ROMANEIOS_RESERVAS.PEDIDO = VENDAS.PEDIDO   JOIN VENDAS_PRODUTO ON ROMANEIOS_RESERVAS.PEDIDO = VENDAS_PRODUTO.PEDIDO   AND ROMANEIOS_RESERVAS.PRODUTO = VENDAS_PRODUTO.PRODUTO   AND ROMANEIOS_RESERVAS.COR_PEDIDO = VENDAS_PRODUTO.COR_PRODUTO   AND ROMANEIOS_RESERVAS.ENTREGA = VENDAS_PRODUTO.ENTREGA   AND ROMANEIOS_RESERVAS.ITEM_PEDIDO = VENDAS_PRODUTO.ITEM_PEDIDO   JOIN CLIENTES_ATACADO ON VENDAS.CLIENTE_ATACADO = CLIENTES_ATACADO.CLIENTE_ATACADO   JOIN CADASTRO_CLI_FOR ON VENDAS.CLIENTE_ATACADO = CADASTRO_CLI_FOR.NOME_CLIFOR   JOIN FILIAIS ON ROMANEIOS_RESERVAS.FILIAL = FILIAIS.FILIAL   JOIN ROMANEIOS ON ROMANEIOS_RESERVAS.ROMANEIO = ROMANEIOS.ROMANEIO WHERE (( ( ( PRODUTOS.PRODUTO IN (''4250'') and  produtos.INATIVO = CAST(0 AS BIT) ) ))) AND ROMANEIOS_RESERVAS.PRODUTO = '4250' AND ROMANEIOS_RESERVAS.PEDIDO = '100574' AND ROMANEIOS_RESERVAS.ROMANEIO = '08734'



--- sem filtro
SELECT PEDIDOS_A_RESERVAR.ROMANEIO,PEDIDOS_A_RESERVAR.PEDIDO,PEDIDOS_A_RESERVAR.PRODUTO,PEDIDOS_A_RESERVAR.COR_PRODUTO,PEDIDOS_A_RESERVAR.DESC_COR_PRODUTO,PRODUCAO_TAREFAS_SALDO.QTDE_S,
PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO,PRODUCAO_TAREFAS_SALDO.RECURSO_PRODUTIVO,PRODUCAO_TAREFAS_SALDO.DESC_RECURSO,PRODUCAO_TAREFAS_SALDO.SETOR_PRODUCAO, 
PRODUCAO_TAREFAS_SALDO.DESC_SETOR_PRODUCAO,PRODUCAO_TAREFAS_SALDO.FASE_PRODUCAO,convert(char(10),PRODUCAO_TAREFAS_SALDO.INICIO_REAL,103) as inicio_real,convert(char(10),PRODUCAO_TAREFAS_SALDO.FIM_ATUALIZADO,103) as fim_atualizado, 
PEDIDOS_A_RESERVAR.QTDE_R, S1=ISNULL(PRODUCAO_TAREFAS_SALDO.S1,0),S2=ISNULL(PRODUCAO_TAREFAS_SALDO.S2,0),S3=ISNULL(PRODUCAO_TAREFAS_SALDO.S3,0),S4=ISNULL(PRODUCAO_TAREFAS_SALDO.S4,0),S5=ISNULL(PRODUCAO_TAREFAS_SALDO.S5,0), 
S6=ISNULL(PRODUCAO_TAREFAS_SALDO.S6,0),S7=ISNULL(PRODUCAO_TAREFAS_SALDO.S7,0),S8=ISNULL(PRODUCAO_TAREFAS_SALDO.S8,0),S9=ISNULL(PRODUCAO_TAREFAS_SALDO.S9,0),S10=ISNULL(PRODUCAO_TAREFAS_SALDO.S10,0), 
S11=ISNULL(PRODUCAO_TAREFAS_SALDO.S11,0),S12=ISNULL(PRODUCAO_TAREFAS_SALDO.S12,0),S13=ISNULL(PRODUCAO_TAREFAS_SALDO.S13,0),S14=ISNULL(PRODUCAO_TAREFAS_SALDO.S14,0),S15=ISNULL(PRODUCAO_TAREFAS_SALDO.S15,0), 
S16=ISNULL(PRODUCAO_TAREFAS_SALDO.S16,0)
FROM (
SELECT ROMANEIOS_RESERVAS.PRODUTO, ROMANEIOS_RESERVAS.COR_PRODUTO, ROMANEIOS_RESERVAS.COR_PEDIDO, ROMANEIOS_RESERVAS.ENTREGA, ROMANEIOS_RESERVAS.PEDIDO, ROMANEIOS_RESERVAS.FILIAL, ROMANEIOS_RESERVAS.ROMANEIO, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, 
R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31, R32, R33, R34, R35, R36, R37, R38, R39, R40, R41, R42, R43, R44, R45, R46, R47, R48, QTDE_R, VENDAS_PRODUTO.VE1, VENDAS_PRODUTO.VE2, VENDAS_PRODUTO.VE3, VENDAS_PRODUTO.VE4, 
VENDAS_PRODUTO.VE5, VENDAS_PRODUTO.VE6, VENDAS_PRODUTO.VE7, VENDAS_PRODUTO.VE8, VENDAS_PRODUTO.VE9, VENDAS_PRODUTO.VE10, VENDAS_PRODUTO.VE11, VENDAS_PRODUTO.VE12, VENDAS_PRODUTO.VE13, VENDAS_PRODUTO.VE14, VENDAS_PRODUTO.VE15, VENDAS_PRODUTO.VE16, VENDAS_PRODUTO.VE17, 
VENDAS_PRODUTO.VE18, VENDAS_PRODUTO.VE19, VENDAS_PRODUTO.VE20, VENDAS_PRODUTO.VE21, VENDAS_PRODUTO.VE22, VENDAS_PRODUTO.VE23, VENDAS_PRODUTO.VE24, VENDAS_PRODUTO.VE25, VENDAS_PRODUTO.VE26, VENDAS_PRODUTO.VE27, VENDAS_PRODUTO.VE28,VENDAS_PRODUTO.VE29, 
VENDAS_PRODUTO.VE30, VENDAS_PRODUTO.VE31, VENDAS_PRODUTO.VE32, VENDAS_PRODUTO.VE33, VENDAS_PRODUTO.VE34, VENDAS_PRODUTO.VE35, VENDAS_PRODUTO.VE36, VENDAS_PRODUTO.VE37, VENDAS_PRODUTO.VE38, VENDAS_PRODUTO.VE39, VENDAS_PRODUTO.VE40, VENDAS_PRODUTO.VE41, 
VENDAS_PRODUTO.VE42, VENDAS_PRODUTO.VE43, VENDAS_PRODUTO.VE44, VENDAS_PRODUTO.VE45, VENDAS_PRODUTO.VE46, VENDAS_PRODUTO.VE47, VENDAS_PRODUTO.VE48, VENDAS_PRODUTO.QTDE_ENTREGAR, ISNULL(W_VENDAS_PROD_EMBALADO.E1, 0) E1, ISNULL(W_VENDAS_PROD_EMBALADO.E2, 0) E2, 
ISNULL(W_VENDAS_PROD_EMBALADO.E3, 0) E3, ISNULL(W_VENDAS_PROD_EMBALADO.E4, 0) E4, ISNULL(W_VENDAS_PROD_EMBALADO.E5, 0) E5, ISNULL(W_VENDAS_PROD_EMBALADO.E6, 0) E6, ISNULL(W_VENDAS_PROD_EMBALADO.E7, 0) E7, ISNULL(W_VENDAS_PROD_EMBALADO.E8, 0) E8, ISNULL(W_VENDAS_PROD_EMBALADO.E9, 0) E9, ISNULL(W_VENDAS_PROD_EMBALADO.E10, 0) E10, ISNULL(W_VENDAS_PROD_EMBALADO.E11, 0) E11, ISNULL(W_VENDAS_PROD_EMBALADO.E12, 0) E12, ISNULL(W_VENDAS_PROD_EMBALADO.E13, 0) E13, ISNULL(W_VENDAS_PROD_EMBALADO.E14, 0) E14, ISNULL(W_VENDAS_PROD_EMBALADO.E15, 0) E15, ISNULL(W_VENDAS_PROD_EMBALADO.E16, 0) E16, ISNULL(W_VENDAS_PROD_EMBALADO.E17, 0) E17, ISNULL(W_VENDAS_PROD_EMBALADO.E18, 0) E18, ISNULL(W_VENDAS_PROD_EMBALADO.E19, 0) E19, ISNULL(W_VENDAS_PROD_EMBALADO.E20, 0) E20, ISNULL(W_VENDAS_PROD_EMBALADO.E21, 0) E21, ISNULL(W_VENDAS_PROD_EMBALADO.E22, 0) E22, ISNULL(W_VENDAS_PROD_EMBALADO.E23, 0) E23, ISNULL(W_VENDAS_PROD_EMBALADO.E24, 0) E24, ISNULL(W_VENDAS_PROD_EMBALADO.E25, 0) E25, ISNULL(W_VENDAS_PROD_EMBALADO.E26, 0) E26, ISNULL(W_VENDAS_PROD_EMBALADO.E27, 0) E27, ISNULL(W_VENDAS_PROD_EMBALADO.E28, 0) E28, ISNULL(W_VENDAS_PROD_EMBALADO.E29, 0) E29, ISNULL(W_VENDAS_PROD_EMBALADO.E30, 0) E30, ISNULL(W_VENDAS_PROD_EMBALADO.E31, 0) E31, ISNULL(W_VENDAS_PROD_EMBALADO.E32, 0) E32, ISNULL(W_VENDAS_PROD_EMBALADO.E33, 0) E33, ISNULL(W_VENDAS_PROD_EMBALADO.E34, 0) E34, ISNULL(W_VENDAS_PROD_EMBALADO.E35, 0) E35, ISNULL(W_VENDAS_PROD_EMBALADO.E36, 0) E36, ISNULL(W_VENDAS_PROD_EMBALADO.E37, 0) E37, ISNULL(W_VENDAS_PROD_EMBALADO.E38, 0) E38, ISNULL(W_VENDAS_PROD_EMBALADO.E39, 0) E39, ISNULL(W_VENDAS_PROD_EMBALADO.E40, 0) E40, ISNULL(W_VENDAS_PROD_EMBALADO.E41, 0) E41, ISNULL(W_VENDAS_PROD_EMBALADO.E42, 0) E42, ISNULL(W_VENDAS_PROD_EMBALADO.E43, 0) E43, ISNULL(W_VENDAS_PROD_EMBALADO.E44, 0) E44, ISNULL(W_VENDAS_PROD_EMBALADO.E45, 0) E45, ISNULL(W_VENDAS_PROD_EMBALADO.E46, 0) E46, ISNULL(W_VENDAS_PROD_EMBALADO.E47, 0) E47, ISNULL(W_VENDAS_PROD_EMBALADO.E48, 0) E48, ISNULL(W_VENDAS_PROD_EMBALADO.QTDE_EMBALADA, 0) QTDE_EMBALADA, ROMANEIOS_PRODUTO.ORDEM_PRODUCAO, VENDAS.CLIENTE_ATACADO, VENDAS.NOME_CLIFOR_ENTREGA, PRODUTOS.DESC_PRODUTO, PRODUTOS.PERIODO_PCP, PRODUTOS.TABELA_OPERACOES, PRODUTOS.FATOR_OPERACOES, PRODUTOS.CLASSIF_FISCAL, PRODUTOS.TIPO_PRODUTO, PRODUTOS.TABELA_MEDIDAS, PRODUTOS.GRUPO_PRODUTO, 
PRODUTOS.SUBGRUPO_PRODUTO, PRODUTOS.COLECAO, PRODUTOS.GRADE, PRODUTOS.LINHA, PRODUTOS.GRIFFE, PRODUTOS.CARTELA, PRODUTOS.UNIDADE, PRODUTOS.PESO, PRODUTOS.REVENDA, PRODUTOS.REFER_FABRICANTE, PRODUTOS.MODELAGEM, PRODUTOS.SORTIMENTO_COR, PRODUTOS.SORTIMENTO_TAMANHO, 
PRODUTOS.VARIA_PRECO_COR, PRODUTOS.VARIA_PRECO_TAM, PRODUTOS.PONTEIRO_PRECO_TAM, PRODUTOS.ESTILISTA, PRODUTOS.MODELISTA, PRODUTOS.MODELO, PRODUTO_CORES.DESC_COR_PRODUTO, CLIENTES_ATACADO.REGIAO, CLIENTES_ATACADO.PONTUALIDADE, CLIENTES_ATACADO.CONCEITO, 
CLIENTES_ATACADO.TIPO, CLIENTES_ATACADO.TIPO_BLOQUEIO, CLIENTES_ATACADO.CLIFOR, CLIENTES_ATACADO.LIMITE_CREDITO, CLIENTES_ATACADO.BLOQUEIO_EXPEDICAO, CLIENTES_ATACADO.BLOQUEIO_PEDIDOS, CLIENTES_ATACADO.BLOQUEIO_FATURAMENTO, CADASTRO_CLI_FOR.CGC_CPF, 
CADASTRO_CLI_FOR.RAZAO_SOCIAL, CADASTRO_CLI_FOR.RG_IE, CADASTRO_CLI_FOR.CEP, CADASTRO_CLI_FOR.ENDERECO, CADASTRO_CLI_FOR.BAIRRO, CADASTRO_CLI_FOR.CIDADE, CADASTRO_CLI_FOR.UF, CADASTRO_CLI_FOR.TELEFONE1, CADASTRO_CLI_FOR.PAIS, CADASTRO_CLI_FOR.DDI, 
CADASTRO_CLI_FOR.TELEFONE2, CADASTRO_CLI_FOR.FAX, CADASTRO_CLI_FOR.DDD1, CADASTRO_CLI_FOR.RAMAL1, CADASTRO_CLI_FOR.RAMAL2, CADASTRO_CLI_FOR.DDD2, CADASTRO_CLI_FOR.COBRANCA_ENDERECO, CADASTRO_CLI_FOR.COBRANCA_CIDADE, CADASTRO_CLI_FOR.COBRANCA_BAIRRO, 
CADASTRO_CLI_FOR.DDDFAX, CADASTRO_CLI_FOR.COBRANCA_UF, CADASTRO_CLI_FOR.COBRANCA_CEP, CADASTRO_CLI_FOR.COBRANCA_TELEFONE, CADASTRO_CLI_FOR.ENTREGA_ENDERECO, CADASTRO_CLI_FOR.ENTREGA_CIDADE, CADASTRO_CLI_FOR.ENTREGA_UF, CADASTRO_CLI_FOR.ENTREGA_BAIRRO, 
CADASTRO_CLI_FOR.ENTREGA_CEP, CADASTRO_CLI_FOR.ENTREGA_TELEFONE, CADASTRO_CLI_FOR.COBRANCA_DDD, CADASTRO_CLI_FOR.CONTATO, CADASTRO_CLI_FOR.COBRANCA_CGC, CADASTRO_CLI_FOR.COBRANCA_IE, CADASTRO_CLI_FOR.ENTREGA_DDD, CADASTRO_CLI_FOR.ENTREGA_CGC, 
CADASTRO_CLI_FOR.ENTREGA_IE, CADASTRO_CLI_FOR.REF_ANTERIOR, CADASTRO_CLI_FOR.EMAIL, CADASTRO_CLI_FOR.INATIVO, CADASTRO_CLI_FOR.ENTREGA_PAIS, COBRANCA_PAIS, VENDAS.PEDIDO_CLIENTE, VENDAS.OBS AS OBSERVACAO_PEDIDO, PRECO1, PRECO2, PRECO3, PRECO4, VENDAS_PRODUTO.PACKS, CONVERT(NUMERIC(14, 2), 0) VALOR_R, DESCONTO_ITEM, VENDAS_PRODUTO.IPI, FILIAIS.EMPRESA ,LIBERADO_EXPEDICAO   FROM ROMANEIOS_RESERVAS   LEFT JOIN W_VENDAS_PROD_EMBALADO ON ROMANEIOS_RESERVAS.PEDIDO = W_VENDAS_PROD_EMBALADO.PEDIDO   AND ROMANEIOS_RESERVAS.PRODUTO = W_VENDAS_PROD_EMBALADO.PEDIDO_PRODUTO   AND ROMANEIOS_RESERVAS.COR_PRODUTO = W_VENDAS_PROD_EMBALADO.PEDIDO_COR_PRODUTO   AND ROMANEIOS_RESERVAS.ENTREGA = W_VENDAS_PROD_EMBALADO.ENTREGA   AND ROMANEIOS_RESERVAS.ITEM_PEDIDO = W_VENDAS_PROD_EMBALADO.ITEM_PEDIDO    JOIN ROMANEIOS_PRODUTO ON ROMANEIOS_RESERVAS.PRODUTO = ROMANEIOS_PRODUTO.PRODUTO   AND ROMANEIOS_RESERVAS.COR_PRODUTO = ROMANEIOS_PRODUTO.COR_PRODUTO   AND ROMANEIOS_RESERVAS.ROMANEIO = ROMANEIOS_PRODUTO.ROMANEIO   AND ROMANEIOS_RESERVAS.FILIAL = ROMANEIOS_PRODUTO.FILIAL     JOIN PRODUTOS ON ROMANEIOS_RESERVAS.PRODUTO = PRODUTOS.PRODUTO   JOIN PRODUTO_CORES ON ROMANEIOS_RESERVAS.PRODUTO = PRODUTO_CORES.PRODUTO   AND ROMANEIOS_RESERVAS.COR_PRODUTO = PRODUTO_CORES.COR_PRODUTO   JOIN VENDAS ON ROMANEIOS_RESERVAS.PEDIDO = VENDAS.PEDIDO   JOIN VENDAS_PRODUTO ON ROMANEIOS_RESERVAS.PEDIDO = VENDAS_PRODUTO.PEDIDO   AND ROMANEIOS_RESERVAS.PRODUTO = VENDAS_PRODUTO.PRODUTO   AND ROMANEIOS_RESERVAS.COR_PEDIDO = VENDAS_PRODUTO.COR_PRODUTO   AND ROMANEIOS_RESERVAS.ENTREGA = VENDAS_PRODUTO.ENTREGA   AND ROMANEIOS_RESERVAS.ITEM_PEDIDO = VENDAS_PRODUTO.ITEM_PEDIDO   JOIN CLIENTES_ATACADO ON VENDAS.CLIENTE_ATACADO = CLIENTES_ATACADO.CLIENTE_ATACADO   JOIN CADASTRO_CLI_FOR ON VENDAS.CLIENTE_ATACADO = CADASTRO_CLI_FOR.NOME_CLIFOR   JOIN FILIAIS ON ROMANEIOS_RESERVAS.FILIAL = FILIAIS.FILIAL   JOIN ROMANEIOS ON ROMANEIOS_RESERVAS.ROMANEIO = ROMANEIOS.ROMANEIO
) AS PEDIDOS_A_RESERVAR
LEFT JOIN ( 
SELECT PRODUCAO_TAREFAS_SALDO.TAREFA, PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO, PRODUCAO_TAREFAS_SALDO.PRODUTO, 
PRODUCAO_TAREFAS_SALDO.COR_PRODUTO, PRODUCAO_TAREFAS_SALDO.QTDE_S, 
PRODUCAO_TAREFAS_SALDO.S1, PRODUCAO_TAREFAS_SALDO.S2, PRODUCAO_TAREFAS_SALDO.S3, PRODUCAO_TAREFAS_SALDO.S4, 
PRODUCAO_TAREFAS_SALDO.S5, PRODUCAO_TAREFAS_SALDO.S6, PRODUCAO_TAREFAS_SALDO.S7, 
PRODUCAO_TAREFAS_SALDO.S8, PRODUCAO_TAREFAS_SALDO.S9, PRODUCAO_TAREFAS_SALDO.S10, PRODUCAO_TAREFAS_SALDO.S11, 
PRODUCAO_TAREFAS_SALDO.S12, PRODUCAO_TAREFAS_SALDO.S13, 
PRODUCAO_TAREFAS_SALDO.S14, PRODUCAO_TAREFAS_SALDO.S15, PRODUCAO_TAREFAS_SALDO.S16, 
PRODUCAO_TAREFAS_SALDO.ULTIMO_CUSTO_PREVISTO, PRODUCAO_TAREFAS.INICIO_PREVISTO, 
PRODUCAO_TAREFAS.INICIO_REAL, PRODUCAO_TAREFAS.FIM_ATUALIZADO, PRODUCAO_RECURSOS.RECURSO_PRODUTIVO, 
PRODUCAO_RECURSOS.DESC_RECURSO, PRODUCAO_SETOR.SETOR_PRODUCAO, PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, 
PRODUCAO_ORDEM.PREVISAO_FIM, PRODUCAO_ORDEM.PROGRAMACAO, PRODUCAO_ORDEM.TIPO_ORDEM_PRODUCAO, PRODUTOS.GRADE, 
PRODUCAO_TAREFAS.FASE_PRODUCAO FROM  DBO.PRODUCAO_TAREFAS_SALDO PRODUCAO_TAREFAS_SALDO, DBO.PRODUTOS PRODUTOS, 
DBO.PRODUCAO_TAREFAS PRODUCAO_TAREFAS, DBO.PRODUCAO_ORDEM PRODUCAO_ORDEM, DBO.PRODUCAO_ORDEM_COR PRODUCAO_ORDEM_COR, 
DBO.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, DBO.PRODUCAO_SETOR PRODUCAO_SETOR 
WHERE ((((((((PRODUCAO_TAREFAS.TAREFA = PRODUCAO_TAREFAS_SALDO.TAREFA AND  
PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO = PRODUCAO_ORDEM.ORDEM_PRODUCAO ) AND  
PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO = PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO ) AND  
PRODUCAO_TAREFAS_SALDO.PRODUTO = PRODUCAO_ORDEM_COR.PRODUTO ) AND  
PRODUCAO_TAREFAS_SALDO.COR_PRODUTO = PRODUCAO_ORDEM_COR.COR_PRODUTO ) AND  
PRODUCAO_TAREFAS.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO ) AND  
PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO ) AND  
PRODUCAO_TAREFAS.SETOR_PRODUCAO = PRODUCAO_SETOR.SETOR_PRODUCAO ) AND  
PRODUCAO_TAREFAS_SALDO.PRODUTO = PRODUTOS.PRODUTO )  AND PRODUCAO_ORDEM.FILIAL='D.R. LINGERIE' AND PRODUCAO_TAREFAS_SALDO.QTDE_S >0 AND PRODUCAO_TAREFAS.QTDE_EM_PROCESSO > 0 )  AS PRODUCAO_TAREFAS_SALDO 
ON PRODUCAO_TAREFAS_SALDO.PRODUTO=PEDIDOS_A_RESERVAR.PRODUTO AND PRODUCAO_TAREFAS_SALDO.COR_PRODUTO=PEDIDOS_A_RESERVAR.COR_PRODUTO 
JOIN PRODUCAO_TAREFAS ON PRODUCAO_TAREFAS.FASE_PRODUCAO=PRODUCAO_TAREFAS_SALDO.FASE_PRODUCAO AND PRODUCAO_TAREFAS.ORDEM_PRODUCAO=PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO 
ORDER BY PEDIDOS_A_RESERVAR.PRODUTO,PEDIDOS_A_RESERVAR.COR_PRODUTO,PRODUCAO_TAREFAS.SEQUENCIA_PRODUTIVA desc,PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO