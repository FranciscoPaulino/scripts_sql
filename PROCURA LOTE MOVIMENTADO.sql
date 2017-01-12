EXEC SP_PROCURA_LOTE_MOVIMENTADO '76810','010'


CREATE PROC SP_PROCURA_LOTE_MOVIMENTADO 
@ORDEM_PRODUCAO CHAR(8),
@FASE_PRODUCAO VARCHAR(25)
AS 
SELECT PRODUCAO_ORDEM_LOTES.ORDEM_PRODUCAO,
PRODUCAO_ORDEM_LOTES.PRODUTO,
PRODUCAO_ORDEM_LOTES.COR_PRODUTO,
PRODUCAO_ORDEM_LOTES.NUMERO_LOTE,
LOTE_MOVIMENTADO=PRODUCAO_OS_LOTES.NUMERO_LOTE,
PRODUCAO_ORDEM_LOTES.GRADE_DO_TAMANHO,
PRODUCAO_ORDEM_LOTES.QTDE_LOTE,
PRODUCAO_ORDEM_SERVICO.NF_SAIDA,
PRODUCAO_ORDEM_SERVICO.SERIE_NF
FROM PRODUCAO_ORDEM_LOTES
JOIN PRODUCAO_TAREFAS ON (PRODUCAO_TAREFAS.ORDEM_PRODUCAO=PRODUCAO_ORDEM_LOTES.ORDEM_PRODUCAO)
LEFT JOIN PRODUCAO_OS_LOTES ON (PRODUCAO_OS_LOTES.NUMERO_LOTE=PRODUCAO_ORDEM_LOTES.NUMERO_LOTE AND PRODUCAO_OS_LOTES.TAREFA=PRODUCAO_TAREFAS.TAREFA)
LEFT JOIN PRODUCAO_ORDEM_SERVICO ON (PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO=PRODUCAO_OS_LOTES.ORDEM_SERVICO) 
WHERE PRODUCAO_ORDEM_LOTES.ORDEM_PRODUCAO=@ORDEM_PRODUCAO AND PRODUCAO_TAREFAS.FASE_PRODUCAO=@FASE_PRODUCAO



