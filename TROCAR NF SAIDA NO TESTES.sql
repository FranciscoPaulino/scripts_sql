

DROP TABLE #FATURAMENTO

SELECT * INTO #FATURAMENTO FROM FATURAMENTO
WHERE EMISSAO BETWEEN '20140311' AND '20140331' AND SERIE_NF='9'

SELECT * FROM FATURAMENTO
WHERE EMISSAO BETWEEN '20140311' AND '20140331' AND SERIE_NF='9'



UPDATE FATURAMENTO
SET NF_SAIDA=FINAL.NF_SAIDA_NEW

FROM (
SELECT DISTINCT A.NF_SAIDA AS NF_SAIDA_OLD,A.NF_SAIDA,B.PEDIDO,C.NF_SAIDA AS NF_SAIDA_NEW,C.PEDIDO AS PEDIDO_NEW FROM FATURAMENTO A
JOIN FATURAMENTO_PROD B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF='9'
JOIN 
(
SELECT DISTINCT A.NF_SAIDA,A.SERIE_NF,B.PEDIDO,A.EMISSAO FROM DRVAREJO.DBO.FATURAMENTO A
JOIN DRVAREJO.DBO.FATURAMENTO_PROD B ON B.NF_SAIDA=A.NF_SAIDA AND B.SERIE_NF=A.SERIE_NF
WHERE B.PEDIDO IN (
'567514',
'567973',
'566829',
'567734',
'568451',
'567720',
'568483',
'567599',
'568261',
'567353',
'567362',
'567027',
'567869',
'568412',
'566904',
'568338',
'566228',
'567472',
'568440',
'565825',
'567525'
) 
AND A.EMISSAO BETWEEN '20140311' AND '20140331'
) AS C ON C.PEDIDO=B.PEDIDO ) AS FINAL
JOIN FATURAMENTO_PROD ON FATURAMENTO_PROD.PEDIDO=FINAL.PEDIDO
JOIN FATURAMENTO ON FATURAMENTO.NF_SAIDA=FINAL.NF_SAIDA_OLD

WHERE FATURAMENTO.NF_SAIDA=FINAL.NF_SAIDA_OLD and 
FATURAMENTO.EMISSAO BETWEEN '20140311' AND '20140331' AND FATURAMENTO.SERIE_NF='9'


 




COMMIT TRAN

ROLLBACK



