SELECT DESC_SETOR_PRODUCAO=SUBSTRING(COSTURA.DESC_SETOR_PRODUCAO,9,10),COSTURA.DESC_RECURSO, 
PRODUCAO_ORDEM.PRODUTO,PRODUCAO_ORDEM_COR.COR_PRODUTO,PRODUCAO_TAREFAS.RECURSO_PRODUTIVO, PRODUCAO_TAREFAS.ORDEM_PRODUCAO, PRODUCAO_ORDEM.PRIORIDADE, 
PRODUCAO_TAREFAS.FASE_PRODUCAO, PRODUCAO_TAREFAS.SETOR_PRODUCAO,PRODUCAO_RECURSOS.DESC_RECURSO,PRODUCAO_TAREFAS.INICIO_REAL, 
ATRASO=DATEDIFF(DAY, PRODUCAO_TAREFAS.FIM_ATUALIZADO, GETDATE()), 
PRODUCAO_TAREFAS.FIM_ATUALIZADO, PRODUCAO_TAREFAS.QTDE_A_PRODUZIR, PRODUCAO_TAREFAS_SALDO.QTDE_S AS QTDE_EM_PROCESSO 
FROM PRODUCAO_TAREFAS WITH (NOLOCK)
INNER JOIN PRODUCAO_ORDEM WITH (NOLOCK) ON PRODUCAO_ORDEM.ORDEM_PRODUCAO = PRODUCAO_TAREFAS.ORDEM_PRODUCAO 
INNER JOIN PRODUCAO_ORDEM_COR WITH (NOLOCK) ON PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO = PRODUCAO_ORDEM.ORDEM_PRODUCAO AND PRODUCAO_ORDEM_COR.PRODUTO=PRODUCAO_ORDEM.PRODUTO  
INNER JOIN PRODUCAO_RECURSOS WITH (NOLOCK) ON PRODUCAO_TAREFAS.RECURSO_PRODUTIVO=PRODUCAO_RECURSOS.RECURSO_PRODUTIVO
INNER JOIN (
SELECT PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO,  PRODUCAO_TAREFAS_SALDO.TAREFA, PRODUCAO_TAREFAS_SALDO.PRODUTO,  PRODUCAO_TAREFAS_SALDO.COR_PRODUTO, PRODUCAO_TAREFAS_SALDO.QTDE_S,  
PRODUCAO_TAREFAS_SALDO.S1, PRODUCAO_TAREFAS_SALDO.S2,  PRODUCAO_TAREFAS_SALDO.S3, PRODUCAO_TAREFAS_SALDO.S4,  PRODUCAO_TAREFAS_SALDO.S5, PRODUCAO_TAREFAS_SALDO.S6,  
PRODUCAO_TAREFAS_SALDO.S7, PRODUCAO_TAREFAS_SALDO.S8,  PRODUCAO_TAREFAS_SALDO.S9, PRODUCAO_TAREFAS_SALDO.S10,  PRODUCAO_TAREFAS_SALDO.S11, PRODUCAO_TAREFAS_SALDO.S12,  
PRODUCAO_TAREFAS_SALDO.S13, PRODUCAO_TAREFAS_SALDO.S14,  PRODUCAO_TAREFAS_SALDO.S15, PRODUCAO_TAREFAS_SALDO.S16, PRODUTO_CORES.DESC_COR_PRODUTO,  PRODUCAO_TAREFAS.SEQUENCIA_PRODUTIVA,  
PRODUCAO_TAREFAS.SETOR_PARALELO_NUMERO,  PRODUCAO_TAREFAS.FASE_PRODUCAO, PRODUCAO_FASE.DESC_FASE_PRODUCAO,  PRODUCAO_TAREFAS.SETOR_PRODUCAO, PRODUCAO_SETOR.DESC_SETOR_PRODUCAO,  PRODUCAO_TAREFAS.RECURSO_PRODUTIVO, PRODUCAO_RECURSOS.DESC_RECURSO,  PRODUCAO_TAREFAS.INICIO_LIBERADO, PRODUCAO_TAREFAS.INICIO_PREVISTO,  PRODUCAO_TAREFAS.INICIO_REAL, PRODUCAO_TAREFAS.FIM_PREVISTO,  PRODUCAO_TAREFAS.FIM_ATUALIZADO, PRODUCAO_TAREFAS.ENCERRAMENTO,  PRODUCAO_TAREFAS.QTDE_PREVISTA, PRODUCAO_TAREFAS.QTDE_A_PRODUZIR,  PRODUCAO_TAREFAS.QTDE_EM_PROCESSO, PRODUCAO_TAREFAS.QTDE_FINALIZADA,  PRODUCAO_TAREFAS.QTDE_ALTERACAO_OP, PRODUCAO_TAREFAS.QTDE_PERDAS,  PRODUCAO_TAREFAS.QTDE_ALT_OUTRAS_TAREFAS,  PRODUCAO_TAREFAS.CUSTO_TAREFA, PRODUCAO_TAREFAS.DESCONTOS_TAREFA,  PRODUCAO_TAREFAS.VALOR_TAREFA, PRODUCAO_TAREFAS.STATUS,  PRODUCAO_TAREFAS.TIPO_TEMPO_PROCESSO, PRODUCAO_TAREFAS.METODO_LOTE,  PRODUCAO_TAREFAS.METODO_LOTE_QTDE, PRODUCAO_TAREFAS.TIPO_TAREFA,  PRODUCAO_TAREFAS.TEMPO_OPERACAO FROM DBO.PRODUCAO_TAREFAS_SALDO PRODUCAO_TAREFAS_SALDO WITH (NOLOCK),  DBO.PRODUTO_CORES PRODUTO_CORES WITH (NOLOCK),  DBO.PRODUCAO_TAREFAS PRODUCAO_TAREFAS WITH (NOLOCK),  DBO.PRODUCAO_FASE PRODUCAO_FASE WITH (NOLOCK), DBO.PRODUCAO_SETOR PRODUCAO_SETOR WITH (NOLOCK),  DBO.PRODUCAO_RECURSOS PRODUCAO_RECURSOS WITH (NOLOCK)
WHERE PRODUTO_CORES.PRODUTO = PRODUCAO_TAREFAS_SALDO.PRODUTO   AND PRODUCAO_TAREFAS_SALDO.COR_PRODUTO = PRODUTO_CORES.COR_PRODUTO   AND PRODUCAO_TAREFAS_SALDO.TAREFA = PRODUCAO_TAREFAS.TAREFA   AND PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO   AND PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO   AND PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO   AND PRODUCAO_TAREFAS.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO AND PRODUCAO_TAREFAS.RECURSO_PRODUTIVO='004' AND PRODUCAO_TAREFAS_SALDO.QTDE_S>0
) AS PRODUCAO_TAREFAS_SALDO ON PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO=PRODUCAO_TAREFAS.ORDEM_PRODUCAO AND PRODUCAO_TAREFAS_SALDO.TAREFA=PRODUCAO_TAREFAS.TAREFA AND PRODUCAO_TAREFAS_SALDO.PRODUTO=PRODUCAO_ORDEM_COR.PRODUTO AND PRODUCAO_TAREFAS_SALDO.COR_PRODUTO=PRODUCAO_ORDEM_COR.COR_PRODUTO

LEFT JOIN (

SELECT PRODUTOS.PRODUTO,PRODUCAO_TAREFAS.ORDEM_PRODUCAO,PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,PRODUCAO_RECURSOS.DESC_RECURSO,PRODUCAO_SETOR.DESC_SETOR_PRODUCAO
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE WITH (NOLOCK), dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS WITH (NOLOCK), 
dbo.PRODUCAO_SETOR PRODUCAO_SETOR WITH (NOLOCK), dbo.PRODUCAO_TAREFAS PRODUCAO_TAREFAS WITH (NOLOCK), 
dbo.PRODUTOS PRODUTOS, dbo.PRODUCAO_ORDEM WITH (NOLOCK)
WHERE PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = PRODUCAO_TAREFAS.RECURSO_PRODUTIVO AND 
PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO AND 
PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_ORDEM.PRODUTO=PRODUTOS.PRODUTO AND
PRODUCAO_ORDEM.ORDEM_PRODUCAO=PRODUCAO_TAREFAS.ORDEM_PRODUCAO AND
PRODUCAO_FASE.FASE_PRODUCAO='007' 

 ) AS COSTURA

ON PRODUCAO_ORDEM_COR.PRODUTO=COSTURA.PRODUTO AND PRODUCAO_ORDEM_COR.ORDEM_PRODUCAO=COSTURA.ORDEM_PRODUCAO

WHERE (PRODUCAO_TAREFAS.RECURSO_PRODUTIVO='004') 
AND (PRODUCAO_TAREFAS.QTDE_EM_PROCESSO > 0)  AND (PRODUCAO_ORDEM_COR.QTDE_P>0) 
ORDER BY ATRASO DESC
