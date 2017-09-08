EXEC LX_RECALCULO_OP '175311','175311'
EXEC LX_VERIFICA_OP '175311','175311',1
EXEC LX_ZERA_OP '85439','N'


EXEC LX_RECALCULO_OP '226694','226694'
EXEC LX_RECALCULO_OP '223003','223003'
EXEC LX_RECALCULO_OP '221941','221941'



UPDATE PRODUCAO_TAREFAS
SET QTDE_FINALIZADA=QTDE_EM_PROCESSO, QTDE_EM_PROCESSO=0
FROM PRODUCAO_TAREFAS
WHERE RECURSO_PRODUTIVO='001' AND INICIO_REAL IS NOT NULL AND  ORDEM_PRODUCAO IN(
'224736',
'225706',
'224733',
'224731',
'225735',
'224665',
'224734',
'224632',
'224778',
'224620',
'224739',
'224732',
'222426',
'224735',
'225421',
'225734',
'222427',
'224738',
'225704',
'224643',
'224737')


---- APAGAR MOVIMENTAÇÃO EM DUPLICIDADE EM PRODUCAO_TAREFAS_SALDO
DELETE FROM PRODUCAO_TAREFAS_SALDO
WHERE TAREFA IN (
SELECT TAREFA FROM PRODUCAO_TAREFAS_SALDO PTS
WHERE PTS.ORDEM_PRODUCAO IN (
'227624',
'227623',
'223003',
'221941',
'227621',
'230588',
'226694'
) 
AND NOT EXISTS(
select b.tarefa, b.qtde_em_processo, a.produto, a.cor_produto 
from producao_ordem_cor a left join producao_tarefas b on a.ordem_producao = b.ordem_producao
where b.qtde_em_processo>0 and a.ordem_producao = PTS.ORDEM_PRODUCAO AND B.TAREFA=PTS.TAREFA)
)			


--- ops com fase zero e nada para processar ou a produzir
DELETE FROM PRODUCAO_TAREFAS_SALDO
WHERE TAREFA IN (
SELECT TAREFA FROM PRODUCAO_TAREFAS_SALDO PTS
WHERE PTS.ORDEM_PRODUCAO IN (
'197898',
'208027',
'210118',
'210119',
'217399',
'225352',
'225766',
'227710',
'225333',
'227487',
'227487') 
AND EXISTS(
select b.tarefa, b.qtde_em_processo, a.produto, a.cor_produto 
from producao_ordem_cor a left join producao_tarefas b on a.ordem_producao = b.ordem_producao
where b.qtde_em_processo=0 and b.qtde_a_produzir =0 and a.ordem_producao = PTS.ORDEM_PRODUCAO AND B.TAREFA=PTS.TAREFA)
)			

SELECT ''''+RTRIM(ORDEM_PRODUCAO)+''','  
FROM PRODUCAO_TAREFAS_SALDO
WHERE TAREFA IN (
SELECT TAREFA FROM PRODUCAO_TAREFAS_SALDO PTS
WHERE EXISTS(
select b.tarefa, b.qtde_em_processo, a.produto, a.cor_produto 
from producao_ordem_cor a left join producao_tarefas b on a.ordem_producao = b.ordem_producao
where b.qtde_em_processo=0 and b.qtde_a_produzir = 0 and a.ordem_producao = PTS.ORDEM_PRODUCAO AND B.TAREFA=PTS.TAREFA)
)			




SELECT ''''+RTRIM(A.ORDEM_PRODUCAO)+''',' 
FROM PRODUCAO_TAREFAS_SALDO A with (nolock)
JOIN PRODUCAO_ORDEM B with (nolock) ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO
--WHERE B.FILIAL='DR VAREJO'
GROUP BY A.ORDEM_PRODUCAO,B.QTDE_EM_PRODUCAO
HAVING SUM(A.QTDE_S) > B.QTDE_EM_PRODUCAO


SELECT 'EXEC LX_RECALCULO_OP '''+RTRIM(A.ORDEM_PRODUCAO)+''','''+RTRIM(A.ORDEM_PRODUCAO)+'''',SUM(A.QTDE_S) 
FROM PRODUCAO_TAREFAS_SALDO A with (nolock)
JOIN PRODUCAO_ORDEM B with (nolock) ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO
--WHERE B.FILIAL='DR VAREJO'
GROUP BY A.ORDEM_PRODUCAO,B.QTDE_EM_PRODUCAO
HAVING SUM(A.QTDE_S) > B.QTDE_EM_PRODUCAO


SELECT 'EXEC LX_RECALCULO_OP '''+RTRIM(A.ORDEM_PRODUCAO)+''','''+RTRIM(A.ORDEM_PRODUCAO)+'''',SUM(A.QTDE_S) FROM PRODUCAO_TAREFAS_SALDO A with (nolock)
JOIN PRODUCAO_ORDEM B with (nolock) ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO
--WHERE B.FILIAL='DR VAREJO'
GROUP BY A.ORDEM_PRODUCAO,B.QTDE_EM_PRODUCAO
HAVING SUM(A.QTDE_S) < B.QTDE_EM_PRODUCAO


select * from PRODUCAO_TAREFAS_SALDO
where produto='7200' and cor_produto='012'


INSERT INTO [dbo].[PRODUCAO_TAREFAS_SALDO]
           ([TAREFA]
           ,[ORDEM_PRODUCAO]
           ,[PRODUTO]
           ,[COR_PRODUTO]
           ,[QTDE_S]
           ,[S1]
           ,[S2]
           ,[S3]
           ,[S4]
           ,[S5]
           ,[S6]
           ,[S7]
           ,[S8]
           ,[S9]
           ,[S10]
           ,[S11]
           ,[S12]
           ,[S13]
           ,[S14]
           ,[S15]
           ,[S16]
           ,[S17]
           ,[S18]
           ,[S19]
           ,[S20]
           ,[S21]
           ,[S22]
           ,[S23]
           ,[S24]
           ,[S25]
           ,[S26]
           ,[S27]
           ,[S28]
           ,[S29]
           ,[S30]
           ,[S31]
           ,[S32]
           ,[S33]
           ,[S34]
           ,[S35]
           ,[S36]
           ,[S37]
           ,[S38]
           ,[S39]
           ,[S40]
           ,[S41]
           ,[S42]
           ,[S43]
           ,[S44]
           ,[S45]
           ,[S46]
           ,[S47]
           ,[S48]
           ,[ULTIMO_CUSTO_PREVISTO])
select     '1376079'
           ,'175311'
           ,'7200'
           ,'012'
           ,1
           ,1
           ,0
           ,0
           ,0
           ,0
           ,[S6]
           ,[S7]
           ,[S8]
           ,[S9]
           ,[S10]
           ,[S11]
           ,[S12]
           ,[S13]
           ,[S14]
           ,[S15]
           ,[S16]
           ,[S17]
           ,[S18]
           ,[S19]
           ,[S20]
           ,[S21]
           ,[S22]
           ,[S23]
           ,[S24]
           ,[S25]
           ,[S26]
           ,[S27]
           ,[S28]
           ,[S29]
           ,[S30]
           ,[S31]
           ,[S32]
           ,[S33]
           ,[S34]
           ,[S35]
           ,[S36]
           ,[S37]
           ,[S38]
           ,[S39]
           ,[S40]
           ,[S41]
           ,[S42]
           ,[S43]
           ,[S44]
           ,[S45]
           ,[S46]
           ,[S47]
           ,[S48]
           ,[ULTIMO_CUSTO_PREVISTO]
from PRODUCAO_TAREFAS_SALDO
--select * FROM PRODUCAO_TAREFAS_SALDO
WHERE ORDEM_PRODUCAO='229468'


SELECT * FROM PRODUCAO_ORDEM_SERVICO

sp_help PRODUCAO_TAREFAS

update PRODUCAO_TAREFAS
set QTDE_EM_PROCESSO=0,QTDE_FINALIZADA=428
WHERE ORDEM_PRODUCAO='239636' and TAREFA='1991280'



UPDATE PRODUCAO_TAREFAS_SALDO
SET QTDE_S=0,s1=0,S2=0,S3=0,S4=0,S5=0,S6=0,S7=0
WHERE ORDEM_PRODUCAO='227385' and TAREFA='1884833'


UPDATE PRODUCAO_TAREFAS_SALDO
SET s1=0,S2=1
WHERE ORDEM_PRODUCAO='175311' and TAREFA=1376079   


UPDATE PRODUCAO_TAREFAS_SALDO
SET QTDE_S=240,s1=0,S2=0,S3=0,S4=30,S5=120,S6=60,S7=30
WHERE ORDEM_PRODUCAO='90917' and TAREFA=556932


UPDATE PRODUCAO_TAREFAS_SALDO
SET QTDE_S=60,S3=0,S4=60
WHERE ORDEM_PRODUCAO='89497' and TAREFA=544109 

UPDATE PRODUCAO_TAREFAS_SALDO
SET QTDE_S=12,S4=12,S5=0,S6=0,S7=0,S8=0
WHERE ORDEM_PRODUCAO='81936' and TAREFA=477153    


EXEC LX_RECALCULO_OP '00109','00109'
EXEC LX_RECALCULO_OP '10639','10639'
EXEC LX_RECALCULO_OP '14823','14823'
EXEC LX_RECALCULO_OP '44087','44087'
EXEC LX_RECALCULO_OP '44121','44121'
EXEC LX_RECALCULO_OP '58185','58185'

SELECT * FROM PRODUCAO_TAREFAS
WHERE ORDEM_PRODUCAO='81245'


SELECT A.TAREFA,QTDE_O=SUM(A.QTDE_O),O1=SUM(A.O1),O2=SUM(A.O2),O3=SUM(A.O3),O4=SUM(A.O4),O5=SUM(A.O5),O6=SUM(A.O6), 
O7=SUM(A.O7),O8=SUM(A.O8),O9=SUM(A.O9),O10=SUM(A.O10),O11=SUM(A.O11),O12=SUM(A.O12),O13=SUM(A.O13),O14=SUM(A.O14)
FROM PRODUCAO_OS_TAREFAS A
JOIN PRODUCAO_TAREFAS B ON A.TAREFA=B.TAREFA 
WHERE A.ORDEM_PRODUCAO='00109' AND A.INDICADOR_TIPO_MOV=1
GROUP BY A.TAREFA

