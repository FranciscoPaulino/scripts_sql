SELECT STATUS_NFE FROM FATURAMENTO
WHERE NF_SAIDA='0054878'


UPDATE FATURAMENTO
SET STATUS_NFE=1
WHERE SERIE_NF='55' AND NF_SAIDA IN (
'0054966',
'0054961',
'0054960',
'0054959',
'0054957',
'0054956',
'0054951',
'0054940',
'0054939',
'0054938',
'0054937',
'0054934',
'0054928',
'0054927',
'0054922',
'0054921',
'0054916',
'0054915',
'0054914',
'0054913',
'0054912',
'0054902',
'0054890',
'0054881')