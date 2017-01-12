SELECT ORDEM_PRODUCAO_006.ORDEM_PRODUCAO,ORDEM_PRODUCAO_006.NF_SAIDA AS NF_SAIDA_F006,ORDEM_PRODUCAO_006.EMISSAO AS EMISSAO_F006, ORDEM_PRODUCAO_009.NF_SAIDA AS NF_SAIDA_F009,ORDEM_PRODUCAO_009.EMISSAO AS EMISSAO_F009
FROM PRODUCAO_ORDEM

JOIN (
SELECT C.NF_SAIDA,C.SERIE_NF,A.ORDEM_SERVICO,B.FASE_PRODUCAO,A.ORDEM_PRODUCAO,A.QTDE_O,D.EMISSAO
FROM PRODUCAO_OS_TAREFAS A 
JOIN PRODUCAO_TAREFAS B ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO AND B.TAREFA=A.TAREFA
JOIN (SELECT * FROM PRODUCAO_ORDEM_SERVICO WHERE NF_SAIDA <>'') C ON C.ORDEM_SERVICO=A.ORDEM_SERVICO
JOIN FATURAMENTO D ON D.NF_SAIDA=C.NF_SAIDA AND D.SERIE_NF=C.SERIE_NF
WHERE B.FASE_PRODUCAO='006' AND B.ORDEM_PRODUCAO='84671'
) AS ORDEM_PRODUCAO_006 ON ORDEM_PRODUCAO_006.ORDEM_PRODUCAO=PRODUCAO_ORDEM.ORDEM_PRODUCAO

JOIN (
SELECT  D.EMISSAO,C.NF_SAIDA,C.SERIE_NF,A.ORDEM_SERVICO,A.ORDEM_PRODUCAO,A.QTDE_O
FROM PRODUCAO_OS_TAREFAS A 
JOIN PRODUCAO_TAREFAS B ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO AND B.TAREFA=A.TAREFA
JOIN (SELECT * FROM PRODUCAO_ORDEM_SERVICO WHERE NF_SAIDA <>'') C ON C.ORDEM_SERVICO=A.ORDEM_SERVICO
JOIN FATURAMENTO D ON D.NF_SAIDA=C.NF_SAIDA AND D.SERIE_NF=C.SERIE_NF
WHERE B.FASE_PRODUCAO='009' AND B.ORDEM_PRODUCAO='84671'
) AS ORDEM_PRODUCAO_009 ON ORDEM_PRODUCAO_009.ORDEM_PRODUCAO=PRODUCAO_ORDEM.ORDEM_PRODUCAO

WHERE PRODUCAO_ORDEM.ORDEM_PRODUCAO='84671' AND YEAR(ORDEM_PRODUCAO_006.EMISSAO) = 2015
ORDER BY ORDEM_PRODUCAO




