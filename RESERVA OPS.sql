exec LX_RECALCULO_RESERVA_MATERIAIS  'v42911','179950' 


select * from PRODUCAO_RESERVA
WHERE ORDEM_PRODUCAO='179950'



SELECT ''''+B.PRODUTO+''','
FROM PRODUCAO_RESERVA A
JOIN PRODUCAO_ORDEM B ON B.ORDEM_PRODUCAO=A.ORDEM_PRODUCAO
WHERE B.PRODUTO LIKE 'V%' AND MATERIAL='50.12.0005' AND CONSUMIDA=0



SELECT * FROM PRODUCAO_RESERVA
WHERE MATERIAL='50.12.0005' AND CONSUMIDA=0

SELECT * FROM PRODUTOS_FICHA
WHERE MATERIAL='50.13.0009' AND PRODUTO IN(
'V50251      ',
'V40251      ',
'V57373      ',
'V44040      ',
'V40251      ',
'V52153      ',
'V50251      ',
'V40040      ',
'V43601      ',
'V43651      ',
'V1233       ',
'V40911      ',
'V40040      ',
'V44040      ',
'V42907.1    ',
'V44251      ',
'V50040      ',
'V45553      ',
'V51908      ',
'V43601      ',
'V57373      ',
'V51908      ',
'V44251      ',
'V40251      ',
'V52153      ',
'V51911.1    ',
'V40256      ',
'V57373      ',
'V42907.1    ',
'V43651      ',
'V42907.1    ',
'V43651      ',
'V40911      ',
'V42515      ',
'V42911      ',
'V40251      ',
'V40251      ',
'V40251      ',
'V50251      ')
