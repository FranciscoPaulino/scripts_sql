SELECT RECEBIMENTO.PRODUTO,RECEBIMENTO.ORDEM_PRODUCAO,RECEBIMENTO.RECURSO_PRODUTIVO,RECEBIMENTO.DESC_SETOR_PRODUCAO,GRUPO=COSTURA.RECURSO_PRODUTIVO,RECEBIMENTO.QTDE_S FROM (

SELECT PRODUCAO_TAREFAS.QTDE_EM_PROCESSO, PRODUCAO_TAREFAS_SALDO.TAREFA, PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO, PRODUCAO_TAREFAS_SALDO.PRODUTO, PRODUCAO_TAREFAS_SALDO.COR_PRODUTO, PRODUCAO_TAREFAS_SALDO.QTDE_S, PRODUCAO_TAREFAS_SALDO.S1, PRODUCAO_TAREFAS_SALDO.S2, PRODUCAO_TAREFAS_SALDO.S3, PRODUCAO_TAREFAS_SALDO.S4, PRODUCAO_TAREFAS_SALDO.S5, PRODUCAO_TAREFAS_SALDO.S6, PRODUCAO_TAREFAS_SALDO.S7, PRODUCAO_TAREFAS_SALDO.S8, PRODUCAO_TAREFAS_SALDO.S9, PRODUCAO_TAREFAS_SALDO.S10, PRODUCAO_TAREFAS_SALDO.S11, PRODUCAO_TAREFAS_SALDO.S12, PRODUCAO_RECURSOS.RECURSO_PRODUTIVO, PRODUCAO_RECURSOS.DESC_RECURSO, PRODUTOS.DESC_PRODUTO, PRODUTOS.GRUPO_PRODUTO, PRODUTOS.SUBGRUPO_PRODUTO, PRODUTOS.COLECAO, PRODUTOS.LINHA, PRODUTOS.GRIFFE, PRODUCAO_SETOR.SETOR_PRODUCAO, PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, PRODUCAO_FASE.FASE_PRODUCAO, PRODUCAO_FASE.DESC_FASE_PRODUCAO
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE, dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, dbo.PRODUCAO_SETOR PRODUCAO_SETOR, dbo.PRODUCAO_TAREFAS PRODUCAO_TAREFAS, dbo.PRODUCAO_TAREFAS_SALDO PRODUCAO_TAREFAS_SALDO, dbo.PRODUTOS PRODUTOS
WHERE PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = PRODUCAO_TAREFAS.RECURSO_PRODUTIVO AND 
PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO AND 
PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_TAREFAS.TAREFA = PRODUCAO_TAREFAS_SALDO.TAREFA AND 
PRODUCAO_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO AND 
PRODUCAO_TAREFAS_SALDO.PRODUTO = PRODUTOS.PRODUTO AND PRODUCAO_FASE.FASE_PRODUCAO='006' ) AS RECEBIMENTO

LEFT JOIN (
 
SELECT PRODUTOS.PRODUTO,PRODUCAO_TAREFAS.ORDEM_PRODUCAO,PRODUCAO_TAREFAS.RECURSO_PRODUTIVO
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE, dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, dbo.PRODUCAO_SETOR PRODUCAO_SETOR, dbo.PRODUCAO_TAREFAS PRODUCAO_TAREFAS, dbo.PRODUTOS PRODUTOS, dbo.PRODUCAO_ORDEM
WHERE PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = PRODUCAO_TAREFAS.RECURSO_PRODUTIVO AND 
PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO AND 
PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_ORDEM.PRODUTO=PRODUTOS.PRODUTO AND
PRODUCAO_ORDEM.ORDEM_PRODUCAO=PRODUCAO_TAREFAS.ORDEM_PRODUCAO AND
PRODUCAO_FASE.FASE_PRODUCAO='007'

 ) AS COSTURA

ON RECEBIMENTO.PRODUTO=COSTURA.PRODUTO AND RECEBIMENTO.ORDEM_PRODUCAO=COSTURA.ORDEM_PRODUCAO
ORDER BY RECEBIMENTO.ORDEM_PRODUCAO