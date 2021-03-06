SELECT PROGRAMACAO.PROGRAMACAO,PROGRAMACAO.GRADE,PROGRAMACAO.KIT_PRODUTO,PROGRAMACAO.KIT_COR_PRODUTO, PROGRAMACAO.PRODUTO, PROGRAMACAO.COR_PRODUTO, PRODUCAO_TAREFAS_SALDO.QTDE_S, 
PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO,PRODUCAO_TAREFAS_SALDO.RECURSO_PRODUTIVO,PRODUCAO_TAREFAS_SALDO.DESC_RECURSO,PRODUCAO_TAREFAS_SALDO.SETOR_PRODUCAO, 
PRODUCAO_TAREFAS_SALDO.DESC_SETOR_PRODUCAO,PRODUCAO_TAREFAS_SALDO.FASE_PRODUCAO,convert(char(10),PRODUCAO_TAREFAS_SALDO.INICIO_REAL,103) as inicio_real,convert(char(10),PRODUCAO_TAREFAS_SALDO.FIM_ATUALIZADO,103) as fim_atualizado, 
S1=ISNULL(PRODUCAO_TAREFAS_SALDO.S1,0),S2=ISNULL(PRODUCAO_TAREFAS_SALDO.S2,0),S3=ISNULL(PRODUCAO_TAREFAS_SALDO.S3,0),S4=ISNULL(PRODUCAO_TAREFAS_SALDO.S4,0),S5=ISNULL(PRODUCAO_TAREFAS_SALDO.S5,0), 
S6=ISNULL(PRODUCAO_TAREFAS_SALDO.S6,0),S7=ISNULL(PRODUCAO_TAREFAS_SALDO.S7,0),S8=ISNULL(PRODUCAO_TAREFAS_SALDO.S8,0),S9=ISNULL(PRODUCAO_TAREFAS_SALDO.S9,0),S10=ISNULL(PRODUCAO_TAREFAS_SALDO.S10,0), 
S11=ISNULL(PRODUCAO_TAREFAS_SALDO.S11,0),S12=ISNULL(PRODUCAO_TAREFAS_SALDO.S12,0),S13=ISNULL(PRODUCAO_TAREFAS_SALDO.S13,0),S14=ISNULL(PRODUCAO_TAREFAS_SALDO.S14,0),S15=ISNULL(PRODUCAO_TAREFAS_SALDO.S15,0), 
S16=ISNULL(PRODUCAO_TAREFAS_SALDO.S16,0) 
FROM 
( 
SELECT PRODUCAO_PROG_PROD.PROGRAMACAO, PRODUCAO_PROG_PROD.ORDEM_PRODUCAO, PRODUCAO_PROG_PROD.SOBRA_DE_PRODUTO, PRODUCAO_PROG_PROD.SORTIMENTO_COR, PRODUCAO_PROG_PROD.PRODUTO, PRODUTOS.DESC_PRODUTO, 
PRODUCAO_PROG_PROD.COR_PRODUTO, PRODUTO_MONTAGEM_KIT.KIT_PRODUTO , PRODUTO_MONTAGEM_KIT.KIT_COR_PRODUTO, PRODUCAO_PROG_PROD.ENTREGA_INICIAL, PRODUTO_CORES.DESC_COR_PRODUTO, PRODUCAO_PROG_PROD.QTDE_PROGRAMADA, 
PRODUTOS.GRADE, PRODUTOS.MODELAGEM, SPACE(9) AS PACK_QTDE,
PRODUCAO_PROG_PROD.QTDE_GERADA, PRODUCAO_PROG_PROD.P1, PRODUCAO_PROG_PROD.P2, PRODUCAO_PROG_PROD.P3, PRODUCAO_PROG_PROD.P4, PRODUCAO_PROG_PROD.P5, PRODUCAO_PROG_PROD.P6, PRODUCAO_PROG_PROD.P7, 
PRODUCAO_PROG_PROD.P8, PRODUCAO_PROG_PROD.P9, PRODUCAO_PROG_PROD.P10, PRODUCAO_PROG_PROD.P11, PRODUCAO_PROG_PROD.P12, PRODUCAO_PROG_PROD.P13, PRODUCAO_PROG_PROD.P14, PRODUCAO_PROG_PROD.P15, 
PRODUCAO_PROG_PROD.P16, PRODUCAO_PROG_PROD.QTDE_SALDO_EMITIR_OP, 
PRODUCAO_PROG_PROD.S1, PRODUCAO_PROG_PROD.S2, PRODUCAO_PROG_PROD.S3, PRODUCAO_PROG_PROD.S4, PRODUCAO_PROG_PROD.S5, PRODUCAO_PROG_PROD.S6, PRODUCAO_PROG_PROD.S7, PRODUCAO_PROG_PROD.S8, 
PRODUCAO_PROG_PROD.S9, PRODUCAO_PROG_PROD.S10, PRODUCAO_PROG_PROD.S11, PRODUCAO_PROG_PROD.S12, PRODUCAO_PROG_PROD.S13, PRODUCAO_PROG_PROD.S14, PRODUCAO_PROG_PROD.S15, PRODUCAO_PROG_PROD.S16, 
PRODUCAO_PROG_PROD.QTDE_MINIMA_PRODUZIR, PRODUCAO_PROG_PROD.AUMENTO_VENDAS, PRODUCAO_PROG_PROD.ENTREGA_FINAL, PRODUTOS.GRUPO_PRODUTO, PRODUCAO_PROG_PROD.COR_SORTIDA, PRODUTOS.GIRO_ENTREGA, 
PRODUTOS.REVENDA, PRODUTOS.SORTIMENTO_COR AS INDICA_SORTIMENTO,PRODUCAO_PROGRAMA.TIPO_PROGRAMACAO, PRODUTOS.SUBGRUPO_PRODUTO, 
PRODUTOS.PERIODO_PCP, PRODUTO_CORES.MATERIAL, PRODUTO_CORES.COR_MATERIAL, PRODUCAO_PROG_PROD.MATAR_SALDO_PROGRAMACAO, PRODUCAO_PROG_PROD.QTDE_EM_OP, PRODUTO_CORES.COR, PRODUCAO_PROGRAMA.PEDIDO, 
PRODUCAO_PROGRAMA.CLIENTE_ATACADO, PRODUTOS.FABRICANTE AS FORNECEDOR, PRODUCAO_PROG_PROD.MATAR_SALDO_PROGRAMACAO AS TEM_MATERIAL 
FROM  PRODUTOS PRODUTOS, PRODUTO_CORES PRODUTO_CORES, PRODUCAO_PROG_PROD PRODUCAO_PROG_PROD, DBO.PRODUCAO_PROGRAMA PRODUCAO_PROGRAMA, 
PRODUTO_MONTAGEM_KIT 
WHERE (((PRODUCAO_PROG_PROD.PRODUTO = PRODUTOS.PRODUTO AND  PRODUCAO_PROG_PROD.PRODUTO = PRODUTO_CORES.PRODUTO ) AND  
PRODUCAO_PROG_PROD.COR_PRODUTO = PRODUTO_CORES.COR_PRODUTO ) AND  PRODUCAO_PROGRAMA.PROGRAMACAO = PRODUCAO_PROG_PROD.PROGRAMACAO ) AND  
PRODUTO_MONTAGEM_KIT.PRODUTO = PRODUCAO_PROG_PROD.PRODUTO AND PRODUTO_MONTAGEM_KIT.COR_PRODUTO=PRODUCAO_PROG_PROD.COR_PRODUTO AND 
PRODUCAO_PROG_PROD.PROGRAMACAO = 'NEC NOVEMBRO KITS EM 23.1'
) AS PROGRAMACAO 
LEFT JOIN ( 
SELECT PRODUCAO_ORDEM.OBS,PRODUCAO_TAREFAS_SALDO.TAREFA, PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO, KIT_PRODUTO=PRODUCAO_TAREFAS_SALDO.PRODUTO, 
KIT_COR_PRODUTO=PRODUCAO_TAREFAS_SALDO.COR_PRODUTO, PRODUTO_MONTAGEM_KIT.PRODUTO, PRODUTO_MONTAGEM_KIT.COR_PRODUTO, PRODUCAO_TAREFAS_SALDO.QTDE_S, 
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
DBO.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, DBO.PRODUCAO_SETOR PRODUCAO_SETOR, DBO.PRODUTO_MONTAGEM_KIT PRODUTO_MONTAGEM_KIT 
WHERE ((((((((PRODUCAO_TAREFAS.TAREFA = PRODUCAO_TAREFAS_SALDO.TAREFA AND  
PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO = PRODUCAO_ORDEM.ORDEM_PRODUCAO ) AND  
PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO = PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO ) AND  
PRODUCAO_TAREFAS_SALDO.PRODUTO = PRODUCAO_ORDEM_COR.PRODUTO ) AND  
PRODUCAO_TAREFAS_SALDO.COR_PRODUTO = PRODUCAO_ORDEM_COR.COR_PRODUTO ) AND  
PRODUCAO_TAREFAS.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO ) AND  
PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO ) AND  
PRODUCAO_TAREFAS.SETOR_PRODUCAO = PRODUCAO_SETOR.SETOR_PRODUCAO ) AND  
PRODUCAO_TAREFAS_SALDO.PRODUTO = PRODUTOS.PRODUTO )  AND 
PRODUCAO_TAREFAS_SALDO.PRODUTO = PRODUTO_MONTAGEM_KIT.KIT_PRODUTO AND 
PRODUCAO_TAREFAS_SALDO.COR_PRODUTO = PRODUTO_MONTAGEM_KIT.KIT_COR_PRODUTO AND 
PRODUCAO_ORDEM.FILIAL='DR VAREJO' AND PRODUCAO_TAREFAS_SALDO.QTDE_S >0 )  AS PRODUCAO_TAREFAS_SALDO 
ON PRODUCAO_TAREFAS_SALDO.PRODUTO=PROGRAMACAO.PRODUTO AND 
   PRODUCAO_TAREFAS_SALDO.COR_PRODUTO=PROGRAMACAO.COR_PRODUTO AND
   PRODUCAO_TAREFAS_SALDO.KIT_PRODUTO=PROGRAMACAO.KIT_PRODUTO AND 
   PRODUCAO_TAREFAS_SALDO.KIT_COR_PRODUTO=PROGRAMACAO.KIT_COR_PRODUTO AND
   PRODUCAO_TAREFAS_SALDO.COR_PRODUTO=CAST(PRODUCAO_TAREFAS_SALDO.OBS AS CHAR(10))
ORDER BY PROGRAMACAO.PRODUTO,PROGRAMACAO.COR_PRODUTO

