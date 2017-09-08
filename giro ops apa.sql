select ORDEM_PRODUCAO,QTDE_EM_PROCESSO,GIRO=DATEDIFF(DAY, PRODUCAO_TAREFAS.INICIO_REAL, GETDATE())  from producao_tarefas
where fase_producao='70' and qtde_em_processo>0 
order by DATEDIFF(DAY, PRODUCAO_TAREFAS.INICIO_REAL, GETDATE()) desc
