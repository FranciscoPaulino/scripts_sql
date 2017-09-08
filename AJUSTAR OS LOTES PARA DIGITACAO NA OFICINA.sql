-- PESQUISAR OS LOTES DA OP
SELECT STR(NUMERO_LOTE,10)+',' FROM PRODUCAO_ORDEM_LOTES
WHERE ORDEM_PRODUCAO='174941'


-- APAGAR AS MOVIMENTAÇÕES DA OP POR LOTES
DELETE FROM PRODUCAO_OS_LOTES 
WHERE NUMERO_LOTE IN (SELECT NUMERO_LOTE FROM PRODUCAO_ORDEM_LOTES 
WHERE ORDEM_PRODUCAO='235679')


DELETE FROM PRODUCAO_OS_LOTES 
WHERE NUMERO_LOTE IN (
SELECT NUMERO_LOTE FROM PRODUCAO_ORDEM_LOTES
JOIN PRODUCAO_ORDEM ON PRODUCAO_ORDEM.ORDEM_PRODUCAO=PRODUCAO_ORDEM_LOTES.ORDEM_PRODUCAO 
WHERE PRODUCAO_ORDEM.FILIAL='DR VAREJO'
)


select * from PRODUCAO_ORDEM_LOTES

select * FROM PRODUCAO_OS_LOTES WHERE TAREFA=479416   AND NUMERO_LOTE 
not in (SELECT NUMERO_LOTE FROM PRODUCAO_OS_LOTES WHERE TAREFA=472363)

select * FROM PRODUCAO_ORDEM_LOTES WHERE NUMERO_LOTE='81072' --ORDEM_PRODUCAO='80976'

INSERT INTO PRODUCAO_OS_LOTES (ORDEM_SERVICO,NUMERO_LOTE,TAREFA,LOTE_EM_RETRABALHO,RETRABALHO_NO_LOTE)
SELECT '555973',NUMERO_LOTE,'472362','0','0' FROM PRODUCAO_ORDEM_LOTES
WHERE ORDEM_PRODUCAO='81026' AND NUMERO_LOTE 
not in (SELECT NUMERO_LOTE FROM PRODUCAO_OS_LOTES WHERE TAREFA=485706)


SELECT * FROM PRODUCAO_TAREFAS_SALDO
WHERE ORDEM_PRODUCAO='77803'

SELECT * FROM PRODUCAO_TAREFAS_SALDO
WHERE TAREFA=482184 AND ORDEM_PRODUCAO='77968'


SELECT * FROM PRODUCAO_TAREFAS
WHERE TAREFA='1857852'


UPDATE PRODUCAO_TAREFAS
SET QTDE_a_produzir=420
WHERE TAREFA='1960086'



UPDATE PRODUCAO_TAREFAS_SALDO
SET QTDE_S=210,S1=0,S2=90,S3=60,S4=60
WHERE ORDEM_PRODUCAO='77803'


UPDATE PRODUCAO_TAREFAS_SALDO
SET QTDE_S=150,S4=180,S5=420,S6=480,S7=270,S8=240
WHERE TAREFA=482184 AND ORDEM_PRODUCAO='82513'

UPDATE PRODUCAO_TAREFAS_SALDO
SET QTDE_S=330,S3=60,S4=120,S5=120,S6=60,S7=0,S8=0
WHERE TAREFA=469007 AND ORDEM_PRODUCAO='81000'


EXEC SP_PROCURA_LOTE_MOVIMENTADO '176233','006.1'

EXEC SP_PROCURA_LOTE_MOVIMENTADO '183811','008'

SELECT * From VENDAS_CANCELAMENTO
ORDER BY NUM_CANCELAMENTO DESC


WHERE NUM_CANCELAMENTO=''

UPDATE PRODUCAO_TAREFAS
SET QTDE_FINALIZADA=QTDE_EM_PROCESSO, QTDE_EM_PROCESSO=0
FROM PRODUCAO_TAREFAS
WHERE RECURSO_PRODUTIVO='001' AND INICIO_REAL IS NOT NULL AND  ORDEM_PRODUCAO IN(
'225421',
'225734',
'222426',
'222427',
'224738',
'225704',
'224731',
'225735',
'224736',
'225706',
'224739',
'224665',
'224734',
'224732',
'224733',
'224620',
'224735',
'224632',
'224778',
'224643',
'224737')

