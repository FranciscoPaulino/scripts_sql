-------------------------------------- OFICINAS ---------------------------------------  

SELECT TABELA_OPERACOES,QTDE_FASE=COUNT(FASE_PRODUCAO) 
FROM PRODUTO_OPERACOES_ROTAS
WHERE SETOR_PRODUCAO LIKE '%ATHENA%'
GROUP BY TABELA_OPERACOES
HAVING COUNT(FASE_PRODUCAO)=4

--SELECT TABELA_OPERACOES,QTDE_FASE=COUNT(FASE_PRODUCAO) 
--FROM PRODUTO_OPERACOES_ROTAS
--WHERE SETOR_PRODUCAO LIKE '%DANJOU%'
--GROUP BY TABELA_OPERACOES
--HAVING COUNT(FASE_PRODUCAO)=4

SELECT TABELA_OPERACOES,QTDE_FASE=COUNT(FASE_PRODUCAO) 
FROM PRODUTO_OPERACOES_ROTAS
WHERE SETOR_PRODUCAO LIKE '%FIORUCCI%'
GROUP BY TABELA_OPERACOES
HAVING COUNT(FASE_PRODUCAO)=4


SELECT TABELA_OPERACOES,QTDE_FASE=COUNT(FASE_PRODUCAO) 
FROM PRODUTO_OPERACOES_ROTAS
WHERE SETOR_PRODUCAO LIKE '%AFRODITE%'
GROUP BY TABELA_OPERACOES
HAVING COUNT(FASE_PRODUCAO)=4


SELECT TABELA_OPERACOES,QTDE_FASE=COUNT(FASE_PRODUCAO) 
FROM PRODUTO_OPERACOES_ROTAS
WHERE SETOR_PRODUCAO LIKE '%ELITE%'
GROUP BY TABELA_OPERACOES
HAVING COUNT(FASE_PRODUCAO)=4


SELECT TABELA_OPERACOES,QTDE_FASE=COUNT(FASE_PRODUCAO) 
FROM PRODUTO_OPERACOES_ROTAS
WHERE SETOR_PRODUCAO LIKE '%JULIETE%'
GROUP BY TABELA_OPERACOES
HAVING COUNT(FASE_PRODUCAO)=4



--- INSERT PRODUTO_OPERACOES_ROTAS INCLUSÃO DA FASE 006.1
INSERT INTO PRODUTO_OPERACOES_ROTAS (TABELA_OPERACOES,ROTA_PRODUCAO,FASE_PRODUCAO,SETOR_PRODUCAO,SEQUENCIA_PRODUTIVA,SEQUENCIA_ANTERIOR,TEMPO_CRONOMETRADO_2,TEMPO_CRONOMETRADO_3,TEMPO_CRONOMETRADO_4,SETOR_PARALELO_NUMERO,RECURSO_PRODUTIVO,TEMPO_OPERACAO,UNIDADE_TEMPO,CUSTO_SUGERIDO,TIPO_TEMPO_PROCESSO,METODO_LOTE_QTDE,METODO_LOTE,BAIXA_AUTOMATICA_MATERIAL,TEMPO_CRONOMETRADO,TEMPO_CRONOM_FIXO,CUSTO_SUGERIDO_2,CUSTO_SUGERIDO_3,CUSTO_SUGERIDO_4,TIPO_CUSTO) 
SELECT DISTINCT TABELA_OPERACOES,'0000','006.1                    ','PREATHENA                ',SEQUENCIA_PRODUTIVA+5,SEQUENCIA_PRODUTIVA,0,0,0,'0','PRATH',1.00,'H',0,'1',1,'0',0,0,0,0,0,0,1 
FROM PRODUTO_OPERACOES_ROTAS
WHERE TABELA_OPERACOES IN (
'234C                     ',
'236C                     ',
'237C                     ',
'40002                    ',
'40027                    ',
'40120                    ',
'40153                    ',
'40173                    ',
'40203.1                  ',
'40251                    ',
'40319                    ',
'40369                    ',
'40370                    ',
'40371                    ',
'40450                    ',
'40454                    ',
'40455                    ',
'40467                    ',
'40603                    ',
'40605                    ',
'40614                    ',
'40614 TESTE              ',
'40644                    ',
'40644 TESTE              ',
'40911                    ',
'42164                    ',
'42223                    ',
'42252                    ',
'42252 TESTE              ',
'42261                    ',
'42320                    ',
'42366                    ',
'42369                    ',
'42370                    ',
'42452                    ',
'42455                    ',
'42458                    ',
'42463                    ',
'42465                    ',
'42466                    ',
'42503                    ',
'42607.2                  ',
'42902.1                  ',
'43040                    ',
'43203                    ',
'43366                    ',
'43601                    ',
'43706                    ',
'44040                    ',
'441687                   ',
'44251                    ',
'44251.1                  ',
'44706                    ',
'45218                    ',
'45223                    ',
'45251                    ',
'45252                    ',
'45253                    ',
'45311                    ',
'45313                    ',
'45320                    ',
'45333                    ',
'45451                    ',
'45454                    ',
'45455                    ',
'45457                    ',
'45460                    ',
'45461                    ',
'45465                    ',
'45466                    ',
'45620                    ',
'45827                    ',
'51158                    ',
'51159                    ',
'51170                    ',
'51173                    ',
'52159                    ',
'53262                    ',
'56457                    ',
'60901                    ',
'R42260                   ',
'R42261                   '
) AND FASE_PRODUCAO='006'


INSERT INTO PRODUTO_OPERACOES_ROTAS (TABELA_OPERACOES,ROTA_PRODUCAO,FASE_PRODUCAO,SETOR_PRODUCAO,SEQUENCIA_PRODUTIVA,SEQUENCIA_ANTERIOR,TEMPO_CRONOMETRADO_2,TEMPO_CRONOMETRADO_3,TEMPO_CRONOMETRADO_4,SETOR_PARALELO_NUMERO,RECURSO_PRODUTIVO,TEMPO_OPERACAO,UNIDADE_TEMPO,CUSTO_SUGERIDO,TIPO_TEMPO_PROCESSO,METODO_LOTE_QTDE,METODO_LOTE,BAIXA_AUTOMATICA_MATERIAL,TEMPO_CRONOMETRADO,TEMPO_CRONOM_FIXO,CUSTO_SUGERIDO_2,CUSTO_SUGERIDO_3,CUSTO_SUGERIDO_4,TIPO_CUSTO) 
SELECT DISTINCT TABELA_OPERACOES,'0000','006.1                    ','PREFIORUCCI                ',SEQUENCIA_PRODUTIVA+5,SEQUENCIA_PRODUTIVA,0,0,0,'0','PRFIO',1.00,'H',0,'1',1,'0',0,0,0,0,0,0,1 
FROM PRODUTO_OPERACOES_ROTAS
WHERE TABELA_OPERACOES IN (
'0296                     ',
'0298                     ',
'0301                     ',
'0302                     ',
'0304                     ',
'40164                    ',
'40262                    ',
'40354                    ',
'40452                    ',
'40458                    ',
'40459                    ',
'40604                    ',
'40607.2                  ',
'40707                    ',
'40903                    ',
'40907                    ',
'42040                    ',
'421507                   ',
'421507.1                 ',
'421517                   ',
'42218                    ',
'42258                    ',
'42262                    ',
'42311                    ',
'42313                    ',
'42333                    ',
'42372                    ',
'42375                    ',
'42451                    ',
'42907                    ',
'42911                    ',
'50002                    ',
'501547                   ',
'50173                    ',
'50203                    ',
'50251                    ',
'50252                    ',
'50253                    ',
'50366                    ',
'50452                    ',
'50457                    ',
'50464                    ',
'50502                    ',
'50604                    ',
'50707                    ',
'50902                    ',
'511507.1                 ',
'51153                    ',
'51164                    ',
'51218                    ',
'51223                    ',
'51252                    ',
'51253                    ',
'51258                    ',
'51260                    ',
'51311                    ',
'51313                    ',
'51320                    ',
'51333                    ',
'51351                    ',
'51356                    ',
'51357                    ',
'51360                    ',
'51361                    ',
'51365                    ',
'51372                    ',
'51450                    ',
'51451                    ',
'51452                    ',
'51453                    ',
'51454                    ',
'51455                    ',
'51456                    ',
'51459                    ',
'51463                    ',
'51465                    ',
'51466                    ',
'51480                    ',
'51607.2                  ',
'51611                    ',
'51620                    ',
'51705                    ',
'51903                    ',
'52153                    ',
'52164                    ',
'52218                    ',
'52223                    ',
'52252                    ',
'52253                    ',
'52258                    ',
'52260                    ',
'52311                    ',
'52313                    ',
'52320                    ',
'52333                    ',
'52360                    ',
'52365                    ',
'52372                    ',
'52450                    ',
'52451                    ',
'52453                    ',
'52454                    ',
'52455                    ',
'52456                    ',
'52458                    ',
'52459                    ',
'52463                    ',
'52464                    ',
'52465                    ',
'52466                    ',
'52604                    ',
'52607.2                  ',
'52620                    ',
'52705                    ',
'52902                    ',
'52903.1                  ',
'52907                    ',
'53705                    ',
'54365                    ',
'54908                    ',
'57218                    ',
'57223                    ',
'57260.1                  ',
'57311                    ',
'57313                    ',
'57320                    ',
'57333                    ',
'57363                    ',
'57373                    ',
'57457                    ',
'57465                    ',
'57466                    ',
'57705                    ',
'57907                    '
) 

AND FASE_PRODUCAO='006'


INSERT INTO PRODUTO_OPERACOES_ROTAS (TABELA_OPERACOES,ROTA_PRODUCAO,FASE_PRODUCAO,SETOR_PRODUCAO,SEQUENCIA_PRODUTIVA,SEQUENCIA_ANTERIOR,TEMPO_CRONOMETRADO_2,TEMPO_CRONOMETRADO_3,TEMPO_CRONOMETRADO_4,SETOR_PARALELO_NUMERO,RECURSO_PRODUTIVO,TEMPO_OPERACAO,UNIDADE_TEMPO,CUSTO_SUGERIDO,TIPO_TEMPO_PROCESSO,METODO_LOTE_QTDE,METODO_LOTE,BAIXA_AUTOMATICA_MATERIAL,TEMPO_CRONOMETRADO,TEMPO_CRONOM_FIXO,CUSTO_SUGERIDO_2,CUSTO_SUGERIDO_3,CUSTO_SUGERIDO_4,TIPO_CUSTO) 
SELECT DISTINCT TABELA_OPERACOES,'0000','006.1                    ','PREAFRODITE                ',SEQUENCIA_PRODUTIVA+5,SEQUENCIA_PRODUTIVA,0,0,0,'0','PRAFR',1.00,'H',0,'1',1,'0',0,0,0,0,0,0,1 
FROM PRODUTO_OPERACOES_ROTAS
WHERE TABELA_OPERACOES IN (
'0300                     ',
'0303                     ',
'0303T                    ',
'2084                     ',
'40040                    ',
'40152                    ',
'40163                    ',
'40501                    ',
'40514                    ',
'41166                    ',
'41903                    ',
'42152                    ',
'42153                    ',
'42157                    ',
'42166                    ',
'42167                    ',
'42250                    ',
'42260                    ',
'42260.1                  ',
'42260.2                  ',
'42373                    ',
'42450                    ',
'42459                    ',
'42604                    ',
'42902                    ',
'42903.1                  ',
'43167                    ',
'43168                    ',
'43256                    ',
'43262                    ',
'43462                    ',
'44027                    ',
'44167                    ',
'44262                    ',
'44375                    ',
'45160                    ',
'45175                    ',
'45362                    ',
'45828                    ',
'46109                    ',
'47375                    ',
'47457                    ',
'47463                    ',
'47620                    ',
'47902.1                  ',
'49166                    ',
'50040                    ',
'50163                    ',
'50256                    ',
'50501                    ',
'50514                    ',
'50614                    ',
'50911                    ',
'51160                    ',
'51163                    ',
'51352                    ',
'51362                    ',
'51375                    ',
'51514                    ',
'51828                    ',
'51911.1                  ',
'52375                    ',
'53027                    ',
'54375                    ',
'55027                    '
) AND FASE_PRODUCAO='006'

INSERT INTO PRODUTO_OPERACOES_ROTAS (TABELA_OPERACOES,ROTA_PRODUCAO,FASE_PRODUCAO,SETOR_PRODUCAO,SEQUENCIA_PRODUTIVA,SEQUENCIA_ANTERIOR,TEMPO_CRONOMETRADO_2,TEMPO_CRONOMETRADO_3,TEMPO_CRONOMETRADO_4,SETOR_PARALELO_NUMERO,RECURSO_PRODUTIVO,TEMPO_OPERACAO,UNIDADE_TEMPO,CUSTO_SUGERIDO,TIPO_TEMPO_PROCESSO,METODO_LOTE_QTDE,METODO_LOTE,BAIXA_AUTOMATICA_MATERIAL,TEMPO_CRONOMETRADO,TEMPO_CRONOM_FIXO,CUSTO_SUGERIDO_2,CUSTO_SUGERIDO_3,CUSTO_SUGERIDO_4,TIPO_CUSTO) 
SELECT DISTINCT TABELA_OPERACOES,'0000','006.1                    ','PREELITE                ',SEQUENCIA_PRODUTIVA+5,SEQUENCIA_PRODUTIVA,0,0,0,'0','PRELI',1.00,'H',0,'1',1,'0',0,0,0,0,0,0,1 
FROM PRODUTO_OPERACOES_ROTAS
WHERE TABELA_OPERACOES IN (
'0295                     ',
'0299                     ',
'10002                    ',
'10005                    ',
'30102                    ',
'30103                    ',
'30104                    ',
'40156                    ',
'40157                    ',
'40312                    ',
'40351                    ',
'40360                    ',
'40452.1                  ',
'40480                    ',
'41006                    ',
'42118                    ',
'42156                    ',
'42312                    ',
'42361                    ',
'42371                    ',
'42453                    ',
'42454                    ',
'42456                    ',
'42460                    ',
'42461                    ',
'42620                    ',
'44363                    ',
'44373                    ',
'44450                    ',
'45352                    ',
'45353                    ',
'45357                    ',
'45450                    ',
'45453                    ',
'45456                    ',
'50166                    ',
'50250                    ',
'50254                    ',
'50254 TESTE              ',
'50262                    ',
'50462                    ',
'51118                    ',
'51120                    ',
'511507                   ',
'51254 TESTE              ',
'51312                    ',
'51319                    ',
'51353                    ',
'51367                    ',
'51460                    ',
'51461                    ',
'51911                    ',
'52118                    ',
'52120                    ',
'52257.1                  ',
'52312                    ',
'52319                    ',
'52361                    ',
'52367                    ',
'52460                    ',
'52461                    ',
'53603                    ',
'53605                    ',
'57118                    ',
'57120                    ',
'57254 TESTE              ',
'57261                    ',
'57312                    ',
'57319                    ',
'57460                    ',
'57461                    ',
'57607                    ',
'57903                    ',
'R51261                   ',
'R52260                   ',
'R57261'                   ) 
AND FASE_PRODUCAO='006'


INSERT INTO PRODUTO_OPERACOES_ROTAS (TABELA_OPERACOES,ROTA_PRODUCAO,FASE_PRODUCAO,SETOR_PRODUCAO,SEQUENCIA_PRODUTIVA,SEQUENCIA_ANTERIOR,TEMPO_CRONOMETRADO_2,TEMPO_CRONOMETRADO_3,TEMPO_CRONOMETRADO_4,SETOR_PARALELO_NUMERO,RECURSO_PRODUTIVO,TEMPO_OPERACAO,UNIDADE_TEMPO,CUSTO_SUGERIDO,TIPO_TEMPO_PROCESSO,METODO_LOTE_QTDE,METODO_LOTE,BAIXA_AUTOMATICA_MATERIAL,TEMPO_CRONOMETRADO,TEMPO_CRONOM_FIXO,CUSTO_SUGERIDO_2,CUSTO_SUGERIDO_3,CUSTO_SUGERIDO_4,TIPO_CUSTO) 
SELECT DISTINCT TABELA_OPERACOES,'0000','006.1                    ','PREJULIETE                ',SEQUENCIA_PRODUTIVA+5,SEQUENCIA_PRODUTIVA,0,0,0,'0','PRJUL',1.00,'H',0,'1',1,'0',0,0,0,0,0,0,1 
FROM PRODUTO_OPERACOES_ROTAS
WHERE TABELA_OPERACOES IN (
'0                        ',
'01446                    ',
'1233                     ',
'40174                    ',
'40256                    ',
'40502                    ',
'421547                   ',
'42253                    ',
'42254                    ',
'42254 TESTE              ',
'42256                    ',
'42367                    ',
'42462                    ',
'42464                    ',
'42908                    ',
'44028                    ',
'44464                    ',
'45166                    ',
'45255                    ',
'45365                    ',
'47167                    ',
'47902                    ',
'48027                    ',
'50167                    ',
'51902                    ',
'52167                    ',
'56027                    ',
'56166                    ',
'57902                    ',
'MODELO                   ') 

AND FASE_PRODUCAO='006'


--INSERT INTO PRODUTO_OPERACOES_ROTAS (TABELA_OPERACOES,ROTA_PRODUCAO,FASE_PRODUCAO,SETOR_PRODUCAO,SEQUENCIA_PRODUTIVA,SEQUENCIA_ANTERIOR,TEMPO_CRONOMETRADO_2,TEMPO_CRONOMETRADO_3,TEMPO_CRONOMETRADO_4,SETOR_PARALELO_NUMERO,RECURSO_PRODUTIVO,TEMPO_OPERACAO,UNIDADE_TEMPO,CUSTO_SUGERIDO,TIPO_TEMPO_PROCESSO,METODO_LOTE_QTDE,METODO_LOTE,BAIXA_AUTOMATICA_MATERIAL,TEMPO_CRONOMETRADO,TEMPO_CRONOM_FIXO,CUSTO_SUGERIDO_2,CUSTO_SUGERIDO_3,CUSTO_SUGERIDO_4,TIPO_CUSTO) 
--SELECT DISTINCT TABELA_OPERACOES,'0000','006.1                    ','PREDANJOU                ',SEQUENCIA_PRODUTIVA+5,SEQUENCIA_PRODUTIVA,0,0,0,'0','PRDAN',1.00,'H',0,'1',1,'0',0,0,0,0,0,0,1 
--FROM PRODUTO_OPERACOES_ROTAS
--WHERE TABELA_OPERACOES IN (
--'40257                   ', 
--'40257 TESTE             ', 
--'40257.1                 ', 
--'40611                   ', 
--'45016                   ', 
--'47257                   ', 
--'501517                  ', 
--'51002                   ', 
--'51152                   ', 
--'51156                   ', 
--'51165                   ', 
--'51175                   ', 
--'51254                   ', 
--'51257                   ', 
--'51257 TESTE             ', 
--'51261                   ', 
--'52152                   ', 
--'52156                   ', 
--'52157                   ', 
--'52255                   ', 
--'52257 TESTE             ', 
--'57157                   ', 
--'57255                   ' 
--) AND FASE_PRODUCAO='006'


SELECT TABELA_OPERACOES,SEQUENCIA_PRODUTIVA,SEQUENCIA_ANTERIOR FROM PRODUTO_OPERACOES_ROTAS
WHERE SEQUENCIA_PRODUTIVA = SEQUENCIA_ANTERIOR

--- alteração da sequencia anterior
SELECT * FROM PRODUTO_OPERACOES_ROTAS
WHERE ROTA_PRODUCAO='0000'  AND FASE_PRODUCAO='007'  AND SEQUENCIA_PRODUTIVA='60'  AND TEMPO_CRONOMETRADO_2=0  AND TEMPO_CRONOMETRADO_3=0  AND TEMPO_CRONOMETRADO_4=0  AND CUSTO_SUGERIDO_2=0  AND CUSTO_SUGERIDO_3=0  AND CUSTO_SUGERIDO_4=0 

UPDATE PRODUTO_OPERACOES_ROTAS 
SET SEQUENCIA_ANTERIOR='55' ,TEMPO_CRONOMETRADO_2=0 ,TEMPO_CRONOMETRADO_3=0 ,TEMPO_CRONOMETRADO_4=0 ,CUSTO_SUGERIDO_2=0 ,CUSTO_SUGERIDO_3=0 ,CUSTO_SUGERIDO_4=0  
WHERE ROTA_PRODUCAO='0000'  AND FASE_PRODUCAO='007'  AND SEQUENCIA_PRODUTIVA='60'  AND TEMPO_CRONOMETRADO_2=0  AND TEMPO_CRONOMETRADO_3=0  AND TEMPO_CRONOMETRADO_4=0  AND CUSTO_SUGERIDO_2=0  AND CUSTO_SUGERIDO_3=0  AND CUSTO_SUGERIDO_4=0 


SELECT * FROM PRODUTO_OPERACOES_ROTAS
WHERE ROTA_PRODUCAO='0000'  AND FASE_PRODUCAO='007'  AND SEQUENCIA_PRODUTIVA='70'  AND TEMPO_CRONOMETRADO_2=0  AND TEMPO_CRONOMETRADO_3=0  AND TEMPO_CRONOMETRADO_4=0  AND CUSTO_SUGERIDO_2=0  AND CUSTO_SUGERIDO_3=0  AND CUSTO_SUGERIDO_4=0 

UPDATE PRODUTO_OPERACOES_ROTAS 
SET SEQUENCIA_ANTERIOR='65' ,TEMPO_CRONOMETRADO_2=0 ,TEMPO_CRONOMETRADO_3=0 ,TEMPO_CRONOMETRADO_4=0 ,CUSTO_SUGERIDO_2=0 ,CUSTO_SUGERIDO_3=0 ,CUSTO_SUGERIDO_4=0  
WHERE ROTA_PRODUCAO='0000'  AND FASE_PRODUCAO='007'  AND SEQUENCIA_PRODUTIVA='70'  AND TEMPO_CRONOMETRADO_2=0  AND TEMPO_CRONOMETRADO_3=0  AND TEMPO_CRONOMETRADO_4=0  AND CUSTO_SUGERIDO_2=0  AND CUSTO_SUGERIDO_3=0  AND CUSTO_SUGERIDO_4=0 





