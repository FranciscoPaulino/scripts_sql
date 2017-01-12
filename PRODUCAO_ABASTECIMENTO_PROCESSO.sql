--- PRODU��O DI�RIA FINALIZADA NOS GRUPOS
SELECT W_PRODUCAO_ORDEM_HIST_OS.DATA, W_PRODUCAO_ORDEM_HIST_OS.ORDEM_SERVICO, W_PRODUCAO_ORDEM_HIST_OS.TAREFA_ANTERIOR, 
W_PRODUCAO_ORDEM_HIST_OS.ORDEM_PRODUCAO, W_PRODUCAO_ORDEM_HIST_OS.PRODUTO, W_PRODUCAO_ORDEM_HIST_OS.COR_PRODUTO, 
W_PRODUCAO_ORDEM_HIST_OS.QTDE_A,W_PRODUCAO_ORDEM_HIST_OS.A1, W_PRODUCAO_ORDEM_HIST_OS.A2, W_PRODUCAO_ORDEM_HIST_OS.A3, 
W_PRODUCAO_ORDEM_HIST_OS.A4, W_PRODUCAO_ORDEM_HIST_OS.A5, W_PRODUCAO_ORDEM_HIST_OS.A6, W_PRODUCAO_ORDEM_HIST_OS.A7, 
W_PRODUCAO_ORDEM_HIST_OS.A8, W_PRODUCAO_ORDEM_HIST_OS.A9, W_PRODUCAO_ORDEM_HIST_OS.A10, W_PRODUCAO_ORDEM_HIST_OS.FASE_PRODUCAO, 
W_PRODUCAO_ORDEM_HIST_OS.SETOR_PRODUCAO, W_PRODUCAO_ORDEM_HIST_OS.RECURSO_PRODUTIVO, W_PRODUCAO_ORDEM_HIST_OS.DESC_FASE_PRODUCAO, 
W_PRODUCAO_ORDEM_HIST_OS.DESC_SETOR_PRODUCAO, W_PRODUCAO_ORDEM_HIST_OS.DESC_RECURSO, W_PRODUCAO_ORDEM_HIST_OS.TAREFA, 
W_PRODUCAO_ORDEM_HIST_OS.INDICADOR_TIPO_MOV, PRODUTOS_TAB_OPERACOES.TABELA_OPERACOES, PRODUTOS_TAB_OPERACOES.TEMPO_TOTAL
FROM dbo.PRODUTOS_TAB_OPERACOES PRODUTOS_TAB_OPERACOES, dbo.W_PRODUCAO_ORDEM_HIST_OS W_PRODUCAO_ORDEM_HIST_OS
WHERE PRODUTOS_TAB_OPERACOES.TABELA_OPERACOES = W_PRODUCAO_ORDEM_HIST_OS.PRODUTO 
AND ((W_PRODUCAO_ORDEM_HIST_OS.DATA>={ts '2012-01-01 00:00:00'}) 
AND (W_PRODUCAO_ORDEM_HIST_OS.DESC_SETOR_PRODUCAO Like 'OFICINA%') 
AND (W_PRODUCAO_ORDEM_HIST_OS.INDICADOR_TIPO_MOV=1)) AND ORDEM_PRODUCAO='52190' and ordem_servico='377135'


SELECT W_PRODUCAO_ORDEM_HIST_OS.DATA, W_PRODUCAO_ORDEM_HIST_OS.ORDEM_SERVICO, W_PRODUCAO_ORDEM_HIST_OS.TAREFA_ANTERIOR, 
W_PRODUCAO_ORDEM_HIST_OS.ORDEM_PRODUCAO, W_PRODUCAO_ORDEM_HIST_OS.PRODUTO, W_PRODUCAO_ORDEM_HIST_OS.COR_PRODUTO, 
W_PRODUCAO_ORDEM_HIST_OS.FASE_PRODUCAO, W_PRODUCAO_ORDEM_HIST_OS.SETOR_PRODUCAO, W_PRODUCAO_ORDEM_HIST_OS.RECURSO_PRODUTIVO, 
W_PRODUCAO_ORDEM_HIST_OS.DESC_FASE_PRODUCAO, W_PRODUCAO_ORDEM_HIST_OS.DESC_SETOR_PRODUCAO, W_PRODUCAO_ORDEM_HIST_OS.DESC_RECURSO, 
W_PRODUCAO_ORDEM_HIST_OS.TAREFA, W_PRODUCAO_ORDEM_HIST_OS.INDICADOR_TIPO_MOV, PRODUTOS_TAB_OPERACOES.TABELA_OPERACOES, PRODUTOS_TAB_OPERACOES.TEMPO_TOTAL,
PRODUTOS_BARRA.GRADE,PRODUTOS_BARRA.TAMANHO,
QTDE_A = (CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN W_PRODUCAO_ORDEM_HIST_OS.a1 
               WHEN PRODUTOS_BARRA.tamanho='2'  THEN W_PRODUCAO_ORDEM_HIST_OS.a2 
               WHEN PRODUTOS_BARRA.tamanho='3'  THEN W_PRODUCAO_ORDEM_HIST_OS.a3 
               WHEN PRODUTOS_BARRA.tamanho='4'  THEN W_PRODUCAO_ORDEM_HIST_OS.a4 
               WHEN PRODUTOS_BARRA.tamanho='5'  THEN W_PRODUCAO_ORDEM_HIST_OS.a5 
               WHEN PRODUTOS_BARRA.tamanho='6'  THEN W_PRODUCAO_ORDEM_HIST_OS.a6 
               WHEN PRODUTOS_BARRA.tamanho='7'  THEN W_PRODUCAO_ORDEM_HIST_OS.a7 
               WHEN PRODUTOS_BARRA.tamanho='8'  THEN W_PRODUCAO_ORDEM_HIST_OS.a8 
               WHEN PRODUTOS_BARRA.tamanho='9'  THEN W_PRODUCAO_ORDEM_HIST_OS.a9 
               WHEN PRODUTOS_BARRA.tamanho='10' THEN W_PRODUCAO_ORDEM_HIST_OS.a10 
               WHEN PRODUTOS_BARRA.tamanho='11' THEN W_PRODUCAO_ORDEM_HIST_OS.a11 
               WHEN PRODUTOS_BARRA.tamanho='12' THEN W_PRODUCAO_ORDEM_HIST_OS.a12 
               WHEN PRODUTOS_BARRA.tamanho='13' THEN W_PRODUCAO_ORDEM_HIST_OS.a13 
               WHEN PRODUTOS_BARRA.tamanho='14' THEN W_PRODUCAO_ORDEM_HIST_OS.a14 
               WHEN PRODUTOS_BARRA.tamanho='15' THEN W_PRODUCAO_ORDEM_HIST_OS.a15 
               WHEN PRODUTOS_BARRA.tamanho='16' THEN W_PRODUCAO_ORDEM_HIST_OS.a16 
           END)
FROM PRODUTOS_BARRA
join W_PRODUCAO_ORDEM_HIST_OS on W_PRODUCAO_ORDEM_HIST_OS.PRODUTO=PRODUTOS_BARRA.PRODUTO and
	 W_PRODUCAO_ORDEM_HIST_OS.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO
join PRODUTOS_TAB_OPERACOES on PRODUTOS_TAB_OPERACOES.TABELA_OPERACOES = W_PRODUCAO_ORDEM_HIST_OS.PRODUTO
  
WHERE PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' --AND ORDEM_PRODUCAO='52190' and ordem_servico='377135'
AND ((W_PRODUCAO_ORDEM_HIST_OS.DATA>={ts '2013-01-01 00:00:00'}) 
AND (W_PRODUCAO_ORDEM_HIST_OS.DESC_SETOR_PRODUCAO Like 'OFICINA%') 
AND (W_PRODUCAO_ORDEM_HIST_OS.INDICADOR_TIPO_MOV=1))

ORDER BY 1



--- BALANCEAMENTO DE GRUPOS
SELECT CAPACIDADE = CASE WHEN ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0)<>0 
                         THEN ((ISNULL(OPERADORES.QTDE_OPERADOR,0)*ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0))/ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0)) 
                         WHEN ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0)=0 
                         THEN 0 
                    END,
DIAS_PRODUCAO = CASE WHEN ISNULL(OPERADORES.QTDE_OPERADOR,0)*ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0) <> 0 AND ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0) <> 0
                     THEN ISNULL((RECEBIMENTO.QTDE_S/((ISNULL(OPERADORES.QTDE_OPERADOR,0)*ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0))/ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0))),0)
                     WHEN ISNULL(OPERADORES.QTDE_OPERADOR,0)*ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0) = 0 AND ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0) = 0
                     THEN 0
                     ELSE 0
                END,
QTDE_OPERADOR=ISNULL(OPERADORES.QTDE_OPERADOR,0),MINUTOS_DISPONIVEIS=ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0),TEMPO_CRONOMETRADO=ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0),
RECEBIMENTO.PRODUTO,RECEBIMENTO.COR_PRODUTO,RECEBIMENTO.ORDEM_PRODUCAO,
RECEBIMENTO.RECURSO_PRODUTIVO,RECEBIMENTO.DESC_SETOR_PRODUCAO,GRUPO=COSTURA.RECURSO_PRODUTIVO,RECEBIMENTO.QTDE_S,RECEBIMENTO.GRADE,RECEBIMENTO.TAMANHO 
FROM (

SELECT  PRODUCAO_TAREFAS.QTDE_EM_PROCESSO, PRODUCAO_TAREFAS_SALDO.TAREFA, PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO, 
PRODUCAO_TAREFAS_SALDO.PRODUTO, PRODUCAO_TAREFAS_SALDO.COR_PRODUTO,  
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO, PRODUCAO_RECURSOS.DESC_RECURSO, PRODUTOS.DESC_PRODUTO, PRODUTOS.GRUPO_PRODUTO, 
PRODUTOS.SUBGRUPO_PRODUTO, PRODUTOS.COLECAO, PRODUTOS.LINHA, PRODUTOS.GRIFFE, PRODUCAO_SETOR.SETOR_PRODUCAO, 
PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, PRODUCAO_FASE.FASE_PRODUCAO, PRODUCAO_FASE.DESC_FASE_PRODUCAO,
PRODUTOS_BARRA.GRADE,PRODUTOS_BARRA.TAMANHO,
QTDE_S = (CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN PRODUCAO_TAREFAS_SALDO.S1 
               WHEN PRODUTOS_BARRA.tamanho='2'  THEN PRODUCAO_TAREFAS_SALDO.S2 
               WHEN PRODUTOS_BARRA.tamanho='3'  THEN PRODUCAO_TAREFAS_SALDO.S3 
               WHEN PRODUTOS_BARRA.tamanho='4'  THEN PRODUCAO_TAREFAS_SALDO.S4 
               WHEN PRODUTOS_BARRA.tamanho='5'  THEN PRODUCAO_TAREFAS_SALDO.S5 
               WHEN PRODUTOS_BARRA.tamanho='6'  THEN PRODUCAO_TAREFAS_SALDO.S6 
               WHEN PRODUTOS_BARRA.tamanho='7'  THEN PRODUCAO_TAREFAS_SALDO.S7 
               WHEN PRODUTOS_BARRA.tamanho='8'  THEN PRODUCAO_TAREFAS_SALDO.S8 
               WHEN PRODUTOS_BARRA.tamanho='9'  THEN PRODUCAO_TAREFAS_SALDO.S9 
               WHEN PRODUTOS_BARRA.tamanho='10' THEN PRODUCAO_TAREFAS_SALDO.S10 
               WHEN PRODUTOS_BARRA.tamanho='11' THEN PRODUCAO_TAREFAS_SALDO.S11 
               WHEN PRODUTOS_BARRA.tamanho='12' THEN PRODUCAO_TAREFAS_SALDO.S12 
               WHEN PRODUTOS_BARRA.tamanho='13' THEN PRODUCAO_TAREFAS_SALDO.S13 
               WHEN PRODUTOS_BARRA.tamanho='14' THEN PRODUCAO_TAREFAS_SALDO.S14 
               WHEN PRODUTOS_BARRA.tamanho='15' THEN PRODUCAO_TAREFAS_SALDO.S15 
               WHEN PRODUTOS_BARRA.tamanho='16' THEN PRODUCAO_TAREFAS_SALDO.S16 
           END)
           
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE, dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, dbo.PRODUCAO_SETOR PRODUCAO_SETOR, dbo.PRODUCAO_TAREFAS PRODUCAO_TAREFAS, dbo.PRODUCAO_TAREFAS_SALDO PRODUCAO_TAREFAS_SALDO, dbo.PRODUTOS PRODUTOS, DBO.PRODUTOS_BARRA PRODUTOS_BARRA
WHERE PRODUCAO_TAREFAS_SALDO.PRODUTO=PRODUTOS_BARRA.PRODUTO AND 
PRODUCAO_TAREFAS_SALDO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = PRODUCAO_TAREFAS.RECURSO_PRODUTIVO AND 
PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO AND 
PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_TAREFAS.TAREFA = PRODUCAO_TAREFAS_SALDO.TAREFA AND 
PRODUCAO_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO AND 
PRODUCAO_TAREFAS_SALDO.PRODUTO = PRODUTOS.PRODUTO AND PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' AND 
PRODUCAO_FASE.FASE_PRODUCAO IN('001','002','003','004','005','006','007') --AND PRODUCAO_TAREFAS.ORDEM_PRODUCAO='56059'

) AS RECEBIMENTO

LEFT JOIN (
 
SELECT PRODUTOS.PRODUTO,PRODUCAO_TAREFAS.ORDEM_PRODUCAO,PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,PRODUCAO_RECURSOS.DESC_RECURSO,PRODUCAO_SETOR.DESC_SETOR_PRODUCAO
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE, dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, dbo.PRODUCAO_SETOR PRODUCAO_SETOR, dbo.PRODUCAO_TAREFAS PRODUCAO_TAREFAS, dbo.PRODUTOS PRODUTOS, dbo.PRODUCAO_ORDEM
WHERE PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = PRODUCAO_TAREFAS.RECURSO_PRODUTIVO AND 
PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO AND 
PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_ORDEM.PRODUTO=PRODUTOS.PRODUTO AND
PRODUCAO_ORDEM.ORDEM_PRODUCAO=PRODUCAO_TAREFAS.ORDEM_PRODUCAO AND
PRODUCAO_FASE.FASE_PRODUCAO='007' --AND PRODUCAO_TAREFAS.ORDEM_PRODUCAO='56059'

 ) AS COSTURA

ON RECEBIMENTO.PRODUTO=COSTURA.PRODUTO AND RECEBIMENTO.ORDEM_PRODUCAO=COSTURA.ORDEM_PRODUCAO

LEFT JOIN (SELECT PRODUTO_OPERACOES_ROTAS.TABELA_OPERACOES,SUM(TEMPO_CRONOMETRADO) AS TEMPO_CRONOMETRADO FROM PRODUTO_OPERACOES_ROTAS WHERE TEMPO_CRONOMETRADO>0 GROUP BY TABELA_OPERACOES) AS TEMPO_PADRAO
ON TEMPO_PADRAO.TABELA_OPERACOES=RECEBIMENTO.PRODUTO

LEFT JOIN (SELECT * FROM LDR_METAS_OFICINA_GRUPO_NOVA WHERE DESC_RECURSO like 'GRUPO%' AND CONVERT(CHAR(10),DATA_PRODUCAO,103) = CONVERT(CHAR(10),GETDATE(),103)) AS OPERADORES
ON OPERADORES.DESC_RECURSO=COSTURA.DESC_RECURSO AND OPERADORES.DESC_SETOR_PRODUCAO=COSTURA.DESC_SETOR_PRODUCAO

WHERE RECEBIMENTO.QTDE_S>0
ORDER BY RECEBIMENTO.ORDEM_PRODUCAO




--- ABASTECIMENTO
SELECT PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO, PRODUCAO_ORDEM_SERVICO.RECURSO_PRODUTIVO, PRODUCAO_ORDEM_SERVICO.FASE_PRODUCAO, PRODUCAO_ORDEM_SERVICO.SETOR_PRODUCAO, PRODUCAO_ORDEM_SERVICO.DATA, PRODUCAO_ORDEM_SERVICO.CONFERIDO_POR, PRODUCAO_ORDEM_SERVICO.INDICADOR_TIPO_MOV, PRODUCAO_OS_TAREFAS.TAREFA, PRODUCAO_OS_TAREFAS.ORDEM_SERVICO, PRODUCAO_OS_TAREFAS.ORDEM_PRODUCAO, PRODUCAO_OS_TAREFAS.PRODUTO, PRODUCAO_OS_TAREFAS.COR_PRODUTO, PRODUCAO_OS_TAREFAS.QTDE_O, PRODUCAO_OS_TAREFAS.O1, PRODUCAO_OS_TAREFAS.O2, PRODUCAO_OS_TAREFAS.O3, PRODUCAO_OS_TAREFAS.O4, PRODUCAO_OS_TAREFAS.O5, PRODUCAO_OS_TAREFAS.O6, PRODUCAO_OS_TAREFAS.O7, PRODUCAO_OS_TAREFAS.O8, PRODUCAO_OS_TAREFAS.O9, PRODUCAO_OS_TAREFAS.O10, PRODUCAO_OS_TAREFAS.O11, PRODUCAO_OS_TAREFAS.O12, PRODUCAO_FASE.FASE_PRODUCAO, PRODUCAO_FASE.DESC_FASE_PRODUCAO, PRODUCAO_SETOR.SETOR_PRODUCAO, PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, PRODUCAO_RECURSOS.RECURSO_PRODUTIVO, PRODUCAO_RECURSOS.DESC_RECURSO
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE, dbo.PRODUCAO_ORDEM_SERVICO PRODUCAO_ORDEM_SERVICO, dbo.PRODUCAO_OS_TAREFAS PRODUCAO_OS_TAREFAS, dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, dbo.PRODUCAO_SETOR PRODUCAO_SETOR
WHERE PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_ORDEM_SERVICO.FASE_PRODUCAO AND 
PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO = PRODUCAO_OS_TAREFAS.ORDEM_SERVICO AND 
PRODUCAO_ORDEM_SERVICO.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO AND 
PRODUCAO_ORDEM_SERVICO.SETOR_PRODUCAO = PRODUCAO_SETOR.SETOR_PRODUCAO AND 
((PRODUCAO_FASE.FASE_PRODUCAO='007') AND (PRODUCAO_ORDEM_SERVICO.DATA>={ts '2013-01-01 00:00:00'}) AND 
(PRODUCAO_SETOR.DESC_SETOR_PRODUCAO Like 'OFICINA%') AND 
(PRODUCAO_ORDEM_SERVICO.DATA>={ts '2013-01-01 00:00:00'}) AND (PRODUCAO_SETOR.DESC_SETOR_PRODUCAO Like 'OFICINA%'))


SELECT PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO, PRODUCAO_ORDEM_SERVICO.RECURSO_PRODUTIVO, 
PRODUCAO_ORDEM_SERVICO.FASE_PRODUCAO, PRODUCAO_ORDEM_SERVICO.SETOR_PRODUCAO, PRODUCAO_ORDEM_SERVICO.DATA, 
PRODUCAO_ORDEM_SERVICO.CONFERIDO_POR, PRODUCAO_ORDEM_SERVICO.INDICADOR_TIPO_MOV, PRODUCAO_OS_TAREFAS.TAREFA, 
PRODUCAO_OS_TAREFAS.ORDEM_SERVICO, PRODUCAO_OS_TAREFAS.ORDEM_PRODUCAO, PRODUCAO_OS_TAREFAS.PRODUTO, 
PRODUCAO_OS_TAREFAS.COR_PRODUTO, PRODUCAO_FASE.FASE_PRODUCAO, PRODUCAO_FASE.DESC_FASE_PRODUCAO, 
PRODUCAO_SETOR.SETOR_PRODUCAO, PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, PRODUCAO_RECURSOS.RECURSO_PRODUTIVO, 
PRODUCAO_RECURSOS.DESC_RECURSO,PRODUTOS_BARRA.GRADE,PRODUTOS_BARRA.TAMANHO,
QTDE_O = (CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN PRODUCAO_OS_TAREFAS.O1 
               WHEN PRODUTOS_BARRA.tamanho='2'  THEN PRODUCAO_OS_TAREFAS.O2
               WHEN PRODUTOS_BARRA.tamanho='3'  THEN PRODUCAO_OS_TAREFAS.O3
               WHEN PRODUTOS_BARRA.tamanho='4'  THEN PRODUCAO_OS_TAREFAS.O4
               WHEN PRODUTOS_BARRA.tamanho='5'  THEN PRODUCAO_OS_TAREFAS.O5
               WHEN PRODUTOS_BARRA.tamanho='6'  THEN PRODUCAO_OS_TAREFAS.O6
               WHEN PRODUTOS_BARRA.tamanho='7'  THEN PRODUCAO_OS_TAREFAS.O7
               WHEN PRODUTOS_BARRA.tamanho='8'  THEN PRODUCAO_OS_TAREFAS.O8
               WHEN PRODUTOS_BARRA.tamanho='9'  THEN PRODUCAO_OS_TAREFAS.O9
               WHEN PRODUTOS_BARRA.tamanho='10' THEN PRODUCAO_OS_TAREFAS.O10
               WHEN PRODUTOS_BARRA.tamanho='11' THEN PRODUCAO_OS_TAREFAS.O11
               WHEN PRODUTOS_BARRA.tamanho='12' THEN PRODUCAO_OS_TAREFAS.O12
               WHEN PRODUTOS_BARRA.tamanho='13' THEN PRODUCAO_OS_TAREFAS.O13
               WHEN PRODUTOS_BARRA.tamanho='14' THEN PRODUCAO_OS_TAREFAS.O14
               WHEN PRODUTOS_BARRA.tamanho='15' THEN PRODUCAO_OS_TAREFAS.O15
               WHEN PRODUTOS_BARRA.tamanho='16' THEN PRODUCAO_OS_TAREFAS.O16
           END)
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE, dbo.PRODUCAO_ORDEM_SERVICO PRODUCAO_ORDEM_SERVICO, 
dbo.PRODUCAO_OS_TAREFAS PRODUCAO_OS_TAREFAS, dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, 
dbo.PRODUCAO_SETOR PRODUCAO_SETOR, DBO.PRODUTOS_BARRA PRODUTOS_BARRA
WHERE PRODUCAO_OS_TAREFAS.PRODUTO=PRODUTOS_BARRA.PRODUTO AND 
PRODUCAO_OS_TAREFAS.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO AND
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_ORDEM_SERVICO.FASE_PRODUCAO AND 
PRODUCAO_ORDEM_SERVICO.ORDEM_SERVICO = PRODUCAO_OS_TAREFAS.ORDEM_SERVICO AND 
PRODUCAO_ORDEM_SERVICO.RECURSO_PRODUTIVO = PRODUCAO_RECURSOS.RECURSO_PRODUTIVO AND 
PRODUCAO_ORDEM_SERVICO.SETOR_PRODUCAO = PRODUCAO_SETOR.SETOR_PRODUCAO AND 
((PRODUCAO_FASE.FASE_PRODUCAO='007') AND (PRODUCAO_ORDEM_SERVICO.DATA>={ts '2013-01-01 00:00:00'}) AND 
(PRODUCAO_SETOR.DESC_SETOR_PRODUCAO Like 'OFICINA%') AND 
(PRODUCAO_ORDEM_SERVICO.DATA>={ts '2013-01-01 00:00:00'}) AND (PRODUCAO_SETOR.DESC_SETOR_PRODUCAO Like 'OFICINA%')) AND
PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' 



------- balanceamento de grupos

SELECT CAPACIDADE = CASE WHEN ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0)<>0 
                         THEN ((ISNULL(OPERADORES.QTDE_OPERADOR,0)*ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0))/ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0)) 
                         WHEN ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0)=0 
                         THEN 0 
                    END,
DIAS_PRODUCAO = CASE WHEN ISNULL(OPERADORES.QTDE_OPERADOR,0)*ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0) <> 0 AND ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0) <> 0
                     THEN ISNULL((RECEBIMENTO.QTDE_S/((ISNULL(OPERADORES.QTDE_OPERADOR,0)*ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0))/ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0))),0)
                     WHEN ISNULL(OPERADORES.QTDE_OPERADOR,0)*ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0) = 0 AND ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0) = 0
                     THEN 0
                     ELSE 0
                END,
QTDE_OPERADOR=ISNULL(OPERADORES.QTDE_OPERADOR,0),MINUTOS_DISPONIVEIS=ISNULL(OPERADORES.MINUTOS_DISPONIVEIS,0),TEMPO_CRONOMETRADO=ISNULL(TEMPO_PADRAO.TEMPO_CRONOMETRADO,0),
RECEBIMENTO.PRODUTO,RECEBIMENTO.COR_PRODUTO,RECEBIMENTO.ORDEM_PRODUCAO,
RECEBIMENTO.RECURSO_PRODUTIVO,RECEBIMENTO.DESC_SETOR_PRODUCAO,GRUPO=COSTURA.RECURSO_PRODUTIVO,RECEBIMENTO.QTDE_S,RECEBIMENTO.GRADE,RECEBIMENTO.TAMANHO 
FROM (

SELECT  PRODUCAO_TAREFAS.QTDE_EM_PROCESSO, PRODUCAO_TAREFAS_SALDO.TAREFA, PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO, 
PRODUCAO_TAREFAS_SALDO.PRODUTO, PRODUCAO_TAREFAS_SALDO.COR_PRODUTO,  
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO, PRODUCAO_RECURSOS.DESC_RECURSO, PRODUTOS.DESC_PRODUTO, PRODUTOS.GRUPO_PRODUTO, 
PRODUTOS.SUBGRUPO_PRODUTO, PRODUTOS.COLECAO, PRODUTOS.LINHA, PRODUTOS.GRIFFE, PRODUCAO_SETOR.SETOR_PRODUCAO, 
PRODUCAO_SETOR.DESC_SETOR_PRODUCAO, PRODUCAO_FASE.FASE_PRODUCAO, PRODUCAO_FASE.DESC_FASE_PRODUCAO,
PRODUTOS_BARRA.GRADE,PRODUTOS_BARRA.TAMANHO,
QTDE_S = (CASE WHEN PRODUTOS_BARRA.tamanho='1'  THEN PRODUCAO_TAREFAS_SALDO.S1 
               WHEN PRODUTOS_BARRA.tamanho='2'  THEN PRODUCAO_TAREFAS_SALDO.S2 
               WHEN PRODUTOS_BARRA.tamanho='3'  THEN PRODUCAO_TAREFAS_SALDO.S3 
               WHEN PRODUTOS_BARRA.tamanho='4'  THEN PRODUCAO_TAREFAS_SALDO.S4 
               WHEN PRODUTOS_BARRA.tamanho='5'  THEN PRODUCAO_TAREFAS_SALDO.S5 
               WHEN PRODUTOS_BARRA.tamanho='6'  THEN PRODUCAO_TAREFAS_SALDO.S6 
               WHEN PRODUTOS_BARRA.tamanho='7'  THEN PRODUCAO_TAREFAS_SALDO.S7 
               WHEN PRODUTOS_BARRA.tamanho='8'  THEN PRODUCAO_TAREFAS_SALDO.S8 
               WHEN PRODUTOS_BARRA.tamanho='9'  THEN PRODUCAO_TAREFAS_SALDO.S9 
               WHEN PRODUTOS_BARRA.tamanho='10' THEN PRODUCAO_TAREFAS_SALDO.S10 
               WHEN PRODUTOS_BARRA.tamanho='11' THEN PRODUCAO_TAREFAS_SALDO.S11 
               WHEN PRODUTOS_BARRA.tamanho='12' THEN PRODUCAO_TAREFAS_SALDO.S12 
               WHEN PRODUTOS_BARRA.tamanho='13' THEN PRODUCAO_TAREFAS_SALDO.S13 
               WHEN PRODUTOS_BARRA.tamanho='14' THEN PRODUCAO_TAREFAS_SALDO.S14 
               WHEN PRODUTOS_BARRA.tamanho='15' THEN PRODUCAO_TAREFAS_SALDO.S15 
               WHEN PRODUTOS_BARRA.tamanho='16' THEN PRODUCAO_TAREFAS_SALDO.S16 
           END)
           
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE, dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, dbo.PRODUCAO_SETOR PRODUCAO_SETOR, dbo.PRODUCAO_TAREFAS PRODUCAO_TAREFAS, dbo.PRODUCAO_TAREFAS_SALDO PRODUCAO_TAREFAS_SALDO, dbo.PRODUTOS PRODUTOS, DBO.PRODUTOS_BARRA PRODUTOS_BARRA
WHERE PRODUCAO_TAREFAS_SALDO.PRODUTO=PRODUTOS_BARRA.PRODUTO AND 
PRODUCAO_TAREFAS_SALDO.COR_PRODUTO=PRODUTOS_BARRA.COR_PRODUTO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = PRODUCAO_TAREFAS.RECURSO_PRODUTIVO AND 
PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO AND 
PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_TAREFAS.TAREFA = PRODUCAO_TAREFAS_SALDO.TAREFA AND 
PRODUCAO_TAREFAS.ORDEM_PRODUCAO = PRODUCAO_TAREFAS_SALDO.ORDEM_PRODUCAO AND 
PRODUCAO_TAREFAS_SALDO.PRODUTO = PRODUTOS.PRODUTO AND PRODUTOS_BARRA.CODIGO_BARRA LIKE '789%' AND 
PRODUCAO_FASE.FASE_PRODUCAO IN('001','002','003','004','005','006','007') --AND PRODUCAO_TAREFAS.ORDEM_PRODUCAO='56059'

) AS RECEBIMENTO

LEFT JOIN (
 
SELECT PRODUTOS.PRODUTO,PRODUCAO_TAREFAS.ORDEM_PRODUCAO,PRODUCAO_TAREFAS.RECURSO_PRODUTIVO,PRODUCAO_RECURSOS.DESC_RECURSO,PRODUCAO_SETOR.DESC_SETOR_PRODUCAO
FROM dbo.PRODUCAO_FASE PRODUCAO_FASE, dbo.PRODUCAO_RECURSOS PRODUCAO_RECURSOS, dbo.PRODUCAO_SETOR PRODUCAO_SETOR, dbo.PRODUCAO_TAREFAS PRODUCAO_TAREFAS, dbo.PRODUTOS PRODUTOS, dbo.PRODUCAO_ORDEM
WHERE PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_FASE.FASE_PRODUCAO = PRODUCAO_SETOR.FASE_PRODUCAO AND 
PRODUCAO_RECURSOS.RECURSO_PRODUTIVO = PRODUCAO_TAREFAS.RECURSO_PRODUTIVO AND 
PRODUCAO_SETOR.SETOR_PRODUCAO = PRODUCAO_TAREFAS.SETOR_PRODUCAO AND 
PRODUCAO_SETOR.FASE_PRODUCAO = PRODUCAO_TAREFAS.FASE_PRODUCAO AND 
PRODUCAO_ORDEM.PRODUTO=PRODUTOS.PRODUTO AND
PRODUCAO_ORDEM.ORDEM_PRODUCAO=PRODUCAO_TAREFAS.ORDEM_PRODUCAO AND
PRODUCAO_FASE.FASE_PRODUCAO='007' --AND PRODUCAO_TAREFAS.ORDEM_PRODUCAO='56059'

 ) AS COSTURA

ON RECEBIMENTO.PRODUTO=COSTURA.PRODUTO AND RECEBIMENTO.ORDEM_PRODUCAO=COSTURA.ORDEM_PRODUCAO

LEFT JOIN (SELECT PRODUTO_OPERACOES_ROTAS.TABELA_OPERACOES,SUM(TEMPO_CRONOMETRADO) AS TEMPO_CRONOMETRADO FROM PRODUTO_OPERACOES_ROTAS WHERE TEMPO_CRONOMETRADO>0 GROUP BY TABELA_OPERACOES) AS TEMPO_PADRAO
ON TEMPO_PADRAO.TABELA_OPERACOES=RECEBIMENTO.PRODUTO

LEFT JOIN (SELECT * FROM LDR_METAS_OFICINA_GRUPO_NOVA WHERE DESC_RECURSO like 'GRUPO%' AND CONVERT(CHAR(10),DATA_PRODUCAO,103) = CONVERT(CHAR(10),GETDATE(),103)) AS OPERADORES
ON OPERADORES.DESC_RECURSO=COSTURA.DESC_RECURSO AND OPERADORES.DESC_SETOR_PRODUCAO=COSTURA.DESC_SETOR_PRODUCAO

WHERE RECEBIMENTO.QTDE_S>0
ORDER BY RECEBIMENTO.ORDEM_PRODUCAO

-------

exec LX_VERIFICA_OP '46083','46083'

exec LX_RECALCULO_OP   '46083','46083'