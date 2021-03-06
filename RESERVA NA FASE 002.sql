SELECT A.ORDEM_PRODUCAO,A.MATERIAL,A.COR_MATERIAL,A.RESERVA,B.QTDE_ESTOQUE,B.QTDE_DISPONIVEL FROM PRODUCAO_RESERVA A WITH (NOLOCK) 
JOIN W_ESTOQUE_DISPONIVEL_MATERIAL B WITH (NOLOCK) ON B.MATERIAL=A.MATERIAL AND B.COR_MATERIAL=A.COR_MATERIAL 
JOIN MATERIAIS C WITH (NOLOCK) ON C.MATERIAL=B.MATERIAL 
WHERE (C.GRUPO LIKE '01%' OR C.GRUPO LIKE '15%' OR C.GRUPO LIKE '30%' OR C.GRUPO LIKE '40%' OR C.SUBGRUPO LIKE 'BOJO' OR C.SUBGRUPO LIKE 'COLCHETE' OR C.SUBGRUPO LIKE 'ARGOLA' OR C.SUBGRUPO='PASSANTE')  AND A.RESERVA>0 AND A.RESERVA>B.QTDE_DISPONIVEL AND ORDEM_PRODUCAO='79687'

GO

SELECT ORDEM_PRODUCAO,GRUPO,SUBGRUPO,MATERIAL,COR_MATERIAL,RESERVA,QTDE_ESTOQUE,QTDE_DISPONIVEL FROM (
SELECT A.ORDEM_PRODUCAO,A.MATERIAL,A.COR_MATERIAL,A.RESERVA,C.GRUPO,C.SUBGRUPO,D.QTDE_ESTOQUE, CASE WHEN B.QTDE_DISPONIVEL IS NULL THEN D.QTDE_ESTOQUE ELSE B.QTDE_DISPONIVEL END AS QTDE_DISPONIVEL FROM PRODUCAO_RESERVA A
LEFT JOIN W_ESTOQUE_DISPONIVEL_MATERIAL B WITH (NOLOCK) ON B.MATERIAL=A.MATERIAL AND B.COR_MATERIAL=A.COR_MATERIAL 
LEFT JOIN MATERIAIS C WITH (NOLOCK) ON C.MATERIAL=A.MATERIAL 
JOIN ESTOQUE_MATERIAIS D WITH (NOLOCK) ON D.MATERIAL=A.MATERIAL AND D.COR_MATERIAL=A.COR_MATERIAL AND D.FILIAL='DR VAREJO'    
) AS FINAL
WHERE (GRUPO LIKE '01%' OR GRUPO LIKE '15%' OR GRUPO LIKE '30%' OR GRUPO LIKE '40%' OR SUBGRUPO LIKE 'BOJO' OR SUBGRUPO LIKE 'COLCHETE' OR SUBGRUPO LIKE 'ARGOLA' OR SUBGRUPO='PASSANTE')  AND RESERVA>0 AND RESERVA>QTDE_DISPONIVEL AND ORDEM_PRODUCAO='79687'
ORDER BY MATERIAL




sp_helptext W_ESTOQUE_DISPONIVEL_MATERIAL

alter VIEW W_ESTOQUE_DISPONIVEL_MATERIAL AS    
SELECT MATERIAL,COR_MATERIAL,QTDE_ESTOQUE,RESERVA,QTDE_DISPONIVEL=(QTDE_ESTOQUE-RESERVA) FROM (    
SELECT PRODUCAO_RESERVA.MATERIAL,PRODUCAO_RESERVA.COR_MATERIAL,ESTOQUE_MATERIAIS.QTDE_ESTOQUE,RESERVA=SUM(RESERVA)    
FROM PRODUCAO_RESERVA WITH (NOLOCK)    
JOIN ESTOQUE_MATERIAIS WITH (NOLOCK) ON ESTOQUE_MATERIAIS.MATERIAL=PRODUCAO_RESERVA.MATERIAL AND    
ESTOQUE_MATERIAIS.COR_MATERIAL=PRODUCAO_RESERVA.COR_MATERIAL AND ESTOQUE_MATERIAIS.FILIAL='DR VAREJO'    
WHERE PRODUCAO_RESERVA.ORDEM_PRODUCAO IN (    
SELECT ORDEM_PRODUCAO FROM PRODUCAO_TAREFAS WITH (NOLOCK)    
WHERE (FASE_PRODUCAO in('002') and QTDE_EM_PROCESSO>0)    
)    
GROUP BY PRODUCAO_RESERVA.MATERIAL,PRODUCAO_RESERVA.MATERIAL,PRODUCAO_RESERVA.COR_MATERIAL,ESTOQUE_MATERIAIS.QTDE_ESTOQUE    
) AS ESTOQUE_DISPONIVEL    




SELECT MATERIAL,COR_MATERIAL,QTDE_ESTOQUE,RESERVA,QTDE_DISPONIVEL=(QTDE_ESTOQUE-RESERVA) FROM (    
SELECT PRODUCAO_RESERVA.MATERIAL,PRODUCAO_RESERVA.COR_MATERIAL,ESTOQUE_MATERIAIS.QTDE_ESTOQUE,RESERVA=SUM(RESERVA)    
FROM PRODUCAO_RESERVA WITH (NOLOCK)    
JOIN ESTOQUE_MATERIAIS WITH (NOLOCK) ON ESTOQUE_MATERIAIS.MATERIAL=PRODUCAO_RESERVA.MATERIAL AND    
ESTOQUE_MATERIAIS.COR_MATERIAL=PRODUCAO_RESERVA.COR_MATERIAL AND ESTOQUE_MATERIAIS.FILIAL='DR VAREJO'    
WHERE PRODUCAO_RESERVA.ORDEM_PRODUCAO IN (    
SELECT ORDEM_PRODUCAO FROM PRODUCAO_TAREFAS WITH (NOLOCK)    
WHERE (FASE_PRODUCAO in('002') and QTDE_EM_PROCESSO>0)    
)    
GROUP BY PRODUCAO_RESERVA.MATERIAL,PRODUCAO_RESERVA.MATERIAL,PRODUCAO_RESERVA.COR_MATERIAL,ESTOQUE_MATERIAIS.QTDE_ESTOQUE    
) AS ESTOQUE_DISPONIVEL    



SELECT ORDEM_PRODUCAO FROM PRODUCAO_TAREFAS WITH (NOLOCK)    
WHERE (FASE_PRODUCAO in('002') and QTDE_EM_PROCESSO>0) and ORDEM_PRODUCAO='81180'
    
SELECT PRODUCAO_RESERVA.MATERIAL,PRODUCAO_RESERVA.COR_MATERIAL,ESTOQUE_MATERIAIS.QTDE_ESTOQUE,RESERVA
FROM PRODUCAO_RESERVA WITH (NOLOCK)    
JOIN ESTOQUE_MATERIAIS WITH (NOLOCK) ON ESTOQUE_MATERIAIS.MATERIAL=PRODUCAO_RESERVA.MATERIAL AND    
ESTOQUE_MATERIAIS.COR_MATERIAL=PRODUCAO_RESERVA.COR_MATERIAL AND ESTOQUE_MATERIAIS.FILIAL='DR VAREJO'    
WHERE PRODUCAO_RESERVA.ORDEM_PRODUCAO IN (    
SELECT ORDEM_PRODUCAO FROM PRODUCAO_TAREFAS WITH (NOLOCK)    
WHERE (FASE_PRODUCAO in('002') and QTDE_EM_PROCESSO>0))
order by MATERIAL

SELECT * FROM (
    
SELECT D.QTDE_ESTOQUE, CASE WHEN B.QTDE_DISPONIVEL IS NULL THEN D.QTDE_ESTOQUE ELSE B.QTDE_DISPONIVEL END AS QTDE_DISPONIVEL, A.ORDEM_PRODUCAO,A.MATERIAL,A.COR_MATERIAL,A.RESERVA,C.GRUPO,C.SUBGRUPO from PRODUCAO_RESERVA A
LEFT JOIN W_ESTOQUE_DISPONIVEL_MATERIAL B WITH (NOLOCK) ON B.MATERIAL=A.MATERIAL AND B.COR_MATERIAL=A.COR_MATERIAL 
LEFT JOIN MATERIAIS C WITH (NOLOCK) ON C.MATERIAL=A.MATERIAL 
JOIN ESTOQUE_MATERIAIS D WITH (NOLOCK) ON D.MATERIAL=A.MATERIAL AND D.COR_MATERIAL=A.COR_MATERIAL AND D.FILIAL='DR VAREJO'    
) AS FINAL

WHERE (GRUPO LIKE '01%' OR GRUPO LIKE '15%' OR GRUPO LIKE '30%' OR GRUPO LIKE '40%' OR SUBGRUPO LIKE 'BOJO' OR SUBGRUPO LIKE 'COLCHETE' OR SUBGRUPO LIKE 'ARGOLA' OR SUBGRUPO='PASSANTE')  AND 
RESERVA>0 AND RESERVA>QTDE_DISPONIVEL AND ORDEM_PRODUCAO='79687'

ORDER BY MATERIAL


SELECT * from PRODUCAO_RESERVA