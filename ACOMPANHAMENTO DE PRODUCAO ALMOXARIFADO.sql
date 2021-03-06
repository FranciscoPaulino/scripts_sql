exec sp_executesql N'
/* lx008030spk  CursorAdapter: cur_v_producao_recurso_creditos_01(Alias: v_producao_recurso_creditos_01)  */
SELECT PRODUCAO_OS_ANTERIOR.TAREFA,PRODUCAO_OS_ANTERIOR.TAREFA_ANTERIOR,  PRODUCAO_ORDEM_SERVICO.DATA, PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,   PRODUCAO_RECURSOS.DESC_RECURSO, PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO,   PRODUCAO_ORDEM_SERVICO.NF_ENTRADA, PRODUCAO_TAREFAS.FASE_PRODUCAO,   PRODUCAO_FASE.DESC_FASE_PRODUCAO, PRODUCAO_TAREFAS.SETOR_PRODUCAO, PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO,  PRODUCAO_OS_ANTERIOR.PRODUTO, PRODUTOS.DESC_PRODUTO,   PRODUCAO_OS_ANTERIOR.COR_PRODUTO,  
ISNULL(PRODUCAO_TAREFAS_SALDO.QTDE_S,0)AS QTDE_S, QTDE_A_PRODUZIR,   QTDE_A, QTDE_R,   PRODUCAO_OS_ANTERIOR.CUSTO_EFETIVO, PRODUCAO_OS_ANTERIOR.DESCONTO_APLICADO,  
PRODUCAO_OS_ANTERIOR.VALOR_CREDITADO,  PRODUCAO_ORDEM_SERVICO.CONFERIDO_POR,  PRODUCAO_ORDEM_SERVICO.FILIAL, PRODUCAO_TAREFAS.INICIO_PREVISTO,   PRODUCAO_TAREFAS.INICIO_REAL, 
PRODUCAO_TAREFAS.FIM_PREVISTO,  PRODUCAO_TAREFAS.ENCERRAMENTO, PRODUCAO_ORDEM_SERVICO.OBSERVACAO,  PRODUCAO_TAREFAS.OBS AS OBS_TAREFA, PRODUCAO_TAREFAS.FIM_ATUALIZADO,  
PRODUCAO_RECURSOS.TIPO_RECURSO,  PRODUCAO_RECURSOS.RECURSO_PROPRIO,  PRODUCAO_RECURSOS.NOME_CLIFOR, PRODUCAO_TAREFAS.CUSTO_TAREFA AS CUSTO_PREVISTO,   
PRODUCAO_TAREFAS.CUSTO_TAREFA*PRODUCAO_OS_ANTERIOR.QTDE_A AS VALOR_PREVISTO,GRUPO_PRODUTO,SUBGRUPO_PRODUTO,COLECAO, LINHA,GRIFFE,MODELAGEM,TABELA_OPERACOES,TIPO_PRODUTO, 
FILIAIS.EMPRESA,PRODUCAO_TAREFAS.SETOR_PARALELO_NUMERO  , PRODUCAO_OS_TAREFAS.INDICADOR_TIPO_MOV  FROM FX_PRODUCAO_RECURSO_CREDITOS() AS PRODUCAO_OS_ANTERIOR  INNER JOIN PRODUCAO_OS_TAREFAS ON PRODUCAO_OS_TAREFAS.ORDEM_SERVICO = PRODUCAO_OS_ANTERIOR.ORDEM_SERVICO  AND PRODUCAO_OS_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO  AND PRODUCAO_OS_TAREFAS.PRODUTO = PRODUCAO_OS_ANTERIOR.PRODUTO  AND PRODUCAO_OS_TAREFAS.COR_PRODUTO = PRODUCAO_OS_ANTERIOR.COR_PRODUTO  AND PRODUCAO_OS_TAREFAS.TAREFA = PRODUCAO_OS_ANTERIOR.TAREFA  INNER JOIN PRODUCAO_TAREFAS ON  PRODUCAO_OS_ANTERIOR.TAREFA_AUX = PRODUCAO_TAREFAS.TAREFA  INNER JOIN PRODUCAO_ORDEM_SERVICO ON PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO = PRODUCAO_OS_ANTERIOR.ORDEM_SERVICO   LEFT  JOIN PRODUCAO_TAREFAS_SALDO ON PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO = PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO  AND PRODUCAO_OS_ANTERIOR.PRODUTO = PRODUCAO_TAREFAS_SALDO.PRODUTO   AND PRODUCAO_OS_ANTERIOR.COR_PRODUTO = PRODUCAO_TAREFAS_SALDO.COR_PRODUTO   AND PRODUCAO_TAREFAS.TAREFA = PRODUCAO_TAREFAS_SALDO.TAREFA   AND PRODUCAO_OS_ANTERIOR.TAREFA_ANTERIOR = PRODUCAO_TAREFAS_SALDO.TAREFA   INNER JOIN PRODUTOS ON PRODUCAO_OS_ANTERIOR.PRODUTO = PRODUTOS.PRODUTO   INNER JOIN PRODUCAO_FASE ON PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_FASE.FASE_PRODUCAO   INNER JOIN PRODUCAO_SETOR ON PRODUCAO_TAREFAS.SETOR_PRODUCAO = PRODUCAO_SETOR.SETOR_PRODUCAO  AND  PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO   INNER JOIN PRODUCAO_RECURSOS ON PRODUCAO_TAREFAS.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO   INNER JOIN FILIAIS ON PRODUCAO_ORDEM_SERVICO.FILIAL  = FILIAIS.FILIAL   WHERE PRODUCAO_ORDEM_SERVICO.DATA >= ''20130527'' AND PRODUCAO_ORDEM_SERVICO.DATA <= ''20130527'' AND PRODUCAO_TAREFAS.FASE_PRODUCAO = @P1 AND PRODUCAO_ORDEM_SERVICO.FILIAL = @P2',N'@P1 varchar(3),@P2 varchar(9)','002','DR VAREJO'


-- ANALITICO
SELECT PRODUCAO_ORDEM_SERVICO.FILIAL,
PRODUCAO_ORDEM_SERVICO.DATA, 
PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,   
PRODUCAO_RECURSOS.DESC_RECURSO, 
PRODUCAO_TAREFAS.FASE_PRODUCAO,   
PRODUCAO_FASE.DESC_FASE_PRODUCAO, 
PRODUCAO_TAREFAS.SETOR_PRODUCAO, 
PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, 
PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO,  
QTDE_A_PRODUZIR=SUM(QTDE_A_PRODUZIR),
QTDE_A=SUM(QTDE_A),
QTDE_R=SUM(QTDE_R)
FROM FX_PRODUCAO_RECURSO_CREDITOS() AS PRODUCAO_OS_ANTERIOR  
INNER JOIN PRODUCAO_OS_TAREFAS ON PRODUCAO_OS_TAREFAS.ORDEM_SERVICO = PRODUCAO_OS_ANTERIOR.ORDEM_SERVICO  
AND PRODUCAO_OS_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO  
AND PRODUCAO_OS_TAREFAS.PRODUTO = PRODUCAO_OS_ANTERIOR.PRODUTO  
AND PRODUCAO_OS_TAREFAS.COR_PRODUTO = PRODUCAO_OS_ANTERIOR.COR_PRODUTO  
AND PRODUCAO_OS_TAREFAS.TAREFA = PRODUCAO_OS_ANTERIOR.TAREFA  
INNER JOIN PRODUCAO_TAREFAS ON  PRODUCAO_OS_ANTERIOR.TAREFA_AUX = PRODUCAO_TAREFAS.TAREFA  
INNER JOIN PRODUCAO_ORDEM_SERVICO ON PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO = PRODUCAO_OS_ANTERIOR.ORDEM_SERVICO   
LEFT  JOIN PRODUCAO_TAREFAS_SALDO ON PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO = PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO  
AND PRODUCAO_OS_ANTERIOR.PRODUTO = PRODUCAO_TAREFAS_SALDO.PRODUTO   
AND PRODUCAO_OS_ANTERIOR.COR_PRODUTO = PRODUCAO_TAREFAS_SALDO.COR_PRODUTO   
AND PRODUCAO_TAREFAS.TAREFA = PRODUCAO_TAREFAS_SALDO.TAREFA   
AND PRODUCAO_OS_ANTERIOR.TAREFA_ANTERIOR = PRODUCAO_TAREFAS_SALDO.TAREFA   
INNER JOIN PRODUTOS ON PRODUCAO_OS_ANTERIOR.PRODUTO = PRODUTOS.PRODUTO   
INNER JOIN PRODUCAO_FASE ON PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_FASE.FASE_PRODUCAO   
INNER JOIN PRODUCAO_SETOR ON PRODUCAO_TAREFAS.SETOR_PRODUCAO = PRODUCAO_SETOR.SETOR_PRODUCAO  
AND  PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO   
INNER JOIN PRODUCAO_RECURSOS ON PRODUCAO_TAREFAS.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO   
INNER JOIN FILIAIS ON PRODUCAO_ORDEM_SERVICO.FILIAL  = FILIAIS.FILIAL   
WHERE PRODUCAO_ORDEM_SERVICO.DATA >= '20130527' AND PRODUCAO_ORDEM_SERVICO.DATA <= '20130527' 
AND PRODUCAO_TAREFAS.FASE_PRODUCAO = '002' AND PRODUCAO_ORDEM_SERVICO.FILIAL = 'DR VAREJO'
GROUP BY PRODUCAO_ORDEM_SERVICO.FILIAL,
PRODUCAO_ORDEM_SERVICO.DATA, 
PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,   
PRODUCAO_RECURSOS.DESC_RECURSO, 
PRODUCAO_TAREFAS.FASE_PRODUCAO,   
PRODUCAO_FASE.DESC_FASE_PRODUCAO, 
PRODUCAO_TAREFAS.SETOR_PRODUCAO, 
PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, 
PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO


-- SINTETICO FASE CORTE/ALMOXARIFADO
CREATE VIEW SAW_ACOMPANHAMENTO_CORTE_ALMOX AS 
SELECT 
PRODUCAO_ORDEM_SERVICO.FILIAL,
PRODUCAO_ORDEM_SERVICO.DATA, 
PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,   
PRODUCAO_RECURSOS.DESC_RECURSO, 
PRODUCAO_TAREFAS.FASE_PRODUCAO,   
PRODUCAO_FASE.DESC_FASE_PRODUCAO, 
PRODUCAO_TAREFAS.SETOR_PRODUCAO, 
PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, 
QTDE_A_PRODUZIR=SUM(QTDE_A_PRODUZIR),
QTDE_A=SUM(QTDE_A),
QTDE_R=SUM(QTDE_R),
META=22000,
EFICIENCIA = CAST((CAST(SUM(QTDE_A) AS NUMERIC) / CAST(22000 AS NUMERIC) * 100) AS NUMERIC)
FROM FX_PRODUCAO_RECURSO_CREDITOS() AS PRODUCAO_OS_ANTERIOR  

INNER JOIN PRODUCAO_OS_TAREFAS 
ON PRODUCAO_OS_TAREFAS.ORDEM_SERVICO = PRODUCAO_OS_ANTERIOR.ORDEM_SERVICO  
AND PRODUCAO_OS_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO  
AND PRODUCAO_OS_TAREFAS.PRODUTO = PRODUCAO_OS_ANTERIOR.PRODUTO  
AND PRODUCAO_OS_TAREFAS.COR_PRODUTO = PRODUCAO_OS_ANTERIOR.COR_PRODUTO  
AND PRODUCAO_OS_TAREFAS.TAREFA = PRODUCAO_OS_ANTERIOR.TAREFA  

INNER JOIN PRODUCAO_TAREFAS ON  PRODUCAO_OS_ANTERIOR.TAREFA_AUX = PRODUCAO_TAREFAS.TAREFA  

INNER JOIN PRODUCAO_ORDEM_SERVICO ON PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO = PRODUCAO_OS_ANTERIOR.ORDEM_SERVICO   

LEFT  JOIN PRODUCAO_TAREFAS_SALDO ON PRODUCAO_OS_ANTERIOR.ORDEM_PRODUCAO = PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO  
AND PRODUCAO_OS_ANTERIOR.PRODUTO = PRODUCAO_TAREFAS_SALDO.PRODUTO   
AND PRODUCAO_OS_ANTERIOR.COR_PRODUTO = PRODUCAO_TAREFAS_SALDO.COR_PRODUTO   
AND PRODUCAO_TAREFAS.TAREFA = PRODUCAO_TAREFAS_SALDO.TAREFA   
AND PRODUCAO_OS_ANTERIOR.TAREFA_ANTERIOR = PRODUCAO_TAREFAS_SALDO.TAREFA   

INNER JOIN PRODUTOS ON PRODUCAO_OS_ANTERIOR.PRODUTO = PRODUTOS.PRODUTO   

INNER JOIN PRODUCAO_FASE ON PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_FASE.FASE_PRODUCAO   

INNER JOIN PRODUCAO_SETOR ON PRODUCAO_TAREFAS.SETOR_PRODUCAO = PRODUCAO_SETOR.SETOR_PRODUCAO  
AND  PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO   

INNER JOIN PRODUCAO_RECURSOS ON PRODUCAO_TAREFAS.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO   

INNER JOIN FILIAIS ON PRODUCAO_ORDEM_SERVICO.FILIAL  = FILIAIS.FILIAL   

--WHERE PRODUCAO_ORDEM_SERVICO.DATA >= '20130527' AND PRODUCAO_ORDEM_SERVICO.DATA <= '20130601' 
--AND PRODUCAO_TAREFAS.FASE_PRODUCAO IN ('002','003') AND PRODUCAO_ORDEM_SERVICO.FILIAL = 'DR VAREJO'

GROUP BY 
PRODUCAO_ORDEM_SERVICO.FILIAL,
PRODUCAO_ORDEM_SERVICO.DATA, 
PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,   
PRODUCAO_RECURSOS.DESC_RECURSO, 
PRODUCAO_TAREFAS.FASE_PRODUCAO,   
PRODUCAO_FASE.DESC_FASE_PRODUCAO, 
PRODUCAO_TAREFAS.SETOR_PRODUCAO, 
PRODUCAO_SETOR.DESC_SETOR_PRODUCAO


SELECT * FROM SAW_ACOMPANHAMENTO_CORTE_ALMOX
WHERE DATA >= '20130527' AND DATA <= '20130601' AND FASE_PRODUCAO IN ('002','003') AND FILIAL = 'DR VAREJO'



select * from PRODUCAO_TAREFAS
where ORDEM_PRODUCAO='53683'


SELECT PRODUCAO_TAREFAS.RECURSO_PRODUTIVO, PRODUCAO_TAREFAS.ORDEM_PRODUCAO, PRODUCAO_ORDEM.PRIORIDADE, 
PRODUCAO_TAREFAS.FASE_PRODUCAO, PRODUCAO_TAREFAS.SETOR_PRODUCAO,PRODUCAO_RECURSOS.DESC_RECURSO,PRODUCAO_TAREFAS.INICIO_REAL, 
DATEPART(dayofyear, GETDATE()) - DATEPART(dayofyear, PRODUCAO_TAREFAS.INICIO_REAL) AS GIRO, 
PRODUCAO_TAREFAS.FIM_ATUALIZADO AS FIM_LIBERADO, 
CASE WHEN PRODUCAO_TAREFAS.STATUS<3 AND DATEDIFF(DD,GETDATE(),PRODUCAO_TAREFAS.FIM_ATUALIZADO)<0 THEN-1* DATEDIFF(DD,GETDATE(),PRODUCAO_TAREFAS.FIM_ATUALIZADO) ELSE 0 END AS DIAS_ATRASO,CASE WHEN PRODUCAO_TAREFAS.STATUS<3 THEN CONVERT(DATETIME ,CONVERT(CHAR(8),GETDATE(),112)) ELSE PRODUCAO_TAREFAS.ENCERRAMENTO END AS FIM_REVISADO,
PRODUCAO_TAREFAS.QTDE_A_PRODUZIR, PRODUCAO_TAREFAS.QTDE_EM_PROCESSO 
FROM PRODUCAO_TAREFAS 
INNER JOIN PRODUCAO_ORDEM ON PRODUCAO_ORDEM.ORDEM_PRODUCAO = PRODUCAO_TAREFAS.ORDEM_PRODUCAO 
INNER JOIN PRODUCAO_RECURSOS ON PRODUCAO_TAREFAS.RECURSO_PRODUTIVO=PRODUCAO_RECURSOS.RECURSO_PRODUTIVO
WHERE (PRODUCAO_TAREFAS.RECURSO_PRODUTIVO LIKE '001')
AND (PRODUCAO_TAREFAS.QTDE_A_PRODUZIR + PRODUCAO_TAREFAS.QTDE_EM_PROCESSO > 0) 
AND (YEAR(PRODUCAO_TAREFAS.INICIO_REAL) = 2013) 
ORDER BY GIRO DESC

SELECT DESC_RECURSO,RECURSO_PRODUTIVO FROM PRODUCAO_RECURSOS

SELECT GETDATE()-77

SELECT GIRO, COUNT(ORDEM_PRODUCAO) AS QTDE_OP 
FROM (SELECT PRODUCAO_TAREFAS.ORDEM_PRODUCAO, DATEPART(dayofyear, GETDATE()) - DATEPART(dayofyear, PRODUCAO_TAREFAS.INICIO_REAL) AS GIRO 
FROM PRODUCAO_TAREFAS INNER JOIN PRODUCAO_ORDEM ON PRODUCAO_ORDEM.ORDEM_PRODUCAO = PRODUCAO_TAREFAS.ORDEM_PRODUCAO 
WHERE (PRODUCAO_TAREFAS.RECURSO_PRODUTIVO LIKE '002') AND (PRODUCAO_TAREFAS.QTDE_A_PRODUZIR + PRODUCAO_TAREFAS.QTDE_EM_PROCESSO > 0) AND (YEAR(PRODUCAO_TAREFAS.INICIO_REAL) = 2013)) AS GIROS GROUP BY GIRO


exec sp_executesql N'
/* lx008021spk  CursorAdapter: cur_v_producao_ordem_01_tarefas(Alias: v_producao_ordem_01_tarefas)  */
SELECT PRODUCAO_TAREFAS.TAREFA, PRODUCAO_TAREFAS.SEQUENCIA_PRODUTIVA, PRODUCAO_TAREFAS.SETOR_PARALELO_NUMERO, PRODUCAO_TAREFAS.ORDEM_PRODUCAO, PRODUCAO_TAREFAS.FASE_PRODUCAO, 
PRODUCAO_TAREFAS.SETOR_PRODUCAO, PRODUCAO_TAREFAS.RECURSO_PRODUTIVO, PRODUCAO_TAREFAS.INICIO_LIBERADO, PRODUCAO_TAREFAS.INICIO_PREVISTO, PRODUCAO_TAREFAS.INICIO_REAL, 
PRODUCAO_TAREFAS.FIM_PREVISTO, PRODUCAO_TAREFAS.FIM_ATUALIZADO, PRODUCAO_TAREFAS.ENCERRAMENTO, PRODUCAO_TAREFAS.TEMPO_PREPARACAO, PRODUCAO_TAREFAS.QTDE_PREVISTA, 
PRODUCAO_TAREFAS.QTDE_A_PRODUZIR, PRODUCAO_TAREFAS.QTDE_EM_PROCESSO, PRODUCAO_TAREFAS.QTDE_FINALIZADA, PRODUCAO_TAREFAS.QTDE_ALTERACAO_OP, PRODUCAO_TAREFAS.QTDE_PERDAS, 
PRODUCAO_TAREFAS.QTDE_ALT_OUTRAS_TAREFAS, PRODUCAO_TAREFAS.CUSTO_TAREFA, PRODUCAO_TAREFAS.DESCONTOS_TAREFA, PRODUCAO_TAREFAS.VALOR_TAREFA, PRODUCAO_TAREFAS.STATUS, 
PRODUCAO_TAREFAS.TIPO_TEMPO_PROCESSO, PRODUCAO_TAREFAS.METODO_LOTE, PRODUCAO_TAREFAS.METODO_LOTE_QTDE, PRODUCAO_TAREFAS.OBS, PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, 
PRODUCAO_RECURSOS.DESC_RECURSO, PRODUCAO_RECURSOS.TIPO_RECURSO, PRODUCAO_RECURSOS.RECURSO_PROPRIO, PRODUCAO_RECURSOS.RECURSO_INFINITO, PRODUCAO_FASE.DESC_FASE_PRODUCAO, PRODUCAO_TAREFAS.TIPO_TAREFA, PRODUCAO_TAREFAS.TEMPO_OPERACAO, PRODUCAO_TAREFAS.UNIDADE_TEMPO, PRODUCAO_TAREFAS.SEQUENCIA_ANTERIOR, SPACE(1) AS MARCA, PRODUCAO_TAREFAS.CONTROLE, PRODUCAO_TAREFAS.QTDE_SEGUNDA, CONVERT(NUMERIC(1,0),0) AS TEM_DIVISAO_RECURSO, PRODUCAO_TAREFAS.BAIXA_AUTOMATICA_MATERIAL, PRODUCAO_TAREFAS.PARTE_PRODUTO, CONVERT(NUMERIC(14,2),0) AS VALOR_TAREFA_PREVISTO, CONVERT(NUMERIC(14,5),0) AS CUSTO_EFETIVO, PRODUCAO_TAREFAS.TEMPO_CRONOMETRADO, PRODUCAO_TAREFAS.TEMPO_CRONOM_FIXO, PRODUCAO_TAREFAS.TEMPO_CRONOMETRADO_2, PRODUCAO_TAREFAS.TEMPO_CRONOMETRADO_3, PRODUCAO_TAREFAS.TEMPO_CRONOMETRADO_4, PRODUCAO_TAREFAS.SETOR_DIV_RECURSO, SPACE(10) AS COR_PRODUTO, PRODUCAO_TAREFAS.TIPO_CUSTO,CUSTO_MATERIAL_TERCEIRO  ,PRODUCAO_TAREFAS.QTDE_RETRABALHO,PRODUCAO_TAREFAS.ESTAGIO_OP, PRODUCAO_ESTAGIO.DESC_ESTAGIO_OP,  

CASE WHEN STATUS<3 AND DATEDIFF(DD,GETDATE(),PRODUCAO_TAREFAS.FIM_ATUALIZADO)<0 THEN-1* DATEDIFF(DD,GETDATE(),PRODUCAO_TAREFAS.FIM_ATUALIZADO) ELSE 0 END AS DIAS_ATRASO,CASE WHEN STATUS<3 THEN CONVERT(DATETIME ,CONVERT(CHAR(8),GETDATE(),112)) ELSE ENCERRAMENTO END AS FIM_REVISADO   FROM  PRODUCAO_TAREFAS  INNER JOIN PRODUCAO_RECURSOS ON (PRODUCAO_TAREFAS.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO )  INNER JOIN PRODUCAO_SETOR ON (PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND             PRODUCAO_TAREFAS.SETOR_PRODUCAO = PRODUCAO_SETOR.SETOR_PRODUCAO )  INNER JOIN PRODUCAO_FASE ON (PRODUCAO_TAREFAS.FASE_PRODUCAO = PRODUCAO_FASE.FASE_PRODUCAO  )  LEFT JOIN PRODUCAO_ESTAGIO ON  (PRODUCAO_TAREFAS.ESTAGIO_OP = PRODUCAO_ESTAGIO.ESTAGIO_OP)  WHERE PRODUCAO_TAREFAS.ORDEM_PRODUCAO =(@P1 )   ORDER BY PRODUCAO_TAREFAS.SEQUENCIA_PRODUTIVA, PRODUCAO_TAREFAS.SETOR_PARALELO_NUMERO, PRODUCAO_TAREFAS.SEQUENCIA_ANTERIOR, PRODUCAO_TAREFAS.TAREFA',N'@P1 varchar(5)','53683'

select DATEDIFF(DD,GETDATE(),PRODUCAO_TAREFAS.FIM_ATUALIZADO),FIM_ATUALIZADO from PRODUCAO_TAREFAS
where ORDEM_PRODUCAO='53683'



