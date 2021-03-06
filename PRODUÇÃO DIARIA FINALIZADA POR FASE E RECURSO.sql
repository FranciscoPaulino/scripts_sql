SELECT COSTURA.DESC_SETOR_PRODUCAO AS OFICINA,COSTURA.RECURSO_PRODUTIVO AS GRUPO,
PRODUCAO_OS_ANTERIOR.TAREFA,PRODUCAO_OS_ANTERIOR.TAREFA_ANTERIOR,  PRODUCAO_ORDEM_SERVICO.DATA, PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,   PRODUCAO_RECURSOS.DESC_RECURSO, PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO,   
PRODUCAO_ORDEM_SERVICO.NF_ENTRADA, PRODUCAO_TAREFAS.FASE_PRODUCAO,   PRODUCAO_FASE.DESC_FASE_PRODUCAO, PRODUCAO_TAREFAS.SETOR_PRODUCAO, PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO,  
PRODUCAO_OS_ANTERIOR.PRODUTO, PRODUTOS.DESC_PRODUTO,   PRODUCAO_OS_ANTERIOR.COR_PRODUTO,  ISNULL(PRODUCAO_TAREFAS_SALDO.QTDE_S,0)AS QTDE_S, QTDE_A_PRODUZIR,   QTDE_A, QTDE_R,   PRODUCAO_OS_ANTERIOR.CUSTO_EFETIVO, 
PRODUCAO_OS_ANTERIOR.DESCONTO_APLICADO,  PRODUCAO_OS_ANTERIOR.VALOR_CREDITADO,  PRODUCAO_ORDEM_SERVICO.CONFERIDO_POR,  PRODUCAO_ORDEM_SERVICO.FILIAL, PRODUCAO_TAREFAS.INICIO_PREVISTO,   PRODUCAO_TAREFAS.INICIO_REAL, 
PRODUCAO_TAREFAS.FIM_PREVISTO,  PRODUCAO_TAREFAS.ENCERRAMENTO, PRODUCAO_ORDEM_SERVICO.OBSERVACAO,  PRODUCAO_TAREFAS.OBS AS OBS_TAREFA, PRODUCAO_TAREFAS.FIM_ATUALIZADO,  PRODUCAO_RECURSOS.TIPO_RECURSO,  
PRODUCAO_RECURSOS.RECURSO_PROPRIO,  PRODUCAO_RECURSOS.NOME_CLIFOR, PRODUCAO_TAREFAS.CUSTO_TAREFA AS CUSTO_PREVISTO,   PRODUCAO_TAREFAS.CUSTO_TAREFA*PRODUCAO_OS_ANTERIOR.QTDE_A AS 
VALOR_PREVISTO,GRUPO_PRODUTO,SUBGRUPO_PRODUTO,COLECAO, LINHA,GRIFFE,MODELAGEM,TABELA_OPERACOES,TIPO_PRODUTO, FILIAIS.EMPRESA,PRODUCAO_TAREFAS.SETOR_PARALELO_NUMERO  , PRODUCAO_OS_TAREFAS.INDICADOR_TIPO_MOV  
FROM FX_PRODUCAO_RECURSO_CREDITOS() AS PRODUCAO_OS_ANTERIOR  INNER JOIN PRODUCAO_OS_TAREFAS WITH (NOLOCK) ON PRODUCAO_OS_TAREFAS.ORDEM_SERVICO = PRODUCAO_OS_ANTERIOR.ORDEM_SERVICO  AND PRODUCAO_OS_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO  AND PRODUCAO_OS_TAREFAS.PRODUTO = PRODUCAO_OS_ANTERIOR.PRODUTO  AND PRODUCAO_OS_TAREFAS.COR_PRODUTO = PRODUCAO_OS_ANTERIOR.COR_PRODUTO  AND PRODUCAO_OS_TAREFAS.TAREFA = PRODUCAO_OS_ANTERIOR.TAREFA  INNER JOIN PRODUCAO_TAREFAS WITH (NOLOCK) ON  PRODUCAO_OS_ANTERIOR.TAREFA_AUX = PRODUCAO_TAREFAS.TAREFA  INNER JOIN PRODUCAO_ORDEM_SERVICO WITH (NOLOCK) ON PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO = PRODUCAO_OS_ANTERIOR.ORDEM_SERVICO   LEFT  JOIN PRODUCAO_TAREFAS_SALDO WITH (NOLOCK) ON PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO = PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO  AND PRODUCAO_OS_ANTERIOR.PRODUTO = PRODUCAO_TAREFAS_SALDO.PRODUTO   AND PRODUCAO_OS_ANTERIOR.COR_PRODUTO = PRODUCAO_TAREFAS_SALDO.COR_PRODUTO   AND PRODUCAO_TAREFAS.TAREFA = PRODUCAO_TAREFAS_SALDO.TAREFA   AND PRODUCAO_OS_ANTERIOR.TAREFA_ANTERIOR = PRODUCAO_TAREFAS_SALDO.TAREFA   INNER JOIN PRODUTOS WITH (NOLOCK) ON PRODUCAO_OS_ANTERIOR.PRODUTO = PRODUTOS.PRODUTO   INNER JOIN PRODUCAO_FASE WITH (NOLOCK) ON PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_FASE.FASE_PRODUCAO   INNER JOIN PRODUCAO_SETOR WITH (NOLOCK) ON PRODUCAO_TAREFAS.SETOR_PRODUCAO = PRODUCAO_SETOR.SETOR_PRODUCAO  AND  PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO   INNER JOIN PRODUCAO_RECURSOS WITH (NOLOCK) ON PRODUCAO_TAREFAS.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO   INNER JOIN FILIAIS WITH (NOLOCK) ON PRODUCAO_ORDEM_SERVICO.FILIAL  = FILIAIS.FILIAL LEFT JOIN 
( 
SELECT PRODUTOS.PRODUTO,PRODUCAO_TAREFAS.ORDEM_PRODUCAO,PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,PRODUCAO_RECURSOS.DESC_RECURSO,PRODUCAO_SETOR.DESC_SETOR_PRODUCAO
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE with (nolock), dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS with (nolock), dbo.PRODUCAO_SETOR PRODUCAO_SETOR with (nolock), dbo.PRODUCAO_TAREFAS PRODUCAO_TAREFAS with (nolock), dbo.PRODUTOS PRODUTOS with (nolock), dbo.PRODUCAO_ORDEM with (nolock)
WHERE PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = PRODUCAO_TAREFAS.RECURSO_PRODUTIVO AND 
PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO AND 
PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_ORDEM.PRODUTO=PRODUTOS.PRODUTO AND
PRODUCAO_ORDEM.ORDEM_PRODUCAO=PRODUCAO_TAREFAS.ORDEM_PRODUCAO AND
PRODUCAO_FASE.FASE_PRODUCAO='007'

) AS COSTURA ON COSTURA.ORDEM_PRODUCAO=PRODUCAO_OS_TAREFAS.ORDEM_PRODUCAO
WHERE PRODUCAO_ORDEM_SERVICO.DATA >= '20140101' AND PRODUCAO_TAREFAS.FASE_PRODUCAO 
IN('002','003','004','005','006','007','008','009')
