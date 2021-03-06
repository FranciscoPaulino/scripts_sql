--- ORDEM DE PRODUCAO COM FALTA DE MATERIAIS
SELECT GRUPOS.RECURSO_PRODUTIVO,FINAL.ORDEM_PRODUCAO,MATERIAL,DESC_MATERIAL,COR_MATERIAL,QTDE_ESTOQUE=ISNULL(QTDE_ESTOQUE,0),QTDE_DISPONIVEL=ISNULL(QTDE_DISPONIVEL,0),RESERVA=SUM(RESERVA) FROM ( 
SELECT A.ORDEM_PRODUCAO,A.MATERIAL,C.DESC_MATERIAL,A.COR_MATERIAL,A.RESERVA,C.GRUPO,C.SUBGRUPO,QTDE_ESTOQUE=ISNULL(D.QTDE_ESTOQUE,0),   
CASE WHEN B.QTDE_DISPONIVEL IS NULL THEN ISNULL(D.QTDE_ESTOQUE,0) ELSE ISNULL(B.QTDE_DISPONIVEL,0) END AS QTDE_DISPONIVEL FROM PRODUCAO_RESERVA A 
LEFT JOIN W_ESTOQUE_DISPONIVEL_MATERIAL B WITH (NOLOCK) ON B.MATERIAL=A.MATERIAL AND B.COR_MATERIAL=A.COR_MATERIAL   
LEFT JOIN MATERIAIS C WITH (NOLOCK) ON C.MATERIAL=A.MATERIAL   
LEFT JOIN ESTOQUE_MATERIAIS D WITH (NOLOCK) ON D.MATERIAL=A.MATERIAL AND D.COR_MATERIAL=A.COR_MATERIAL AND D.FILIAL='DR VAREJO'   
) AS FINAL  
LEFT JOIN (
SELECT ORDEM_PRODUCAO,RECURSO_PRODUTIVO FROM PRODUCAO_TAREFAS
WHERE FASE_PRODUCAO='007'
) AS GRUPOS ON GRUPOS.ORDEM_PRODUCAO = FINAL.ORDEM_PRODUCAO 
JOIN (SELECT ORDEM_PRODUCAO FROM PRODUCAO_TAREFAS WHERE FASE_PRODUCAO='001' AND QTDE_EM_PROCESSO>0) AS PT ON PT.ORDEM_PRODUCAO=FINAL.ORDEM_PRODUCAO
WHERE FINAL.ORDEM_PRODUCAO NOT LIKE '%.%' AND MATERIAL NOT IN (SELECT DISTINCT A.MATERIAL FROM MATERIAIS A WITH (NOLOCK) JOIN MATERIAIS_CORES B WITH (NOLOCK) ON B.MATERIAL=A.MATERIAL  
WHERE GETDATE() NOT BETWEEN B.INICIO_VENDAS AND B.FIM_VENDAS) AND RESERVA>0 AND RESERVA>QTDE_DISPONIVEL --AND FINAL.ORDEM_PRODUCAO IN ('88514')   
group by GRUPOS.RECURSO_PRODUTIVO,FINAL.ORDEM_PRODUCAO,MATERIAL,DESC_MATERIAL,COR_MATERIAL,QTDE_ESTOQUE,QTDE_DISPONIVEL