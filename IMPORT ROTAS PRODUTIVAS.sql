--- 1o

--- LINHA INDUSTRIAL
INSERT INTO   PRODUTIV_LINHA_INDUSTRIAL
SELECT 'V'+[LINHA_INDUSTRIAL]
      ,[CAPACIDADE]
  FROM LDR.DRVAREJO.DBO.[PRODUTIV_LINHA_INDUSTRIAL] A
WHERE NOT EXISTS (SELECT * FROM PRODUTIV_LINHA_INDUSTRIAL B WHERE B.LINHA_INDUSTRIAL=A.LINHA_INDUSTRIAL)
---

-- 2o

----TIPOS DE RECURSO
INSERT INTO PRODUCAO_RECURSO_TIPOS
SELECT [TIPO_RECURSO]
      ,[UTILIZA_MATERIAIS]
      ,[UTILIZA_PRODUTOS] 
FROM LDR.DRVAREJO.DBO.PRODUCAO_RECURSO_TIPOS A
WHERE NOT EXISTS(SELECT * FROM PRODUCAO_RECURSO_TIPOS B WHERE B.TIPO_RECURSO=A.TIPO_RECURSO)

-- 3o
-- TURNO
INSERT INTO TURNO
SELECT [TURNO]
      ,[DESC_TURNO]
  FROM LDR.DRVAREJO.DBO.[TURNO] A
WHERE NOT EXISTS (SELECT * FROM [TESTES].[dbo].[TURNO] B WHERE B.TURNO=A.TURNO)

-- 4o
------RECURSOS PRODUTIVOS       
INSERT INTO PRODUCAO_RECURSOS
SELECT [RECURSO_PRODUTIVO]
      ,[DESC_RECURSO]
      ,[RECURSO_PROPRIO]
      ,[TEMPO_ACRESCENTAR]
      ,[UNIDADE_TEMPO]
      ,[RECURSO_INFINITO]
      ,'DR VAREJO'  -- NOME CLIFOR 
      ,[TIPO_RECURSO]
      ,[OBS]
      ,[UTILIZA_MATERIAIS]
      ,[UTILIZA_PRODUTOS]
      ,[TURNO]
      ,[EFICIENCIA]
      ,[CENTRO_CUSTO]
      ,[QTDE_MAQUINAS]
      ,'21' -- CENTRO DE CUSTO
  FROM LDR.DRVAREJO.DBO.[PRODUCAO_RECURSOS] A
WHERE NOT EXISTS(SELECT * FROM PRODUCAO_RECURSOS B WHERE B.RECURSO_PRODUTIVO=A.RECURSO_PRODUTIVO)


-- 5o
------- FASE
INSERT INTO PRODUCAO_FASE
SELECT [FASE_PRODUCAO]
      ,[DESC_FASE_PRODUCAO]
      ,[SEQUENCIA_PRODUTIVA]
      ,[FALTA_MATERIAL_BLOQUEIA_OP]
      ,[PERMITE_ALTERAR_PCP]
  FROM LDR.DRVAREJO.DBO.PRODUCAO_FASE A
WHERE not EXISTS (SELECT * FROM PRODUCAO_FASE B WHERE B.FASE_PRODUCAO=A.FASE_PRODUCAO)
and fase_producao in (
'001',                      
'002',                     
'003',                     
'004',                      
'004.1',                    
'005',                      
'006',                      
'006.1',                    
'007',                      
'008',                      
'009',                     
'010')                      


-- 6o
------- SETOR

INSERT INTO PRODUCAO_SETOR
SELECT [FASE_PRODUCAO]
      ,[SETOR_PRODUCAO]
      ,[DESC_SETOR_PRODUCAO]
      ,[TIPO_TAREFA_SUGERIDO]
      ,[CTRL_VAC]
  FROM LDR.DRVAREJO.DBO.[PRODUCAO_SETOR] A
WHERE NOT EXISTS (SELECT * FROM PRODUCAO_SETOR B WHERE B.SETOR_PRODUCAO=A.SETOR_PRODUCAO AND B.FASE_PRODUCAO=A.FASE_PRODUCAO)
and fase_producao in (
'001',                      
'002',                     
'003',                     
'004',                      
'004.1',                    
'005',                      
'006',                      
'006.1',                    
'007',                      
'008',                      
'009',                     
'010')                      


-- 7o
--- PRODUTO_SETOR_CUSTO

INSERT INTO PRODUTO_SETOR_CUSTO
SELECT [FASE_PRODUCAO]
      ,[SETOR_PRODUCAO]
      ,'V'+[LINHA_INDUSTRIAL]
      ,[UNIDADE_TEMPO]
      ,[CUSTO_SUGERIDO] 
FROM LDR.DRVAREJO.DBO.PRODUTO_SETOR_CUSTO A
WHERE NOT EXISTS(SELECT * FROM PRODUTO_SETOR_CUSTO B WHERE B.FASE_PRODUCAO=A.FASE_PRODUCAO AND B.SETOR_PRODUCAO=A.SETOR_PRODUCAO AND B.LINHA_INDUSTRIAL=A.LINHA_INDUSTRIAL)


-- 8o

--- RECURSO E FASES
INSERT INTO PRODUCAO_RECURSOS_FASE
SELECT [RECURSO_PRODUTIVO]
      ,[FASE_PRODUCAO]
      ,[ORDEM_SELECAO]
  FROM LDR.DRVAREJO.DBO.[PRODUCAO_RECURSOS_FASE] A
WHERE NOT EXISTS(SELECT * FROM PRODUCAO_RECURSOS_FASE B WHERE B.RECURSO_PRODUTIVO=A.RECURSO_PRODUTIVO AND B.FASE_PRODUCAO=A.FASE_PRODUCAO)
and fase_producao in (
'001',                      
'002',                     
'003',                     
'004',                      
'004.1',                    
'005',                      
'006',                      
'006.1',                    
'007',                      
'008',                      
'009',                     
'010')                      


-- 9o
--- APARELHOS
INSERT INTO PRODUTIV_APARELHOS
SELECT [APARELHO]
      ,[DESC_APARELHO]
      ,[LARGURA]
      ,[OBS]
  FROM LDR.DRVAREJO.DBO.[PRODUTIV_APARELHOS] A
WHERE NOT EXISTS (SELECT * FROM PRODUTIV_APARELHOS B WHERE B.APARELHO=A.APARELHO)


-- 10o
--- GRUPO
SELECT 'VAREJO-'+[GRUPO_PRODUTO] AS GRUPO_PRODUTO
       --,'V'+CHAR(CODIGO_GRUPO+65)   
       ,ROW_NUMBER() OVER(ORDER BY codigo_grupo) AS CODIGO_GRUPO
       ,[DATA_PARA_TRANSFERENCIA]
       ,[VARIA_TEMPO_TAMANHO]
       ,[FECHA_CM_AJUSTE_INFLACAO]
       ,[INATIVO]
INTO #GRUPO FROM LDR.DRVAREJO.DBO.PRODUTOS_GRUPO

INSERT INTO PRODUTOS_GRUPO
SELECT [GRUPO_PRODUTO]
      ,'V'+CHAR(CODIGO_GRUPO+65) AS CODIGO_GRUPO
      ,[DATA_PARA_TRANSFERENCIA]
      ,[VARIA_TEMPO_TAMANHO]
      ,[FECHA_CM_AJUSTE_INFLACAO]
      ,''
      ,''
      ,[INATIVO]
 FROM #GRUPO A

-- 10o
--- SUBGRUPO

INSERT INTO PRODUTOS_SUBGRUPO
SELECT 'VAREJO-'+[GRUPO_PRODUTO]
      ,[SUBGRUPO_PRODUTO]
      ,[CODIGO_SUBGRUPO]
      ,[CODIGO_SEQUENCIAL]
      ,[NUMERO_PARTES_PRODUTO]
      ,[PARTES_DO_PRODUTO]
      ,[PARTES_DO_PRODUTO_COM_DROP]
      ,[Data_para_transferencia]
      ,[GIRO_ENTREGA]
      ,[OP_POR_COR]
      ,[OP_QTDE_MAXIMA]
      ,[OP_QTDE_MINIMA]
      ,[PERC_COMISSAO]
      ,[ACEITA_ENCOMENDA]
      ,[DIAS_GARANTIA_LOJA]
      ,[DIAS_GARANTIA_FABRICANTE]
      ,[INATIVO]
FROM LDR.DRVAREJO.DBO.PRODUTOS_SUBGRUPO A

-- 11o
--- TIPO DE MAQUINA
INSERT INTO PRODUTIV_MAQ_TIPO  
SELECT [TIPO_MAQUINA]
  FROM LDR.DRVAREJO.DBO.[PRODUTIV_MAQ_TIPO] A  
WHERE NOT EXISTS(SELECT * FROM PRODUTIV_MAQ_TIPO B WHERE B.TIPO_MAQUINA=A.TIPO_MAQUINA)  
  

-- 12o
--- MAQUINAS
INSERT INTO PRODUTIV_MAQUINAS
SELECT '9'+SUBSTRING(MAQUINA,2,4)
      ,[DESC_MAQUINA]
      ,[TIPO_MAQUINA]
      ,[QTDE_MAQUINAS]
      ,[PORCENTAGEM_INTERFERENCIA]
  FROM LDR.DRVAREJO.DBO.[PRODUTIV_MAQUINAS]
  

-- 13o
-- PRODUTIV_OPERACOES 

INSERT INTO PRODUTIV_OPERACOES 
SELECT '9'+SUBSTRING(OPERACAO,2,4)
      ,'V'+[LINHA_INDUSTRIAL]
      ,'VAREJO-'+[GRUPO_PRODUTO]
      ,[SUBGRUPO_PRODUTO]
      ,'9'+SUBSTRING(MAQUINA,2,4)
      ,[DESC_OPERACAO]
      ,[TEMPO_FIXO]
      ,[TEMPO_PREVISTO]
      ,[TIPO_OPERACAO]
      ,[CRONOMETRAGEM_1]
      ,[CRONOMETRAGEM_2]
      ,[CRONOMETRAGEM_3]
      ,[CRONOMETRAGEM_4]
      ,[CRONOMETRAGEM_5]
      ,[CRONOMETRAGEM_6]
      ,[CRONOMETRAGEM_7]
      ,[CRONOMETRAGEM_8]
      ,[PONTOS_POLEGADA]
      ,[CRONOMETRISTA]
      ,[CRONOMETRADO]
      ,[FOTO_DESENHO]
      ,[PARTE_PRODUTO]
      ,[FASE_PRODUCAO]
      ,NULL
      ,[TEMPO_PREVISTO_2]
      ,[TEMPO_PREVISTO_3]
      ,[TEMPO_PREVISTO_4]
      ,[APARELHO]
      ,[TEMPO_OPERACAO]
      ,[TEMPO_MAQUINA_1]
      ,[TEMPO_MAQUINA_2]
      ,[TEMPO_MAQUINA_3]
      ,[TEMPO_MAQUINA_4]
      ,[RPM]
      ,[MEDIDA_COSTURA_1]
      ,[MEDIDA_COSTURA_2]
      ,[MEDIDA_COSTURA_3]
      ,[MEDIDA_COSTURA_4]
      ,[CONCESSAO]
      ,[INTERFERENCIA_MANUAL]
      ,[INTERFERENCIA_MAQUINA]
  FROM LDR.DRVAREJO.DBO.PRODUTIV_OPERACOES


-- 14o
--- TOLERANCIAS
INSERT INTO PRODUTIV_TOLERANCIAS
SELECT [TOLERANCIA]
      ,[INDICE_TOLERANCIA]
FROM LDR.DRVAREJO.DBO.PRODUTIV_TOLERANCIAS A
WHERE NOT EXISTS(SELECT * FROM PRODUTIV_TOLERANCIAS B WHERE B.TOLERANCIA=A.TOLERANCIA)


-- 15o
--- TAB OPERACOES
INSERT INTO PRODUTOS_TAB_OPERACOES
SELECT 'V'+[TABELA_OPERACOES]
      ,[TOLERANCIA]
      ,'VAREJO-'+[GRUPO_PRODUTO]
      ,'V'+[LINHA_INDUSTRIAL]
      ,[DESCRICAO_TABELA]
      ,[QTDE_LOTE_ECONOMICO]
      ,[OBS]
      ,[TEMPO_TOTAL]
      ,[TEMPO_TOTAL_FIXO]
      ,[POSSUI_OPERACOES_CRONOMETRADAS]
      ,[POSSUI_ROTAS_PRODUTIVAS]
      ,[UTILIZA_QTDE_DA_OP_NO_LOTE]
      ,[TEMPO_TOTAL_2]
      ,[TEMPO_TOTAL_3]
      ,[TEMPO_TOTAL_4]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[ROTA_CONSERTO]
FROM LDR.DRVAREJO.DBO.PRODUTOS_TAB_OPERACOES A


-- 16o
--- PRODUTOS OPERACOES
INSERT INTO PRODUTOS_OPERACOES
SELECT '9'+SUBSTRING(OPERACAO,2,4)
      ,'V'+[TABELA_OPERACOES]
      ,[SEQUENCIA]
      ,[TEMPO_CRONOMETRADO]
      ,[TEMPO_CRONOM_FIXO]
      ,[MEDIDA_COSTURA]
      ,[PONTOS_POLEGADA]
      ,[OPERACAO_ANTERIOR]
      ,[FASE_PRODUCAO]
      ,[SETOR_PRODUCAO]
      ,[PARTE_PRODUTO]
      ,[TEMPO_CRONOMETRADO_2]
      ,[TEMPO_CRONOMETRADO_3]
      ,[TEMPO_CRONOMETRADO_4]
      ,[MEDIDA_COSTURA_2]
      ,[MEDIDA_COSTURA_3]
      ,[MEDIDA_COSTURA_4]
      ,[PORC_INTER_MANUAL]
      ,[PORC_INTER_GERAL]
      ,[TEMPO_OPERACAO]
      ,[TEMPO_MAQUINA_1]
      ,[TEMPO_MAQUINA_2]
      ,[TEMPO_MAQUINA_3]
      ,[TEMPO_MAQUINA_4]
      ,[RPM]
      ,[APARELHO]
FROM LDR.DRVAREJO.DBO.PRODUTOS_OPERACOES A

-- 17o
--- ROTAS PRODUTIVAS
INSERT INTO PRODUTO_OPERACOES_ROTAS
SELECT 'V'+[TABELA_OPERACOES] AS TABELA_OPERACOES
      ,[ROTA_PRODUCAO]
      ,[FASE_PRODUCAO]
      ,[SETOR_PRODUCAO]
      ,[SEQUENCIA_PRODUTIVA]
      ,[SEQUENCIA_ANTERIOR]
      ,[SETOR_PARALELO_NUMERO]
      ,[RECURSO_PRODUTIVO]
      ,[TEMPO_OPERACAO]
      ,[TEMPO_PREPARACAO]
      ,[UNIDADE_TEMPO]
      ,[CUSTO_SUGERIDO]
      ,[TIPO_TEMPO_PROCESSO]
      ,[METODO_LOTE]
      ,[METODO_LOTE_QTDE]
      ,[CONTROLE]
      ,[BAIXA_AUTOMATICA_MATERIAL]
      ,[PARTE_PRODUTO]
      ,[TEMPO_CRONOMETRADO]
      ,[TEMPO_CRONOM_FIXO]
      ,[TEMPO_CRONOMETRADO_2]
      ,[TEMPO_CRONOMETRADO_3]
      ,[TEMPO_CRONOMETRADO_4]
      ,[CUSTO_SUGERIDO_2]
      ,[CUSTO_SUGERIDO_3]
      ,[CUSTO_SUGERIDO_4]
      ,[SUBGRUPO_PRODUTO]
      ,[TIPO_CUSTO]
 FROM LDR.DRVAREJO.DBO.PRODUTO_OPERACOES_ROTAS A
WHERE NOT EXISTS(SELECT * FROM PRODUTO_OPERACOES_ROTAS B WHERE B.TABELA_OPERACOES=A.TABELA_OPERACOES AND B.ROTA_PRODUCAO=A.ROTA_PRODUCAO AND B.FASE_PRODUCAO=A.FASE_PRODUCAO AND B.SETOR_PRODUCAO=A.SETOR_PRODUCAO) --AND A.TABELA_OPERACOES='2084'
AND  A.fase_producao in (
'001',                      
'002',                     
'003',                     
'004',                      
'004.1',                    
'005',                      
'006',                      
'006.1',                    
'007',                      
'008',                      
'009',                     
'010')                      

--- o que deve ainda ser feito!
--- cadastro de beneficiador para os recursos
--- altera��o do centro de custos para os recursos
--- altera��o do grupo, rota e subgrupo de produtos

---- N�O UTILIZA MAIS
---- RECURSO CUSTO
INSERT INTO PRODUCAO_RECURSO_CUSTO
SELECT [FASE_PRODUCAO]
      ,[SETOR_PRODUCAO]
      ,[RECURSO_PRODUTIVO]
      ,'V'+[LINHA_INDUSTRIAL]
      ,[CUSTO_SUGERIDO]
  FROM LDR.DRVAREJO.DBO.[PRODUCAO_RECURSO_CUSTO] A
ORDER BY FASE_PRODUCAO
  
WHERE NOT EXISTS(SELECT * FROM PRODUCAO_RECURSO_CUSTO B WHERE B.FASE_PRODUCAO=A.FASE_PRODUCAO)
and fase_producao in (
'001',                      
'002',                     
'003',                     
'004',                      
'004.1',                    
'005',                      
'006',                      
'006.1',                    
'007',                      
'008',                      
'009',                     
'010')                      


select * from PRODUTOS
WHERE PRODUTO='V52252'
