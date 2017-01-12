--- 1o 
--- GRADES TAMANHOS
INSERT INTO PRODUTOS_TAMANHOS ([GRADE]
      ,[NUMERO_TAMANHOS]
      ,[NUMERO_QUEBRAS]
      ,[QUEBRA_1]
      ,[QUEBRA_2]
      ,[QUEBRA_3]
      ,[QUEBRA_4]
      ,[QUEBRA_5]
      ,[TAMANHO_1]
      ,[TAMANHO_2]
      ,[TAMANHO_3]
      ,[TAMANHO_4]
      ,[TAMANHO_5]
      ,[TAMANHO_6]
      ,[TAMANHO_7]
      ,[TAMANHO_8]
      ,[TAMANHO_9]
      ,[TAMANHO_10]
      ,[TAMANHO_11]
      ,[TAMANHO_12]
      ,[TAMANHO_13]
      ,[TAMANHO_14]
      ,[TAMANHO_15]
      ,[TAMANHO_16]
      ,[TAMANHO_17]
      ,[TAMANHO_18]
      ,[TAMANHO_19]
      ,[TAMANHO_20]
      ,[TAMANHO_21]
      ,[TAMANHO_22]
      ,[TAMANHO_23]
      ,[TAMANHO_24]
      ,[TAMANHO_25]
      ,[TAMANHO_26]
      ,[TAMANHO_27]
      ,[TAMANHO_28]
      ,[TAMANHO_29]
      ,[TAMANHO_30]
      ,[TAMANHO_31]
      ,[TAMANHO_32]
      ,[TAMANHO_33]
      ,[TAMANHO_34]
      ,[TAMANHO_35]
      ,[TAMANHO_36]
      ,[TAMANHO_37]
      ,[TAMANHO_38]
      ,[TAMANHO_39]
      ,[TAMANHO_40]
      ,[TAMANHO_41]
      ,[TAMANHO_42]
      ,[TAMANHO_43]
      ,[TAMANHO_44]
      ,[TAMANHO_45]
      ,[TAMANHO_46]
      ,[TAMANHO_47]
      ,[TAMANHO_48]
      ,[GRADE_BASE]
      ,[TAMANHOS_DIGITADOS]
      ,[GRADE_CODIGO]
      ,[LX_STATUS_REGISTRO])
SELECT 'V'+A.[GRADE]
      ,[NUMERO_TAMANHOS]
      ,[NUMERO_QUEBRAS]
      ,[QUEBRA_1]
      ,[QUEBRA_2]
      ,[QUEBRA_3]
      ,[QUEBRA_4]
      ,[QUEBRA_5]
      ,[TAMANHO_1]
      ,[TAMANHO_2]
      ,[TAMANHO_3]
      ,[TAMANHO_4]
      ,[TAMANHO_5]
      ,[TAMANHO_6]
      ,[TAMANHO_7]
      ,[TAMANHO_8]
      ,[TAMANHO_9]
      ,[TAMANHO_10]
      ,[TAMANHO_11]
      ,[TAMANHO_12]
      ,[TAMANHO_13]
      ,[TAMANHO_14]
      ,[TAMANHO_15]
      ,[TAMANHO_16]
      ,[TAMANHO_17]
      ,[TAMANHO_18]
      ,[TAMANHO_19]
      ,[TAMANHO_20]
      ,[TAMANHO_21]
      ,[TAMANHO_22]
      ,[TAMANHO_23]
      ,[TAMANHO_24]
      ,[TAMANHO_25]
      ,[TAMANHO_26]
      ,[TAMANHO_27]
      ,[TAMANHO_28]
      ,[TAMANHO_29]
      ,[TAMANHO_30]
      ,[TAMANHO_31]
      ,[TAMANHO_32]
      ,[TAMANHO_33]
      ,[TAMANHO_34]
      ,[TAMANHO_35]
      ,[TAMANHO_36]
      ,[TAMANHO_37]
      ,[TAMANHO_38]
      ,[TAMANHO_39]
      ,[TAMANHO_40]
      ,[TAMANHO_41]
      ,[TAMANHO_42]
      ,[TAMANHO_43]
      ,[TAMANHO_44]
      ,[TAMANHO_45]
      ,[TAMANHO_46]
      ,[TAMANHO_47]
      ,[TAMANHO_48]
      ,'V'+[GRADE_BASE]
      ,[TAMANHOS_DIGITADOS]
      ,[GRADE_CODIGO]
      ,A.[LX_STATUS_REGISTRO]
 FROM LDR.DRVAREJO.DBO.PRODUTOS_TAMANHOS A
WHERE A.GRADE IN (
'38 A 46',         
'40 A 44',
'40 A 46',
'40 A 48',
'40 A 52',
'42 A 46',
'42 A 48',
'42 A 50',
'42 A 52',
'42B A 52C',
'44 A 50',
'44 A 54',                
'44ABC A 50BC',             
'44B A 50D',
'50 A 52',              
'50 A 54',            
'50 A 56',            
'50 AO 54',           
'50A52',           
'50B A 54D',
'GG A EEG',              
'GG E  EG',            
'GG E EG',           
'P A EEG',           
'P A EG',
'P A G',
'P A G - 40 A 46',
'P A GG',
'P A GG-42 A 46',
'P A GG-42 A 48',
'P AO EEG',    
'P AO EG',     
'TAMANHO UNICO',
'UNICO',
'44ABC A 54CD',             
'50A52',                    
'50BC A 54CD',              
'CALCINHAS',
'GG',                       
'SOUTIEN',                  
'SOUTIEN COM COPA',
'TAMANHO UNICO'
)
--WHERE NOT EXISTS (SELECT * FROM PRODUTOS_TAMANHOS B WHERE B.GRADE=A.GRADE)

--- 2o
--- PRODUTOS FORA DE LINHA COM ESTOQUE
INSERT INTO 
PRODUTOS(
       [PRODUTO]
      ,[CODIGO_PRECO]
      ,[MATERIAL]
      ,[PERIODO_PCP]
      ,[TABELA_OPERACOES]
      ,[FATOR_OPERACOES]
      ,[CLASSIF_FISCAL]
      ,[TIPO_PRODUTO]
      ,[TABELA_MEDIDAS]
      ,[DESC_PRODUTO]
      ,[GRUPO_PRODUTO]
      ,[SUBGRUPO_PRODUTO]
      ,[COLECAO]
      ,[GRADE]
      ,[DESC_PROD_NF]
      ,[LINHA]
      ,[GRIFFE]
      ,[CARTELA]
      ,[UNIDADE]
      ,[PESO]
      ,[REVENDA]
      ,[REFER_FABRICANTE]
      ,[MODELAGEM]
      ,[SORTIMENTO_COR]
      ,[FABRICANTE]
      ,[SORTIMENTO_TAMANHO]
      ,[VARIA_PRECO_COR]
      ,[VARIA_PRECO_TAM]
      ,[PONTEIRO_PRECO_TAM]
      ,[VARIA_CUSTO_COR]
      ,[PERTENCE_A_CONJUNTO]
      ,[TRIBUT_ICMS]
      ,[TRIBUT_ORIGEM]
      ,[VARIA_CUSTO_TAM]
      ,[CUSTO_REPOSICAO1]
      ,[CUSTO_REPOSICAO2]
      ,[CUSTO_REPOSICAO3]
      ,[CUSTO_REPOSICAO4]
      ,[DATA_REPOSICAO]
      ,[ESTILISTA]
      ,[MODELISTA]
      ,[TAMANHO_BASE]
      ,[GIRO_ENTREGA]
      ,[INATIVO]
      ,[ENVIA_LOJA_VAREJO]
      ,[ENVIA_LOJA_ATACADO]
      ,[ENVIA_REPRESENTANTE]
      ,[ENVIA_VAREJO_INTERNET]
      ,[ENVIA_ATACADO_INTERNET]
      ,[MODELO]
      ,[REDE_LOJAS]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[FABRICANTE_ICMS_ABATER]
      ,[FABRICANTE_PRAZO_PGTO]
      ,[TAXA_JUROS_DEFLACIONAR]
      ,[TAXAS_IMPOSTOS_APLICAR]
      ,[PRECO_REPOSICAO_1]
      ,[PRECO_REPOSICAO_2]
      ,[PRECO_REPOSICAO_3]
      ,[PRECO_REPOSICAO_4]
      ,[PRECO_A_VISTA_REPOSICAO_1]
      ,[PRECO_A_VISTA_REPOSICAO_2]
      ,[PRECO_A_VISTA_REPOSICAO_3]
      ,[PRECO_A_VISTA_REPOSICAO_4]
      ,[FABRICANTE_FRETE]
      ,[DROP_DE_TAMANHOS]
      ,[DATA_CADASTRAMENTO]
      ,[STATUS_PRODUTO]
      ,[TIPO_STATUS_PRODUTO]
      ,[OBS]
      ,[COMPOSICAO]
      ,[RESTRICAO_LAVAGEM]
      ,[EMPRESA]
      ,[ORCAMENTO]
      ,[CLIENTE_DO_PRODUTO]
      ,[CONTA_CONTABIL]
      ,[ESPESSURA]
      ,[ALTURA]
      ,[LARGURA]
      ,[COMPRIMENTO]
      ,[EMPILHAMENTO_MAXIMO]
      ,[SEXO_TIPO]
      ,[PARTE_TIPO]
      ,[OP_QTDE_MINIMA]
      ,[OP_QTDE_MAXIMA]
      ,[OP_POR_COR]
      ,[INDICADOR_CFOP]
      ,[ID_EXCECAO_IMPOSTO]
      ,[QUALIDADE]
      ,[MONTAGEM_KIT]
      ,[VERSAO_FICHA]
      ,[SEMI_ACABADO]
      ,[MRP_AGRUPAR_NECESSIDADE_TIPO]
      ,[MRP_AGRUPAR_NECESSIDADE_DIAS]
      ,[MRP_MAIOR_GIRO_MP_DIAS]
      ,[MRP_EMISSAO_LIBERACAO_DIAS]
      ,[MRP_ENTREGA_GIRO_DIAS]
      ,[MRP_DIAS_SEGURANCA]
      ,[COD_FLUXO_PRODUTO]
      ,[DATA_INICIO_DESENVOLVIMENTO]
      ,[MRP_PARTICIPANTE]
      ,[CONTA_CONTABIL_COMPRA]
      ,[CONTA_CONTABIL_VENDA]
      ,[CONTA_CONTABIL_DEV_COMPRA]
      ,[CONTA_CONTABIL_DEV_VENDA]
      ,[ID_EXCECAO_GRUPO]
      ,[DIAS_COMPRA]
      ,[FATOR_P]
      ,[FATOR_Q]
      ,[FATOR_F]
      ,[CONTINUIDADE]
      ,[COD_CATEGORIA]
      ,[COD_SUBCATEGORIA]
      ,[COD_PRODUTO_SOLUCAO]
      ,[COD_PRODUTO_SEGMENTO]
      ,[ID_PRECO]
      ,[TIPO_ITEM_SPED]
      ,[PERC_COMISSAO]
      ,[ACEITA_ENCOMENDA]
      ,[DIAS_GARANTIA_LOJA]
      ,[DIAS_GARANTIA_FABRICANTE]
      ,[POSSUI_MONTAGEM]
      ,[POSSUI_GTIN]
      ,[PERMITE_ENTREGA_FUTURA]
      ,[NATUREZA_RECEITA]
      ,[COD_ALIQUOTA_PIS_COFINS_DIF]
      ,[DATA_LIMITE_PEDIDO]
      ,[LX_STATUS_REGISTRO]
)
SELECT 'V'+A.[PRODUTO]
      ,''
      ,null
      ,null
      ,null
      ,[FATOR_OPERACOES]
      ,'3926.20.00'
      ,'INDEFINIDO'
      ,null
      ,[DESC_PRODUTO]
      ,'VAREJO-'+[GRUPO_PRODUTO]
      ,[SUBGRUPO_PRODUTO]
      ,'000001'
      ,'V'+[GRADE]
      ,[DESC_PROD_NF]
      ,'INDEFINIDA'               
      ,'DELRIO LINHA NORMAL'
      ,''
      ,'PC'
      ,[PESO]
      ,[REVENDA]
      ,[REFER_FABRICANTE]
      ,[MODELAGEM]
      ,[SORTIMENTO_COR]
      ,[FABRICANTE]
      ,[SORTIMENTO_TAMANHO]
      ,[VARIA_PRECO_COR]
      ,[VARIA_PRECO_TAM]
      ,[PONTEIRO_PRECO_TAM]
      ,[VARIA_CUSTO_COR]
      ,[PERTENCE_A_CONJUNTO]
      ,[TRIBUT_ICMS]
      ,[TRIBUT_ORIGEM]
      ,[VARIA_CUSTO_TAM]
      ,[CUSTO_REPOSICAO1]
      ,[CUSTO_REPOSICAO2]
      ,[CUSTO_REPOSICAO3]
      ,[CUSTO_REPOSICAO4]
      ,[DATA_REPOSICAO]
      ,[ESTILISTA]
      ,[MODELISTA]
      ,[TAMANHO_BASE]
      ,[GIRO_ENTREGA]
      ,[INATIVO]
      ,[ENVIA_LOJA_VAREJO]
      ,[ENVIA_LOJA_ATACADO]
      ,[ENVIA_REPRESENTANTE]
      ,[ENVIA_VAREJO_INTERNET]
      ,[ENVIA_ATACADO_INTERNET]
      ,[MODELO]
      ,null
      ,A.[DATA_PARA_TRANSFERENCIA]
      ,[FABRICANTE_ICMS_ABATER]
      ,[FABRICANTE_PRAZO_PGTO]
      ,[TAXA_JUROS_DEFLACIONAR]
      ,[TAXAS_IMPOSTOS_APLICAR]
      ,[PRECO_REPOSICAO_1]
      ,[PRECO_REPOSICAO_2]
      ,[PRECO_REPOSICAO_3]
      ,[PRECO_REPOSICAO_4]
      ,[PRECO_A_VISTA_REPOSICAO_1]
      ,[PRECO_A_VISTA_REPOSICAO_2]
      ,[PRECO_A_VISTA_REPOSICAO_3]
      ,[PRECO_A_VISTA_REPOSICAO_4]
      ,[FABRICANTE_FRETE]
      ,[DROP_DE_TAMANHOS]
      ,[DATA_CADASTRAMENTO]
      ,[STATUS_PRODUTO]
      ,[TIPO_STATUS_PRODUTO]
      ,[OBS]
      ,null
      ,null
      ,[EMPRESA]
      ,[ORCAMENTO]
      ,null
      ,'1140101'
      ,[ESPESSURA]
      ,[ALTURA]
      ,[LARGURA]
      ,[COMPRIMENTO]
      ,[EMPILHAMENTO_MAXIMO]
      ,[SEXO_TIPO]
      ,[PARTE_TIPO]
      ,[OP_QTDE_MINIMA]
      ,[OP_QTDE_MAXIMA]
      ,[OP_POR_COR]
      ,[INDICADOR_CFOP]
      ,[ID_EXCECAO_IMPOSTO]
      ,[QUALIDADE]
      ,[MONTAGEM_KIT]
      ,[VERSAO_FICHA]
      ,[SEMI_ACABADO]
      ,[MRP_AGRUPAR_NECESSIDADE_TIPO]
      ,[MRP_AGRUPAR_NECESSIDADE_DIAS]
      ,[MRP_MAIOR_GIRO_MP_DIAS]
      ,[MRP_EMISSAO_LIBERACAO_DIAS]
      ,[MRP_ENTREGA_GIRO_DIAS]
      ,[MRP_DIAS_SEGURANCA]
      ,[COD_FLUXO_PRODUTO]
      ,[DATA_INICIO_DESENVOLVIMENTO]
      ,[MRP_PARTICIPANTE]
      ,'1140101'
      ,'3110101'
      ,'1140101'
      ,'3210101'
      ,[ID_EXCECAO_GRUPO]
      ,[DIAS_COMPRA]
      ,[FATOR_P]
      ,[FATOR_Q]
      ,[FATOR_F]
      ,[CONTINUIDADE]
      ,[COD_CATEGORIA]
      ,[COD_SUBCATEGORIA]
      ,[COD_PRODUTO_SOLUCAO]
      ,[COD_PRODUTO_SEGMENTO]
      ,[ID_PRECO]
      ,[TIPO_ITEM_SPED]
      ,[PERC_COMISSAO]
      ,[ACEITA_ENCOMENDA]
      ,[DIAS_GARANTIA_LOJA]
      ,[DIAS_GARANTIA_FABRICANTE]
      ,[POSSUI_MONTAGEM]
      ,[POSSUI_GTIN]
      ,[PERMITE_ENTREGA_FUTURA]
      ,[NATUREZA_RECEITA]
      ,[COD_ALIQUOTA_PIS_COFINS_DIF]
      ,[DATA_LIMITE_PEDIDO]
      ,A.[LX_STATUS_REGISTRO]
--SELECT DISTINCT A.PRODUTO      
FROM LDR.DRVAREJO.DBO.PRODUTOS A
--JOIN LDR.DRVAREJO.DBO.ESTOQUE_PRODUTOS C ON C.PRODUTO=A.PRODUTO
--WHERE A.COD_CATEGORIA='02' AND A.COD_SUBCATEGORIA='02' AND C.ESTOQUE>1 AND C.FILIAL IN('FORA DE LINHA','LD') AND NOT EXISTS (
--SELECT * FROM PRODUTOS B WHERE B.PRODUTO=A.PRODUTO)
WHERE PRODUTO IN(
'12337        ',
'20847        ',
'30111        ',
'30112        ',
'30113        ',
'30114        ',
'30115        ',
'30269        ',
'30901        ',
'30909        ',
'32018        ',
'32021        ',
'32022        ',
'32112        ',
'33101        ',
'33103        ',
'33104        ',
'33105        ',
'33106        ',
'33107        ',
'33109        ',
'33110        ',
'33111        ',
'33113        ',
'33114        ',
'33268        ',
'33574        ',
'33820        ',
'33822        ',
'33904        ',
'33913        ',
'35107        ',
'35113        ',
'400027       ',
'400407       ',
'40120        ',
'40156        ',
'40312        ',
'40319        ',
'40360        ',
'40369        ',
'40370        ',
'40371        ',
'40458        ',
'40512        ',
'406037       ',
'406057       ',
'40607.1      ',
'40611        ',
'40640        ',
'406447       ',
'407077       ',
'40709        ',
'40820PLUS    ',
'40823        ',
'40901        ',
'40901 B      ',
'40901 G      ',
'40909        ',
'40910        ',
'41006        ',
'41166        ',
'41811        ',
'41903        ',
'42004        ',
'42118        ',
'421507       ',
'421517       ',
'42152        ',
'421547       ',
'42156        ',
'42166        ',
'42174        ',
'42218        ',
'42250        ',
'42254        ',
'42260.1      ',
'42261        ',
'42311        ',
'42312        ',
'42313        ',
'42333        ',
'42361        ',
'42365        ',
'42366        ',
'42370        ',
'42375        ',
'42450        ',
'42451        ',
'42453        ',
'42454        ',
'42455        ',
'42456        ',
'42458        ',
'42463        ',
'42468        ',
'42500        ',
'42504        ',
'42505        ',
'42513        ',
'42607        ',
'42615        ',
'42617        ',
'42618        ',
'42711        ',
'42719        ',
'42719 PLUS   ',
'42811        ',
'42902        ',
'42902.1      ',
'42903        ',
'42905        ',
'42906        ',
'42909        ',
'429117       ',
'42915        ',
'42916        ',
'43003        ',
'43005        ',
'43167        ',
'43203        ',
'43262        ',
'43366        ',
'436017       ',
'43640        ',
'44005        ',
'44027        ',
'44028        ',
'44167        ',
'441687       ',
'44262        ',
'44375        ',
'44450        ',
'44607        ',
'44640        ',
'44706        ',
'44818        ',
'44903        ',
'45015        ',
'45016        ',
'45165        ',
'45166        ',
'45170        ',
'45218        ',
'45255        ',
'45311        ',
'45313        ',
'45333        ',
'45353        ',
'45362        ',
'45365        ',
'45450        ',
'45451        ',
'45453        ',
'45454        ',
'45455        ',
'45456        ',
'45500        ',
'45504        ',
'45505        ',
'45827        ',
'45829        ',
'46027        ',
'47167        ',
'47375        ',
'47463        ',
'47501        ',
'47716        ',
'47902        ',
'48027        ',
'48112        ',
'48817        ',
'49166        ',
'500407       ',
'501517       ',
'501547       ',
'50166        ',
'50167        ',
'50173        ',
'50250        ',
'50254        ',
'50366        ',
'50468        ',
'50512        ',
'50516        ',
'50615        ',
'50640        ',
'507077       ',
'50709        ',
'50719        ',
'50820        ',
'50823        ',
'50902        ',
'50905        ',
'50906        ',
'50906 PLUS   ',
'50911        ',
'51002        ',
'510027       ',
'51015        ',
'51015 DUO    ',
'51118        ',
'51120        ',
'511507       ',
'51152        ',
'51156        ',
'51158 DUO    ',
'51159        ',
'51159 DUO    ',
'51165        ',
'51170        ',
'51173        ',
'51174        ',
'51175        ',
'51218        ',
'51254        ',
'51258        ',
'51311        ',
'51312        ',
'51313        ',
'51333        ',
'51353        ',
'51360        ',
'51361        ',
'51362        ',
'51365        ',
'51370        ',
'51374        ',
'51375        ',
'51450        ',
'51451        ',
'51453        ',
'51454        ',
'51455        ',
'51456        ',
'51458        ',
'51463        ',
'51504        ',
'51505        ',
'51513        ',
'51602        ',
'51607.1      ',
'51613 K-1GG  ',
'51613 K-1P   ',
'51615        ',
'51628        ',
'51629        ',
'51629K1-G    ',
'51706        ',
'51718        ',
'51725        ',
'51806-FARM   ',
'51806-PACK   ',
'51823        ',
'51827        ',
'519017       ',
'51902        ',
'51911        ',
'51911 PLUS   ',
'519117       ',
'51912        ',
'52118        ',
'52120        ',
'52152        ',
'52156        ',
'52157        ',
'52158        ',
'52158 DUO    ',
'52159        ',
'52159 DUO    ',
'52167        ',
'52174        ',
'52218        ',
'52255        ',
'52258        ',
'52311        ',
'52312        ',
'52313        ',
'52333        ',
'52360        ',
'52365        ',
'52369        ',
'52375        ',
'52450        ',
'52451        ',
'52453        ',
'52454        ',
'52455        ',
'52456        ',
'52458        ',
'52463        ',
'52500        ',
'52504        ',
'52505        ',
'52513        ',
'52607        ',
'52613 K-1G   ',
'52613 K-1M   ',
'52618        ',
'52620        ',
'52629K1-G    ',
'52709        ',
'52801        ',
'52805        ',
'52811        ',
'52813        ',
'52824        ',
'52829        ',
'52903        ',
'52916        ',
'530277       ',
'53213        ',
'53262        ',
'536037       ',
'536057       ',
'53816        ',
'538167       ',
'53820PLUS    ',
'54004        ',
'54365        ',
'54375        ',
'54909        ',
'55027        ',
'550277       ',
'55213        ',
'56027        ',
'560277       ',
'56166        ',
'56820        ',
'57003        ',
'57005        ',
'57006        ',
'57007        ',
'57011        ',
'57118        ',
'57120        ',
'57157        ',
'57218        ',
'57255        ',
'57311        ',
'57312        ',
'57313        ',
'57333        ',
'57500        ',
'57504        ',
'57505        ',
'57513        ',
'57607        ',
'57618        ',
'57711        ',
'57718        ',
'57805        ',
'57811        ',
'57814        ',
'57902        ',
'57903        ',
'57909        ',
'57916        ',
'59006        ',
'59903        ',
'59911        ',
'599117       ',
'60901        ')


--- 3o
INSERT CORES_BASICAS
SELECT [COR]
      ,[DESC_COR]
      ,[USO_PRODUTOS]
      ,[USO_MATERIAIS]
      ,[GRUPO_CORES]
      ,[COR_SORTIDA]
      ,[COR_RGB]
      ,[DATA_PARA_TRANSFERENCIA]
FROM LDR.DRVAREJO.DBO.CORES_BASICAS A
WHERE NOT EXISTS(SELECT * FROM CORES_BASICAS B WHERE B.COR=A.COR)

--- 4o
--- PRODUTO_CORES
INSERT INTO PRODUTO_CORES (
       [PRODUTO]
      ,[COR_PRODUTO]
      ,[SIMILAR]
      ,[DESC_COR_PRODUTO]
      ,[SORTIMENTO_COR]
      ,[COR_SORTIDA]
      ,[STATUS_VENDA_ATUAL]
      ,[INICIO_VENDAS]
      ,[FIM_VENDAS]
      ,[COR_FABRICANTE]
      ,[TIPO_LAVAGEM_TINTURARIA]
      ,[TINTURARIA_LAVAGEM]
      ,[COR]
      ,[MATERIAL]
      ,[COR_MATERIAL]
      ,[ETIQUETA]
      ,[CUSTO_REPOSICAO1]
      ,[CUSTO_REPOSICAO2]
      ,[CUSTO_REPOSICAO3]
      ,[CUSTO_REPOSICAO4]
      ,[VARIANTE_TAMANHO]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[PRECO_REPOSICAO_1]
      ,[PRECO_REPOSICAO_2]
      ,[PRECO_REPOSICAO_3]
      ,[PRECO_REPOSICAO_4]
      ,[PRECO_A_VISTA_REPOSICAO_1]
      ,[PRECO_A_VISTA_REPOSICAO_2]
      ,[PRECO_A_VISTA_REPOSICAO_3]
      ,[PRECO_A_VISTA_REPOSICAO_4]
      ,[COMPOSICAO]
      ,[CLASSIF_FISCAL]
      ,[TRIBUT_ORIGEM]
      ,[LX_STATUS_REGISTRO]
)
SELECT 'V'+[PRODUTO]
      ,[COR_PRODUTO]
      ,[SIMILAR]
      ,[DESC_COR_PRODUTO]
      ,[SORTIMENTO_COR]
      ,[COR_SORTIDA]
      ,[STATUS_VENDA_ATUAL]
      ,[INICIO_VENDAS]
      ,[FIM_VENDAS]
      ,[COR_FABRICANTE]
      ,[TIPO_LAVAGEM_TINTURARIA]
      ,[TINTURARIA_LAVAGEM]
      ,[COR]
      ,NULL
      ,NULL
      ,[ETIQUETA]
      ,[CUSTO_REPOSICAO1]
      ,[CUSTO_REPOSICAO2]
      ,[CUSTO_REPOSICAO3]
      ,[CUSTO_REPOSICAO4]
      ,[VARIANTE_TAMANHO]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[PRECO_REPOSICAO_1]
      ,[PRECO_REPOSICAO_2]
      ,[PRECO_REPOSICAO_3]
      ,[PRECO_REPOSICAO_4]
      ,[PRECO_A_VISTA_REPOSICAO_1]
      ,[PRECO_A_VISTA_REPOSICAO_2]
      ,[PRECO_A_VISTA_REPOSICAO_3]
      ,[PRECO_A_VISTA_REPOSICAO_4]
      ,NULL
      ,'3926.20.00'
      ,[TRIBUT_ORIGEM]
      ,[LX_STATUS_REGISTRO]
FROM LDR.DRVAREJO.DBO.PRODUTO_CORES A
WHERE PRODUTO IN(
'12337        ',
'20847        ',
'30111        ',
'30112        ',
'30113        ',
'30114        ',
'30115        ',
'30269        ',
'30901        ',
'30909        ',
'32018        ',
'32021        ',
'32022        ',
'32112        ',
'33101        ',
'33103        ',
'33104        ',
'33105        ',
'33106        ',
'33107        ',
'33109        ',
'33110        ',
'33111        ',
'33113        ',
'33114        ',
'33268        ',
'33574        ',
'33820        ',
'33822        ',
'33904        ',
'33913        ',
'35107        ',
'35113        ',
'400027       ',
'400407       ',
'40120        ',
'40156        ',
'40312        ',
'40319        ',
'40360        ',
'40369        ',
'40370        ',
'40371        ',
'40458        ',
'40512        ',
'406037       ',
'406057       ',
'40607.1      ',
'40611        ',
'40640        ',
'406447       ',
'407077       ',
'40709        ',
'40820PLUS    ',
'40823        ',
'40901        ',
'40901 B      ',
'40901 G      ',
'40909        ',
'40910        ',
'41006        ',
'41166        ',
'41811        ',
'41903        ',
'42004        ',
'42118        ',
'421507       ',
'421517       ',
'42152        ',
'421547       ',
'42156        ',
'42166        ',
'42174        ',
'42218        ',
'42250        ',
'42254        ',
'42260.1      ',
'42261        ',
'42311        ',
'42312        ',
'42313        ',
'42333        ',
'42361        ',
'42365        ',
'42366        ',
'42370        ',
'42375        ',
'42450        ',
'42451        ',
'42453        ',
'42454        ',
'42455        ',
'42456        ',
'42458        ',
'42463        ',
'42468        ',
'42500        ',
'42504        ',
'42505        ',
'42513        ',
'42607        ',
'42615        ',
'42617        ',
'42618        ',
'42711        ',
'42719        ',
'42719 PLUS   ',
'42811        ',
'42902        ',
'42902.1      ',
'42903        ',
'42905        ',
'42906        ',
'42909        ',
'429117       ',
'42915        ',
'42916        ',
'43003        ',
'43005        ',
'43167        ',
'43203        ',
'43262        ',
'43366        ',
'436017       ',
'43640        ',
'44005        ',
'44027        ',
'44028        ',
'44167        ',
'441687       ',
'44262        ',
'44375        ',
'44450        ',
'44607        ',
'44640        ',
'44706        ',
'44818        ',
'44903        ',
'45015        ',
'45016        ',
'45165        ',
'45166        ',
'45170        ',
'45218        ',
'45255        ',
'45311        ',
'45313        ',
'45333        ',
'45353        ',
'45362        ',
'45365        ',
'45450        ',
'45451        ',
'45453        ',
'45454        ',
'45455        ',
'45456        ',
'45500        ',
'45504        ',
'45505        ',
'45827        ',
'45829        ',
'46027        ',
'47167        ',
'47375        ',
'47463        ',
'47501        ',
'47716        ',
'47902        ',
'48027        ',
'48112        ',
'48817        ',
'49166        ',
'500407       ',
'501517       ',
'501547       ',
'50166        ',
'50167        ',
'50173        ',
'50250        ',
'50254        ',
'50366        ',
'50468        ',
'50512        ',
'50516        ',
'50615        ',
'50640        ',
'507077       ',
'50709        ',
'50719        ',
'50820        ',
'50823        ',
'50902        ',
'50905        ',
'50906        ',
'50906 PLUS   ',
'50911        ',
'51002        ',
'510027       ',
'51015        ',
'51015 DUO    ',
'51118        ',
'51120        ',
'511507       ',
'51152        ',
'51156        ',
'51158 DUO    ',
'51159        ',
'51159 DUO    ',
'51165        ',
'51170        ',
'51173        ',
'51174        ',
'51175        ',
'51218        ',
'51254        ',
'51258        ',
'51311        ',
'51312        ',
'51313        ',
'51333        ',
'51353        ',
'51360        ',
'51361        ',
'51362        ',
'51365        ',
'51370        ',
'51374        ',
'51375        ',
'51450        ',
'51451        ',
'51453        ',
'51454        ',
'51455        ',
'51456        ',
'51458        ',
'51463        ',
'51504        ',
'51505        ',
'51513        ',
'51602        ',
'51607.1      ',
'51613 K-1GG  ',
'51613 K-1P   ',
'51615        ',
'51628        ',
'51629        ',
'51629K1-G    ',
'51706        ',
'51718        ',
'51725        ',
'51806-FARM   ',
'51806-PACK   ',
'51823        ',
'51827        ',
'519017       ',
'51902        ',
'51911        ',
'51911 PLUS   ',
'519117       ',
'51912        ',
'52118        ',
'52120        ',
'52152        ',
'52156        ',
'52157        ',
'52158        ',
'52158 DUO    ',
'52159        ',
'52159 DUO    ',
'52167        ',
'52174        ',
'52218        ',
'52255        ',
'52258        ',
'52311        ',
'52312        ',
'52313        ',
'52333        ',
'52360        ',
'52365        ',
'52369        ',
'52375        ',
'52450        ',
'52451        ',
'52453        ',
'52454        ',
'52455        ',
'52456        ',
'52458        ',
'52463        ',
'52500        ',
'52504        ',
'52505        ',
'52513        ',
'52607        ',
'52613 K-1G   ',
'52613 K-1M   ',
'52618        ',
'52620        ',
'52629K1-G    ',
'52709        ',
'52801        ',
'52805        ',
'52811        ',
'52813        ',
'52824        ',
'52829        ',
'52903        ',
'52916        ',
'530277       ',
'53213        ',
'53262        ',
'536037       ',
'536057       ',
'53816        ',
'538167       ',
'53820PLUS    ',
'54004        ',
'54365        ',
'54375        ',
'54909        ',
'55027        ',
'550277       ',
'55213        ',
'56027        ',
'560277       ',
'56166        ',
'56820        ',
'57003        ',
'57005        ',
'57006        ',
'57007        ',
'57011        ',
'57118        ',
'57120        ',
'57157        ',
'57218        ',
'57255        ',
'57311        ',
'57312        ',
'57313        ',
'57333        ',
'57500        ',
'57504        ',
'57505        ',
'57513        ',
'57607        ',
'57618        ',
'57711        ',
'57718        ',
'57805        ',
'57811        ',
'57814        ',
'57902        ',
'57903        ',
'57909        ',
'57916        ',
'59006        ',
'59903        ',
'59911        ',
'599117       ',
'60901        ')


--- 5o PROPRIEDADES DOS PRODUTOS
---5.1
INSERT INTO TABELA_ADMINISTRACAO
SELECT TABELA FROM LDR.DRVAREJO.DBO.TABELA_ADMINISTRACAO A
WHERE NOT EXISTS(SELECT TABELA FROM TABELA_ADMINISTRACAO B WHERE B.TABELA=A.TABELA)

---5.2
INSERT INTO PROPRIEDADE_GRUPO
SELECT COD_GRUPO,DESC_GRUPO FROM LDR.DRVAREJO.DBO.PROPRIEDADE_GRUPO A
WHERE NOT EXISTS(SELECT * FROM PROPRIEDADE_GRUPO B WHERE B.COD_GRUPO=A.COD_GRUPO)

---5.3 
INSERT INTO PROPRIEDADE
SELECT [DESC_PROPRIEDADE]
      ,[FAIXA_FINAL]
      ,[FAIXA_INICIAL]
      ,[MASCARA_VALOR]
      ,[PROPRIEDADE]
      ,[PROPRIEDADE_REQUERIDA]
      ,[TIPO_PROPRIEDADE]
      ,[TIPO_VALIDACAO]
      ,[DATA_ATIVACAO]
      ,[DATA_DESATIVACAO]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[FILTRO_DE_PROPRIEDADES]
      ,[TITULO_PROPRIEDADE]
      ,[TABELA]
      ,[VALIDACAO_TABELA_CAMPO]
      ,[VALOR_PADRAO]
      ,[CONSULTA_ATIVA]
      ,[COD_GRUPO]
      ,[RESPONSAVEL]
      ,[COLUNAS_AUXILIARES]
      ,[FILTRO_AUXILIAR]
      ,[TABELAS_AUXILIARES]
      ,[LX_STATUS_REGISTRO]
FROM LDR.DRVAREJO.DBO.PROPRIEDADE A
WHERE NOT EXISTS(SELECT * FROM PROPRIEDADE B WHERE B.PROPRIEDADE=A.PROPRIEDADE)

---5.4
INSERT INTO PROPRIEDADE_TRANSACAO
SELECT [COD_TRANSACAO]
      ,[TABELA]
      ,[DESC_PAGINA]
       FROM LDR.DRVAREJO.DBO.PROPRIEDADE_TRANSACAO A
WHERE NOT EXISTS(SELECT * FROM PROPRIEDADE_TRANSACAO B WHERE B.COD_TRANSACAO=A.COD_TRANSACAO AND B.TABELA=A.TABELA)

---5.5
INSERT INTO PROPRIEDADE_VALIDA
SELECT [PROPRIEDADE]
      ,[VALOR_PROPRIEDADE]
      ,[DATA_ATIVACAO]
      ,[DATA_DESATIVACAO]
      ,[DATA_PARA_TRANSFERENCIA]
FROM LDR.DRVAREJO.DBO.PROPRIEDADE_VALIDA A
WHERE NOT EXISTS(SELECT * FROM PROPRIEDADE_VALIDA B WHERE B.PROPRIEDADE=A.PROPRIEDADE AND B.VALOR_PROPRIEDADE=A.VALOR_PROPRIEDADE)

---5.6
--- 
INSERT INTO PROP_PRODUTOS (
       [PROPRIEDADE]
      ,[VALOR_PROPRIEDADE]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[PRODUTO]
      ,[ITEM_PROPRIEDADE]
)
SELECT [PROPRIEDADE]
      ,[VALOR_PROPRIEDADE]
      ,[DATA_PARA_TRANSFERENCIA]
      ,'V'+[PRODUTO]
      ,[ITEM_PROPRIEDADE]
FROM LDR.DRVAREJO.DBO.PROP_PRODUTOS A
WHERE PRODUTO IN (
'12337        ',
'20847        ',
'30111        ',
'30112        ',
'30113        ',
'30114        ',
'30115        ',
'30269        ',
'30901        ',
'30909        ',
'32018        ',
'32021        ',
'32022        ',
'32112        ',
'33101        ',
'33103        ',
'33104        ',
'33105        ',
'33106        ',
'33107        ',
'33109        ',
'33110        ',
'33111        ',
'33113        ',
'33114        ',
'33268        ',
'33574        ',
'33820        ',
'33822        ',
'33904        ',
'33913        ',
'35107        ',
'35113        ',
'400027       ',
'400407       ',
'40120        ',
'40156        ',
'40312        ',
'40319        ',
'40360        ',
'40369        ',
'40370        ',
'40371        ',
'40458        ',
'40512        ',
'406037       ',
'406057       ',
'40607.1      ',
'40611        ',
'40640        ',
'406447       ',
'407077       ',
'40709        ',
'40820PLUS    ',
'40823        ',
'40901        ',
'40901 B      ',
'40901 G      ',
'40909        ',
'40910        ',
'41006        ',
'41166        ',
'41811        ',
'41903        ',
'42004        ',
'42118        ',
'421507       ',
'421517       ',
'42152        ',
'421547       ',
'42156        ',
'42166        ',
'42174        ',
'42218        ',
'42250        ',
'42254        ',
'42260.1      ',
'42261        ',
'42311        ',
'42312        ',
'42313        ',
'42333        ',
'42361        ',
'42365        ',
'42366        ',
'42370        ',
'42375        ',
'42450        ',
'42451        ',
'42453        ',
'42454        ',
'42455        ',
'42456        ',
'42458        ',
'42463        ',
'42468        ',
'42500        ',
'42504        ',
'42505        ',
'42513        ',
'42607        ',
'42615        ',
'42617        ',
'42618        ',
'42711        ',
'42719        ',
'42719 PLUS   ',
'42811        ',
'42902        ',
'42902.1      ',
'42903        ',
'42905        ',
'42906        ',
'42909        ',
'429117       ',
'42915        ',
'42916        ',
'43003        ',
'43005        ',
'43167        ',
'43203        ',
'43262        ',
'43366        ',
'436017       ',
'43640        ',
'44005        ',
'44027        ',
'44028        ',
'44167        ',
'441687       ',
'44262        ',
'44375        ',
'44450        ',
'44607        ',
'44640        ',
'44706        ',
'44818        ',
'44903        ',
'45015        ',
'45016        ',
'45165        ',
'45166        ',
'45170        ',
'45218        ',
'45255        ',
'45311        ',
'45313        ',
'45333        ',
'45353        ',
'45362        ',
'45365        ',
'45450        ',
'45451        ',
'45453        ',
'45454        ',
'45455        ',
'45456        ',
'45500        ',
'45504        ',
'45505        ',
'45827        ',
'45829        ',
'46027        ',
'47167        ',
'47375        ',
'47463        ',
'47501        ',
'47716        ',
'47902        ',
'48027        ',
'48112        ',
'48817        ',
'49166        ',
'500407       ',
'501517       ',
'501547       ',
'50166        ',
'50167        ',
'50173        ',
'50250        ',
'50254        ',
'50366        ',
'50468        ',
'50512        ',
'50516        ',
'50615        ',
'50640        ',
'507077       ',
'50709        ',
'50719        ',
'50820        ',
'50823        ',
'50902        ',
'50905        ',
'50906        ',
'50906 PLUS   ',
'50911        ',
'51002        ',
'510027       ',
'51015        ',
'51015 DUO    ',
'51118        ',
'51120        ',
'511507       ',
'51152        ',
'51156        ',
'51158 DUO    ',
'51159        ',
'51159 DUO    ',
'51165        ',
'51170        ',
'51173        ',
'51174        ',
'51175        ',
'51218        ',
'51254        ',
'51258        ',
'51311        ',
'51312        ',
'51313        ',
'51333        ',
'51353        ',
'51360        ',
'51361        ',
'51362        ',
'51365        ',
'51370        ',
'51374        ',
'51375        ',
'51450        ',
'51451        ',
'51453        ',
'51454        ',
'51455        ',
'51456        ',
'51458        ',
'51463        ',
'51504        ',
'51505        ',
'51513        ',
'51602        ',
'51607.1      ',
'51613 K-1GG  ',
'51613 K-1P   ',
'51615        ',
'51628        ',
'51629        ',
'51629K1-G    ',
'51706        ',
'51718        ',
'51725        ',
'51806-FARM   ',
'51806-PACK   ',
'51823        ',
'51827        ',
'519017       ',
'51902        ',
'51911        ',
'51911 PLUS   ',
'519117       ',
'51912        ',
'52118        ',
'52120        ',
'52152        ',
'52156        ',
'52157        ',
'52158        ',
'52158 DUO    ',
'52159        ',
'52159 DUO    ',
'52167        ',
'52174        ',
'52218        ',
'52255        ',
'52258        ',
'52311        ',
'52312        ',
'52313        ',
'52333        ',
'52360        ',
'52365        ',
'52369        ',
'52375        ',
'52450        ',
'52451        ',
'52453        ',
'52454        ',
'52455        ',
'52456        ',
'52458        ',
'52463        ',
'52500        ',
'52504        ',
'52505        ',
'52513        ',
'52607        ',
'52613 K-1G   ',
'52613 K-1M   ',
'52618        ',
'52620        ',
'52629K1-G    ',
'52709        ',
'52801        ',
'52805        ',
'52811        ',
'52813        ',
'52824        ',
'52829        ',
'52903        ',
'52916        ',
'530277       ',
'53213        ',
'53262        ',
'536037       ',
'536057       ',
'53816        ',
'538167       ',
'53820PLUS    ',
'54004        ',
'54365        ',
'54375        ',
'54909        ',
'55027        ',
'550277       ',
'55213        ',
'56027        ',
'560277       ',
'56166        ',
'56820        ',
'57003        ',
'57005        ',
'57006        ',
'57007        ',
'57011        ',
'57118        ',
'57120        ',
'57157        ',
'57218        ',
'57255        ',
'57311        ',
'57312        ',
'57313        ',
'57333        ',
'57500        ',
'57504        ',
'57505        ',
'57513        ',
'57607        ',
'57618        ',
'57711        ',
'57718        ',
'57805        ',
'57811        ',
'57814        ',
'57902        ',
'57903        ',
'57909        ',
'57916        ',
'59006        ',
'59903        ',
'59911        ',
'599117       ',
'60901        ')


--- 6o PRODUTOS BARRA
--- PRODUTOS_BARRA
INSERT INTO PRODUTOS_BARRA(
       [CODIGO_BARRA]
      ,[PRODUTO]
      ,[COR_PRODUTO]
      ,[TAMANHO]
      ,[GRADE]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[NOME_CLIFOR]
      ,[CODIGO_BARRA_PADRAO]
      ,[INATIVO]
      ,[TIPO_COD_BAR]
      ,[BARVL_VOL_L1]
      ,[BARVL_VOL_L2]
      ,[BARVL_VOL_L3]
      ,[BARVL_PESO]
      ,[BARQT_CUBAGEM]
      ,[BARNR_COR]
      ,[ISN_PRODUTO]
      ,[BARSIS_BARRA]
      ,[BARQT_MULTIPLICADOR]
      ,[LX_STATUS_REGISTRO]
      ,[ISN_COR]
)
SELECT [CODIGO_BARRA]
      ,'V'+A.[PRODUTO]
      ,A.[COR_PRODUTO]
      ,[TAMANHO]
      ,[GRADE]
      ,A.[DATA_PARA_TRANSFERENCIA] 
      ,NULL
      ,[CODIGO_BARRA_PADRAO]
      ,[INATIVO]
      ,[TIPO_COD_BAR]
      ,[BARVL_VOL_L1]
      ,[BARVL_VOL_L2]
      ,[BARVL_VOL_L3]
      ,[BARVL_PESO]
      ,[BARQT_CUBAGEM]
      ,[BARNR_COR]
      ,[ISN_PRODUTO]
      ,[BARSIS_BARRA]
      ,[BARQT_MULTIPLICADOR]
      ,A.[LX_STATUS_REGISTRO]
      ,[ISN_COR]
FROM LDR.DRVAREJO.DBO.PRODUTOS_BARRA A
WHERE A.CODIGO_BARRA_PADRAO=1 AND A.PRODUTO IN(
'12337        ',
'20847        ',
'30111        ',
'30112        ',
'30113        ',
'30114        ',
'30115        ',
'30269        ',
'30901        ',
'30909        ',
'32018        ',
'32021        ',
'32022        ',
'32112        ',
'33101        ',
'33103        ',
'33104        ',
'33105        ',
'33106        ',
'33107        ',
'33109        ',
'33110        ',
'33111        ',
'33113        ',
'33114        ',
'33268        ',
'33574        ',
'33820        ',
'33822        ',
'33904        ',
'33913        ',
'35107        ',
'35113        ',
'400027       ',
'400407       ',
'40120        ',
'40156        ',
'40312        ',
'40319        ',
'40360        ',
'40369        ',
'40370        ',
'40371        ',
'40458        ',
'40512        ',
'406037       ',
'406057       ',
'40607.1      ',
'40611        ',
'40640        ',
'406447       ',
'407077       ',
'40709        ',
'40820PLUS    ',
'40823        ',
'40901        ',
'40901 B      ',
'40901 G      ',
'40909        ',
'40910        ',
'41006        ',
'41166        ',
'41811        ',
'41903        ',
'42004        ',
'42118        ',
'421507       ',
'421517       ',
'42152        ',
'421547       ',
'42156        ',
'42166        ',
'42174        ',
'42218        ',
'42250        ',
'42254        ',
'42260.1      ',
'42261        ',
'42311        ',
'42312        ',
'42313        ',
'42333        ',
'42361        ',
'42365        ',
'42366        ',
'42370        ',
'42375        ',
'42450        ',
'42451        ',
'42453        ',
'42454        ',
'42455        ',
'42456        ',
'42458        ',
'42463        ',
'42468        ',
'42500        ',
'42504        ',
'42505        ',
'42513        ',
'42607        ',
'42615        ',
'42617        ',
'42618        ',
'42711        ',
'42719        ',
'42719 PLUS   ',
'42811        ',
'42902        ',
'42902.1      ',
'42903        ',
'42905        ',
'42906        ',
'42909        ',
'429117       ',
'42915        ',
'42916        ',
'43003        ',
'43005        ',
'43167        ',
'43203        ',
'43262        ',
'43366        ',
'436017       ',
'43640        ',
'44005        ',
'44027        ',
'44028        ',
'44167        ',
'441687       ',
'44262        ',
'44375        ',
'44450        ',
'44607        ',
'44640        ',
'44706        ',
'44818        ',
'44903        ',
'45015        ',
'45016        ',
'45165        ',
'45166        ',
'45170        ',
'45218        ',
'45255        ',
'45311        ',
'45313        ',
'45333        ',
'45353        ',
'45362        ',
'45365        ',
'45450        ',
'45451        ',
'45453        ',
'45454        ',
'45455        ',
'45456        ',
'45500        ',
'45504        ',
'45505        ',
'45827        ',
'45829        ',
'46027        ',
'47167        ',
'47375        ',
'47463        ',
'47501        ',
'47716        ',
'47902        ',
'48027        ',
'48112        ',
'48817        ',
'49166        ',
'500407       ',
'501517       ',
'501547       ',
'50166        ',
'50167        ',
'50173        ',
'50250        ',
'50254        ',
'50366        ',
'50468        ',
'50512        ',
'50516        ',
'50615        ',
'50640        ',
'507077       ',
'50709        ',
'50719        ',
'50820        ',
'50823        ',
'50902        ',
'50905        ',
'50906        ',
'50906 PLUS   ',
'50911        ',
'51002        ',
'510027       ',
'51015        ',
'51015 DUO    ',
'51118        ',
'51120        ',
'511507       ',
'51152        ',
'51156        ',
'51158 DUO    ',
'51159        ',
'51159 DUO    ',
'51165        ',
'51170        ',
'51173        ',
'51174        ',
'51175        ',
'51218        ',
'51254        ',
'51258        ',
'51311        ',
'51312        ',
'51313        ',
'51333        ',
'51353        ',
'51360        ',
'51361        ',
'51362        ',
'51365        ',
'51370        ',
'51374        ',
'51375        ',
'51450        ',
'51451        ',
'51453        ',
'51454        ',
'51455        ',
'51456        ',
'51458        ',
'51463        ',
'51504        ',
'51505        ',
'51513        ',
'51602        ',
'51607.1      ',
'51613 K-1GG  ',
'51613 K-1P   ',
'51615        ',
'51628        ',
'51629        ',
'51629K1-G    ',
'51706        ',
'51718        ',
'51725        ',
'51806-FARM   ',
'51806-PACK   ',
'51823        ',
'51827        ',
'519017       ',
'51902        ',
'51911        ',
'51911 PLUS   ',
'519117       ',
'51912        ',
'52118        ',
'52120        ',
'52152        ',
'52156        ',
'52157        ',
'52158        ',
'52158 DUO    ',
'52159        ',
'52159 DUO    ',
'52167        ',
'52174        ',
'52218        ',
'52255        ',
'52258        ',
'52311        ',
'52312        ',
'52313        ',
'52333        ',
'52360        ',
'52365        ',
'52369        ',
'52375        ',
'52450        ',
'52451        ',
'52453        ',
'52454        ',
'52455        ',
'52456        ',
'52458        ',
'52463        ',
'52500        ',
'52504        ',
'52505        ',
'52513        ',
'52607        ',
'52613 K-1G   ',
'52613 K-1M   ',
'52618        ',
'52620        ',
'52629K1-G    ',
'52709        ',
'52801        ',
'52805        ',
'52811        ',
'52813        ',
'52824        ',
'52829        ',
'52903        ',
'52916        ',
'530277       ',
'53213        ',
'53262        ',
'536037       ',
'536057       ',
'53816        ',
'538167       ',
'53820PLUS    ',
'54004        ',
'54365        ',
'54375        ',
'54909        ',
'55027        ',
'550277       ',
'55213        ',
'56027        ',
'560277       ',
'56166        ',
'56820        ',
'57003        ',
'57005        ',
'57006        ',
'57007        ',
'57011        ',
'57118        ',
'57120        ',
'57157        ',
'57218        ',
'57255        ',
'57311        ',
'57312        ',
'57313        ',
'57333        ',
'57500        ',
'57504        ',
'57505        ',
'57513        ',
'57607        ',
'57618        ',
'57711        ',
'57718        ',
'57805        ',
'57811        ',
'57814        ',
'57902        ',
'57903        ',
'57909        ',
'57916        ',
'59006        ',
'59903        ',
'59911        ',
'599117       ',
'60901        ')   
AND A.COR_PRODUTO IN (
'225                  ',
'247                  ',
'3199                 ',
'4078                 ',
'AD2020               ',
'AG                   ',
'AP                   ',
'AR/CP 340            ',
'AR0094               ',
'AS117                ',
'AX228                ',
'AZUL                 ',
'BC/BC064             ',
'BC/CH 254            ',
'BC/CJ 256            ',
'BC/EST 443           ',
'BC/MS/PT             ',
'BC/VL 255            ',
'BC0035               ',
'BE                   ',
'BI 561               ',
'BIC                  ',
'CA 563               ',
'CF2046               ',
'CH7                  ',
'CI 421               ',
'CJ 008               ',
'CJ0299               ',
'CL18                 ',
'CM129                ',
'CO                   ',
'CP87                 ',
'CR18                 ',
'CT0400               ',
'DE 61                ',
'GF                   ',
'GO                   ',
'GP217                ',
'ID 60                ',
'ID 70                ',
'ID/EST 28            ',
'KT216                ',
'LI218                ',
'LK-4797              ',
'LL 215               ',
'LL215                ',
'LZ115                ',
'MA                   ',
'MC 2041              ',
'MI                   ',
'MK 62                ',
'MK/EST 82            ',
'MS/MS063             ',
'MS/PT062             ',
'MS227                ',
'MT                   ',
'MV0760               ',
'ND1073               ',
'NN315                ',
'NT/EST 442           ',
'NT/EST 55            ',
'NT023                ',
'OU                   ',
'PE50                 ',
'PK1074               ',
'PL/EST 445           ',
'PL/LISTRA            ',
'PL/POÁ               ',
'PL1040               ',
'PR60                 ',
'PT 010               ',
'PT/CJ 257            ',
'PT/PT065             ',
'PT0124               ',
'PU 24                ',
'RM210                ',
'RO0010               ',
'SB                   ',
'TF66                 ',
'TM229                ',
'VD92                 ',
'VI-081               ',
'VL230                ',
'VT                   ') AND NOT EXISTS(SELECT * FROM PRODUTOS_BARRA B WHERE B.CODIGO_BARRA=A.CODIGO_BARRA)


select * from ldr.drvarejo.dbo.PRODUTOS_BARRA a
WHERE exists (select * from produtos_barra b where b.PRODUTO='V'+a.produto and b.COR_PRODUTO=a.cor_produto)


select * from PRODUTO_CORES a
WHERE exists (select * from LDR.DRVAREJO.DBO.produtos_barra b where 'V'+b.PRODUTO=a.produto and b.COR_PRODUTO=a.cor_produto)

select * from LDR.DRVAREJO.DBO.PRODUTOS_BARRA
where PRODUTO='57504'

select * from PRODUTOS_BARRA
where PRODUTO='V57504'

SELECT * FROM LDR.DRVAREJO.DBO.PRODUTOS_BARRA A
WHERE A.CODIGO_BARRA_PADRAO=1 AND A.PRODUTO IN(
'12337        ',
'20847        ',
'30111        ',
'30112        ',
'30113        ',
'30114        ',
'30115        ',
'30269        ',
'30901        ',
'30909        ',
'32018        ',
'32021        ',
'32022        ',
'32112        ',
'33101        ',
'33103        ',
'33104        ',
'33105        ',
'33106        ',
'33107        ',
'33109        ',
'33110        ',
'33111        ',
'33113        ',
'33114        ',
'33268        ',
'33574        ',
'33820        ',
'33822        ',
'33904        ',
'33913        ',
'35107        ',
'35113        ',
'400027       ',
'400407       ',
'40120        ',
'40156        ',
'40312        ',
'40319        ',
'40360        ',
'40369        ',
'40370        ',
'40371        ',
'40458        ',
'40512        ',
'406037       ',
'406057       ',
'40607.1      ',
'40611        ',
'40640        ',
'406447       ',
'407077       ',
'40709        ',
'40820PLUS    ',
'40823        ',
'40901        ',
'40901 B      ',
'40901 G      ',
'40909        ',
'40910        ',
'41006        ',
'41166        ',
'41811        ',
'41903        ',
'42004        ',
'42118        ',
'421507       ',
'421517       ',
'42152        ',
'421547       ',
'42156        ',
'42166        ',
'42174        ',
'42218        ',
'42250        ',
'42254        ',
'42260.1      ',
'42261        ',
'42311        ',
'42312        ',
'42313        ',
'42333        ',
'42361        ',
'42365        ',
'42366        ',
'42370        ',
'42375        ',
'42450        ',
'42451        ',
'42453        ',
'42454        ',
'42455        ',
'42456        ',
'42458        ',
'42463        ',
'42468        ',
'42500        ',
'42504        ',
'42505        ',
'42513        ',
'42607        ',
'42615        ',
'42617        ',
'42618        ',
'42711        ',
'42719        ',
'42719 PLUS   ',
'42811        ',
'42902        ',
'42902.1      ',
'42903        ',
'42905        ',
'42906        ',
'42909        ',
'429117       ',
'42915        ',
'42916        ',
'43003        ',
'43005        ',
'43167        ',
'43203        ',
'43262        ',
'43366        ',
'436017       ',
'43640        ',
'44005        ',
'44027        ',
'44028        ',
'44167        ',
'441687       ',
'44262        ',
'44375        ',
'44450        ',
'44607        ',
'44640        ',
'44706        ',
'44818        ',
'44903        ',
'45015        ',
'45016        ',
'45165        ',
'45166        ',
'45170        ',
'45218        ',
'45255        ',
'45311        ',
'45313        ',
'45333        ',
'45353        ',
'45362        ',
'45365        ',
'45450        ',
'45451        ',
'45453        ',
'45454        ',
'45455        ',
'45456        ',
'45500        ',
'45504        ',
'45505        ',
'45827        ',
'45829        ',
'46027        ',
'47167        ',
'47375        ',
'47463        ',
'47501        ',
'47716        ',
'47902        ',
'48027        ',
'48112        ',
'48817        ',
'49166        ',
'500407       ',
'501517       ',
'501547       ',
'50166        ',
'50167        ',
'50173        ',
'50250        ',
'50254        ',
'50366        ',
'50468        ',
'50512        ',
'50516        ',
'50615        ',
'50640        ',
'507077       ',
'50709        ',
'50719        ',
'50820        ',
'50823        ',
'50902        ',
'50905        ',
'50906        ',
'50906 PLUS   ',
'50911        ',
'51002        ',
'510027       ',
'51015        ',
'51015 DUO    ',
'51118        ',
'51120        ',
'511507       ',
'51152        ',
'51156        ',
'51158 DUO    ',
'51159        ',
'51159 DUO    ',
'51165        ',
'51170        ',
'51173        ',
'51174        ',
'51175        ',
'51218        ',
'51254        ',
'51258        ',
'51311        ',
'51312        ',
'51313        ',
'51333        ',
'51353        ',
'51360        ',
'51361        ',
'51362        ',
'51365        ',
'51370        ',
'51374        ',
'51375        ',
'51450        ',
'51451        ',
'51453        ',
'51454        ',
'51455        ',
'51456        ',
'51458        ',
'51463        ',
'51504        ',
'51505        ',
'51513        ',
'51602        ',
'51607.1      ',
'51613 K-1GG  ',
'51613 K-1P   ',
'51615        ',
'51628        ',
'51629        ',
'51629K1-G    ',
'51706        ',
'51718        ',
'51725        ',
'51806-FARM   ',
'51806-PACK   ',
'51823        ',
'51827        ',
'519017       ',
'51902        ',
'51911        ',
'51911 PLUS   ',
'519117       ',
'51912        ',
'52118        ',
'52120        ',
'52152        ',
'52156        ',
'52157        ',
'52158        ',
'52158 DUO    ',
'52159        ',
'52159 DUO    ',
'52167        ',
'52174        ',
'52218        ',
'52255        ',
'52258        ',
'52311        ',
'52312        ',
'52313        ',
'52333        ',
'52360        ',
'52365        ',
'52369        ',
'52375        ',
'52450        ',
'52451        ',
'52453        ',
'52454        ',
'52455        ',
'52456        ',
'52458        ',
'52463        ',
'52500        ',
'52504        ',
'52505        ',
'52513        ',
'52607        ',
'52613 K-1G   ',
'52613 K-1M   ',
'52618        ',
'52620        ',
'52629K1-G    ',
'52709        ',
'52801        ',
'52805        ',
'52811        ',
'52813        ',
'52824        ',
'52829        ',
'52903        ',
'52916        ',
'530277       ',
'53213        ',
'53262        ',
'536037       ',
'536057       ',
'53816        ',
'538167       ',
'53820PLUS    ',
'54004        ',
'54365        ',
'54375        ',
'54909        ',
'55027        ',
'550277       ',
'55213        ',
'56027        ',
'560277       ',
'56166        ',
'56820        ',
'57003        ',
'57005        ',
'57006        ',
'57007        ',
'57011        ',
'57118        ',
'57120        ',
'57157        ',
'57218        ',
'57255        ',
'57311        ',
'57312        ',
'57313        ',
'57333        ',
'57500        ',
'57504        ',
'57505        ',
'57513        ',
'57607        ',
'57618        ',
'57711        ',
'57718        ',
'57805        ',
'57811        ',
'57814        ',
'57902        ',
'57903        ',
'57909        ',
'57916        ',
'59006        ',
'59903        ',
'59911        ',
'599117       ',
'60901        ')  
order by produto
 
