INSERT INTO VENDAS_LOTE(
[PEDIDO_EXTERNO]
      ,[TIPO_DO_DIGITADOR]
      ,[MOEDA]
      ,[CODIGO_TAB_PRECO]
      ,[TIPO]
      ,[CONDICAO_PGTO]
      ,[COLECAO]
      ,[CLIENTE_ATACADO]
      ,[REPRESENTANTE]
      ,[PEDIDO]
      ,[EMISSAO]
      ,[DATA_ENVIO]
      ,[DATA_RECEBIMENTO]
      ,[PEDIDO_CLIENTE]
      ,[DESCONTO]
      ,[ENCARGO]
      ,[TOT_QTDE_ORIGINAL]
      ,[TOT_VALOR_ORIGINAL]
      ,[VALOR_IPI]
      ,[CTRL_MULT_ENTREGAS]
      ,[ENTREGA_CIF]
      ,[ENTREGA_ACEITAVEL]
      ,[DESCONTO_SOBRE_1]
      ,[DESCONTO_SOBRE_2]
      ,[DESCONTO_SOBRE_3]
      ,[DESCONTO_SOBRE_4]
      ,[OBS]
      ,[FILIAL]
      ,[TRANSPORTADORA]
      ,[GERENTE]
      ,[APROVACAO]
      ,[APROVADO_POR]
      ,[CONFERIDO]
      ,[CONFERIDO_POR]
      ,[COMISSAO]
      ,[COMISSAO_GERENTE]
      ,[PORCENTAGEM_ACERTO]
      ,[PRIORIDADE]
      ,[ACEITA_JUNTAR_PED]
      ,[STATUS]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[TIPO_FRETE]
      ,[TABELA_FILHA]
      ,[MULTI_DESCONTO_ACUMULAR]
      ,[RECARGO]
      ,[ACEITA_PECAS_PEQUENAS]
      ,[ACEITA_PECAS_COM_CORTE]
      ,[FRETE_CORTESIA]
      ,[DATA_FATURAMENTO_RELATIVO]
      ,[INDICA_LOCAL_SEPARACAO]
      ,[EXPEDICAO_PORCENTAGEM_MAIOR]
      ,[EXPEDICAO_PORCENTAGEM_MINIMA]
      ,[EXPEDICAO_PORCENTAGEM_TIPO]
      ,[EXPEDICAO_COMPLETO_PEDIDO]
      ,[EXPEDICAO_COMPLETO_PACK]
      ,[EXPEDICAO_COMPLETO_TAMANHOS]
      ,[EXPEDICAO_COMPLETO_COR]
      ,[EXPEDICAO_COMPLETO_COORDENADO]
      ,[EXPEDICAO_COMPLETO_CARTELA]
      ,[TIPO_CAIXA]
      ,[PERIODO_PCP]
      ,[NOME_CLIFOR_ENTREGA]
      ,[EXPEDICAO_NAO_JUNTAR_PRODUTO_CAIXA]
      ,[OBS_TRANSPORTE]
      ,[TIPO_RATEIO]
      ,[NUMERO_ENTREGA]
      ,[TRANSP_REDESPACHO]
      ,[PEDIDO_EXTERNO_ORIGEM]
      ,[FILIAL_DIGITACAO]
      ,[PORC_DESCONTO]
      ,[NATUREZA_SAIDA]
      ,[COMISSAO_VALOR_GERENTE]
      ,[COMISSAO_VALOR]
      ,[PORC_DESCONTO_COND_PGTO]
      ,[DESCONTO_COND_PGTO]
      ,[PORC_ENCARGO])

SELECT [PEDIDO_EXTERNO] 
      ,[TIPO_DO_DIGITADOR]
      ,[MOEDA]
      ,[CODIGO_TAB_PRECO]
      ,[TIPO]
      ,[CONDICAO_PGTO]
      ,[COLECAO]
      ,[CLIENTE_ATACADO]
      ,[REPRESENTANTE]
      ,[PEDIDO]
      ,[EMISSAO]
      ,[DATA_ENVIO]
      ,[DATA_RECEBIMENTO]
      ,[PEDIDO_CLIENTE]
      ,[DESCONTO]
      ,[ENCARGO]
      ,[TOT_QTDE_ORIGINAL]
      ,[TOT_VALOR_ORIGINAL]
      ,[VALOR_IPI]
      ,[CTRL_MULT_ENTREGAS]
      ,[ENTREGA_CIF]
      ,[ENTREGA_ACEITAVEL]
      ,[DESCONTO_SOBRE_1]
      ,[DESCONTO_SOBRE_2]
      ,[DESCONTO_SOBRE_3]
      ,[DESCONTO_SOBRE_4]
      ,[OBS]
      ,[FILIAL]
      ,[TRANSPORTADORA]
      ,[GERENTE]
      ,[APROVACAO]
      ,[APROVADO_POR]
      ,[CONFERIDO]
      ,[CONFERIDO_POR]
      ,[COMISSAO]
      ,[COMISSAO_GERENTE]
      ,[PORCENTAGEM_ACERTO]
      ,[PRIORIDADE]
      ,[ACEITA_JUNTAR_PED]
      ,[STATUS]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[TIPO_FRETE]
      ,[TABELA_FILHA]
      ,[MULTI_DESCONTO_ACUMULAR]
      ,[RECARGO]
      ,[ACEITA_PECAS_PEQUENAS]
      ,[ACEITA_PECAS_COM_CORTE]
      ,[FRETE_CORTESIA]
      ,[DATA_FATURAMENTO_RELATIVO]
      ,[INDICA_LOCAL_SEPARACAO]
      ,[EXPEDICAO_PORCENTAGEM_MAIOR]
      ,[EXPEDICAO_PORCENTAGEM_MINIMA]
      ,[EXPEDICAO_PORCENTAGEM_TIPO]
      ,[EXPEDICAO_COMPLETO_PEDIDO]
      ,[EXPEDICAO_COMPLETO_PACK]
      ,[EXPEDICAO_COMPLETO_TAMANHOS]
      ,[EXPEDICAO_COMPLETO_COR]
      ,[EXPEDICAO_COMPLETO_COORDENADO]
      ,[EXPEDICAO_COMPLETO_CARTELA]
      ,[TIPO_CAIXA]
      ,[PERIODO_PCP]
      ,[NOME_CLIFOR_ENTREGA]
      ,[EXPEDICAO_NAO_JUNTAR_PRODUTO_CAIXA]
      ,[OBS_TRANSPORTE]
      ,[TIPO_RATEIO]
      ,[NUMERO_ENTREGA]
      ,[TRANSP_REDESPACHO]
      ,[PEDIDO_EXTERNO_ORIGEM]
      ,[FILIAL_DIGITACAO]
      ,[PORC_DESCONTO]
      ,[NATUREZA_SAIDA]
      ,[COMISSAO_VALOR_GERENTE]
      ,[COMISSAO_VALOR]
      ,[PORC_DESCONTO_COND_PGTO]
      ,[DESCONTO_COND_PGTO]
      ,[PORC_ENCARGO]
  FROM [DRVAREJO].[dbo].[VENDAS_LOTE_COPIA_PEDIDO]
WHERE PEDIDO_EXTERNO='0219i.001471'



INSERT INTO VENDAS_LOTE_PROD (
      [PRODUTO]
      ,[COR_PRODUTO]
      ,[ENTREGA]
      ,[PEDIDO_EXTERNO]
      ,[SEQUENCIAL_DIGITACAO]
      ,[PACKS]
      ,[NUMERO_CONJUNTO]
      ,[NUMERO_ENTREGA]
      ,[LIMITE_ENTREGA]
      ,[STATUS_VENDA_ATUAL]
      ,[QTDE_ORIGINAL]
      ,[VALOR_ORIGINAL]
      ,[PRECO1]
      ,[PRECO2]
      ,[PRECO3]
      ,[PRECO4]
      ,[DESCONTO_ITEM]
      ,[IPI]
      ,[VO1]
      ,[VO2]
      ,[VO3]
      ,[VO4]
      ,[VO5]
      ,[VO6]
      ,[VO7]
      ,[VO8]
      ,[VO9]
      ,[VO10]
      ,[VO11]
      ,[VO12]
      ,[VO13]
      ,[VO14]
      ,[VO15]
      ,[VO16]
      ,[VO17]
      ,[VO18]
      ,[VO19]
      ,[VO20]
      ,[VO21]
      ,[VO22]
      ,[VO23]
      ,[VO24]
      ,[VO25]
      ,[VO26]
      ,[VO27]
      ,[VO28]
      ,[VO29]
      ,[VO30]
      ,[VO31]
      ,[VO32]
      ,[VO33]
      ,[VO34]
      ,[VO35]
      ,[VO36]
      ,[VO37]
      ,[VO38]
      ,[VO39]
      ,[VO40]
      ,[VO41]
      ,[VO42]
      ,[VO43]
      ,[VO44]
      ,[VO45]
      ,[VO46]
      ,[VO47]
      ,[VO48]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[ITEM_PEDIDO]
      ,[CODIGO_LOCAL_ENTREGA]
      ,[TIPO_CAIXA]
      ,[NUMERO_CAIXAS]
      ,[DESC_VENDA_CLIENTE]
      ,[COMISSAO_ITEM]
      ,[COMISSAO_ITEM_GERENTE]
      ,[ID_MODIFICACAO]
      ,[COMISSAO_VALOR_GERENTE]
      ,[COMISSAO_VALOR]
)
SELECT [PRODUTO]
      ,[COR_PRODUTO]
      ,[ENTREGA]
      ,[PEDIDO_EXTERNO]      
      ,[SEQUENCIAL_DIGITACAO]
      ,[PACKS]
      ,[NUMERO_CONJUNTO]
      ,[NUMERO_ENTREGA]
      ,[LIMITE_ENTREGA]
      ,[STATUS_VENDA_ATUAL]
      ,[QTDE_ORIGINAL]
      ,[VALOR_ORIGINAL]
      ,[PRECO1]
      ,[PRECO2]
      ,[PRECO3]
      ,[PRECO4]
      ,[DESCONTO_ITEM]
      ,[IPI]
      ,[VO1]
      ,[VO2]
      ,[VO3]
      ,[VO4]
      ,[VO5]
      ,[VO6]
      ,[VO7]
      ,[VO8]
      ,[VO9]
      ,[VO10]
      ,[VO11]
      ,[VO12]
      ,[VO13]
      ,[VO14]
      ,[VO15]
      ,[VO16]
      ,[VO17]
      ,[VO18]
      ,[VO19]
      ,[VO20]
      ,[VO21]
      ,[VO22]
      ,[VO23]
      ,[VO24]
      ,[VO25]
      ,[VO26]
      ,[VO27]
      ,[VO28]
      ,[VO29]
      ,[VO30]
      ,[VO31]
      ,[VO32]
      ,[VO33]
      ,[VO34]
      ,[VO35]
      ,[VO36]
      ,[VO37]
      ,[VO38]
      ,[VO39]
      ,[VO40]
      ,[VO41]
      ,[VO42]
      ,[VO43]
      ,[VO44]
      ,[VO45]
      ,[VO46]
      ,[VO47]
      ,[VO48]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[ITEM_PEDIDO]
      ,[CODIGO_LOCAL_ENTREGA]
      ,[TIPO_CAIXA]
      ,[NUMERO_CAIXAS]
      ,[DESC_VENDA_CLIENTE]
      ,[COMISSAO_ITEM]
      ,[COMISSAO_ITEM_GERENTE]
      ,[ID_MODIFICACAO]
      ,[COMISSAO_VALOR_GERENTE]
      ,[COMISSAO_VALOR]
  FROM [DRVAREJO].[dbo].[VENDAS_LOTE_PROD_COPIA_PEDIDO]
WHERE PEDIDO_EXTERNO IN ('0219i.001471')



--- AJUSTES NOS PEDIDOS DO Y YAMADA
INSERT INTO VENDAS_LOTE(
[PEDIDO_EXTERNO]
      ,[TIPO_DO_DIGITADOR]
      ,[MOEDA]
      ,[CODIGO_TAB_PRECO]
      ,[TIPO]
      ,[CONDICAO_PGTO]
      ,[COLECAO]
      ,[CLIENTE_ATACADO]
      ,[REPRESENTANTE]
      ,[PEDIDO]
      ,[EMISSAO]
      ,[DATA_ENVIO]
      ,[DATA_RECEBIMENTO]
      ,[PEDIDO_CLIENTE]
      ,[DESCONTO]
      ,[ENCARGO]
      ,[TOT_QTDE_ORIGINAL]
      ,[TOT_VALOR_ORIGINAL]
      ,[VALOR_IPI]
      ,[CTRL_MULT_ENTREGAS]
      ,[ENTREGA_CIF]
      ,[ENTREGA_ACEITAVEL]
      ,[DESCONTO_SOBRE_1]
      ,[DESCONTO_SOBRE_2]
      ,[DESCONTO_SOBRE_3]
      ,[DESCONTO_SOBRE_4]
      ,[OBS]
      ,[FILIAL]
      ,[TRANSPORTADORA]
      ,[GERENTE]
      ,[APROVACAO]
      ,[APROVADO_POR]
      ,[CONFERIDO]
      ,[CONFERIDO_POR]
      ,[COMISSAO]
      ,[COMISSAO_GERENTE]
      ,[PORCENTAGEM_ACERTO]
      ,[PRIORIDADE]
      ,[ACEITA_JUNTAR_PED]
      ,[STATUS]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[TIPO_FRETE]
      ,[TABELA_FILHA]
      ,[MULTI_DESCONTO_ACUMULAR]
      ,[RECARGO]
      ,[ACEITA_PECAS_PEQUENAS]
      ,[ACEITA_PECAS_COM_CORTE]
      ,[FRETE_CORTESIA]
      ,[DATA_FATURAMENTO_RELATIVO]
      ,[INDICA_LOCAL_SEPARACAO]
      ,[EXPEDICAO_PORCENTAGEM_MAIOR]
      ,[EXPEDICAO_PORCENTAGEM_MINIMA]
      ,[EXPEDICAO_PORCENTAGEM_TIPO]
      ,[EXPEDICAO_COMPLETO_PEDIDO]
      ,[EXPEDICAO_COMPLETO_PACK]
      ,[EXPEDICAO_COMPLETO_TAMANHOS]
      ,[EXPEDICAO_COMPLETO_COR]
      ,[EXPEDICAO_COMPLETO_COORDENADO]
      ,[EXPEDICAO_COMPLETO_CARTELA]
      ,[TIPO_CAIXA]
      ,[PERIODO_PCP]
      ,[NOME_CLIFOR_ENTREGA]
      ,[EXPEDICAO_NAO_JUNTAR_PRODUTO_CAIXA]
      ,[OBS_TRANSPORTE]
      ,[TIPO_RATEIO]
      ,[NUMERO_ENTREGA]
      ,[TRANSP_REDESPACHO]
      ,[PEDIDO_EXTERNO_ORIGEM]
      ,[FILIAL_DIGITACAO]
      ,[PORC_DESCONTO]
      ,[NATUREZA_SAIDA]
      ,[COMISSAO_VALOR_GERENTE]
      ,[COMISSAO_VALOR]
      ,[PORC_DESCONTO_COND_PGTO]
      ,[DESCONTO_COND_PGTO]
      ,[PORC_ENCARGO])

SELECT 'W000.000000'
      ,[TIPO_DO_DIGITADOR]
      ,[MOEDA]
      ,[CODIGO_TAB_PRECO]
      ,[TIPO]
      ,[CONDICAO_PGTO]
      ,[COLECAO]
      ,[CLIENTE_ATACADO]
      ,[REPRESENTANTE]
      ,[PEDIDO]
      ,[EMISSAO]
      ,[DATA_ENVIO]
      ,[DATA_RECEBIMENTO]
      ,[PEDIDO_CLIENTE]
      ,[DESCONTO]
      ,[ENCARGO]
      ,[TOT_QTDE_ORIGINAL]
      ,[TOT_VALOR_ORIGINAL]
      ,[VALOR_IPI]
      ,[CTRL_MULT_ENTREGAS]
      ,[ENTREGA_CIF]
      ,[ENTREGA_ACEITAVEL]
      ,[DESCONTO_SOBRE_1]
      ,[DESCONTO_SOBRE_2]
      ,[DESCONTO_SOBRE_3]
      ,[DESCONTO_SOBRE_4]
      ,[OBS]
      ,[FILIAL]
      ,[TRANSPORTADORA]
      ,[GERENTE]
      ,[APROVACAO]
      ,[APROVADO_POR]
      ,[CONFERIDO]
      ,[CONFERIDO_POR]
      ,[COMISSAO]
      ,[COMISSAO_GERENTE]
      ,[PORCENTAGEM_ACERTO]
      ,[PRIORIDADE]
      ,[ACEITA_JUNTAR_PED]
      ,[STATUS]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[TIPO_FRETE]
      ,[TABELA_FILHA]
      ,[MULTI_DESCONTO_ACUMULAR]
      ,[RECARGO]
      ,[ACEITA_PECAS_PEQUENAS]
      ,[ACEITA_PECAS_COM_CORTE]
      ,[FRETE_CORTESIA]
      ,[DATA_FATURAMENTO_RELATIVO]
      ,[INDICA_LOCAL_SEPARACAO]
      ,[EXPEDICAO_PORCENTAGEM_MAIOR]
      ,[EXPEDICAO_PORCENTAGEM_MINIMA]
      ,[EXPEDICAO_PORCENTAGEM_TIPO]
      ,[EXPEDICAO_COMPLETO_PEDIDO]
      ,[EXPEDICAO_COMPLETO_PACK]
      ,[EXPEDICAO_COMPLETO_TAMANHOS]
      ,[EXPEDICAO_COMPLETO_COR]
      ,[EXPEDICAO_COMPLETO_COORDENADO]
      ,[EXPEDICAO_COMPLETO_CARTELA]
      ,[TIPO_CAIXA]
      ,[PERIODO_PCP]
      ,[NOME_CLIFOR_ENTREGA]
      ,[EXPEDICAO_NAO_JUNTAR_PRODUTO_CAIXA]
      ,[OBS_TRANSPORTE]
      ,[TIPO_RATEIO]
      ,[NUMERO_ENTREGA]
      ,[TRANSP_REDESPACHO]
      ,[PEDIDO_EXTERNO_ORIGEM]
      ,[FILIAL_DIGITACAO]
      ,[PORC_DESCONTO]
      ,[NATUREZA_SAIDA]
      ,[COMISSAO_VALOR_GERENTE]
      ,[COMISSAO_VALOR]
      ,[PORC_DESCONTO_COND_PGTO]
      ,[DESCONTO_COND_PGTO]
      ,[PORC_ENCARGO]
  FROM [DRVAREJO].[dbo].[VENDAS_LOTE_COPIA_PEDIDO]
WHERE PEDIDO_EXTERNO='0058g.001212'



INSERT INTO VENDAS_LOTE_PROD (
      [PRODUTO]
      ,[COR_PRODUTO]
      ,[ENTREGA]
      ,[PEDIDO_EXTERNO]
      ,[SEQUENCIAL_DIGITACAO]
      ,[PACKS]
      ,[NUMERO_CONJUNTO]
      ,[NUMERO_ENTREGA]
      ,[LIMITE_ENTREGA]
      ,[STATUS_VENDA_ATUAL]
      ,[QTDE_ORIGINAL]
      ,[VALOR_ORIGINAL]
      ,[PRECO1]
      ,[PRECO2]
      ,[PRECO3]
      ,[PRECO4]
      ,[DESCONTO_ITEM]
      ,[IPI]
      ,[VO1]
      ,[VO2]
      ,[VO3]
      ,[VO4]
      ,[VO5]
      ,[VO6]
      ,[VO7]
      ,[VO8]
      ,[VO9]
      ,[VO10]
      ,[VO11]
      ,[VO12]
      ,[VO13]
      ,[VO14]
      ,[VO15]
      ,[VO16]
      ,[VO17]
      ,[VO18]
      ,[VO19]
      ,[VO20]
      ,[VO21]
      ,[VO22]
      ,[VO23]
      ,[VO24]
      ,[VO25]
      ,[VO26]
      ,[VO27]
      ,[VO28]
      ,[VO29]
      ,[VO30]
      ,[VO31]
      ,[VO32]
      ,[VO33]
      ,[VO34]
      ,[VO35]
      ,[VO36]
      ,[VO37]
      ,[VO38]
      ,[VO39]
      ,[VO40]
      ,[VO41]
      ,[VO42]
      ,[VO43]
      ,[VO44]
      ,[VO45]
      ,[VO46]
      ,[VO47]
      ,[VO48]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[ITEM_PEDIDO]
      ,[CODIGO_LOCAL_ENTREGA]
      ,[TIPO_CAIXA]
      ,[NUMERO_CAIXAS]
      ,[DESC_VENDA_CLIENTE]
      ,[COMISSAO_ITEM]
      ,[COMISSAO_ITEM_GERENTE]
      ,[ID_MODIFICACAO]
      ,[COMISSAO_VALOR_GERENTE]
      ,[COMISSAO_VALOR]
)
SELECT [PRODUTO]
      ,[COR_PRODUTO]
      ,[ENTREGA]
      ,'W000.000000'
      ,[SEQUENCIAL_DIGITACAO]
      ,[PACKS]
      ,[NUMERO_CONJUNTO]
      ,[NUMERO_ENTREGA]
      ,[LIMITE_ENTREGA]
      ,[STATUS_VENDA_ATUAL]
      ,[QTDE_ORIGINAL]
      ,[VALOR_ORIGINAL]
      ,[PRECO1]
      ,[PRECO2]
      ,[PRECO3]
      ,[PRECO4]
      ,[DESCONTO_ITEM]
      ,[IPI]
      ,[VO1]
      ,[VO2]
      ,[VO3]
      ,[VO4]
      ,[VO5]
      ,[VO6]
      ,[VO7]
      ,[VO8]
      ,[VO9]
      ,[VO10]
      ,[VO11]
      ,[VO12]
      ,[VO13]
      ,[VO14]
      ,[VO15]
      ,[VO16]
      ,[VO17]
      ,[VO18]
      ,[VO19]
      ,[VO20]
      ,[VO21]
      ,[VO22]
      ,[VO23]
      ,[VO24]
      ,[VO25]
      ,[VO26]
      ,[VO27]
      ,[VO28]
      ,[VO29]
      ,[VO30]
      ,[VO31]
      ,[VO32]
      ,[VO33]
      ,[VO34]
      ,[VO35]
      ,[VO36]
      ,[VO37]
      ,[VO38]
      ,[VO39]
      ,[VO40]
      ,[VO41]
      ,[VO42]
      ,[VO43]
      ,[VO44]
      ,[VO45]
      ,[VO46]
      ,[VO47]
      ,[VO48]
      ,[DATA_PARA_TRANSFERENCIA]
      ,REPLICATE('0',(4-len(ROW_NUMBER() OVER(ORDER BY item_pedido DESC)))) + LTRIM(RTRIM(cast(ROW_NUMBER() OVER(ORDER BY item_pedido DESC) as CHAR(4)))) AS Row  
      ,[CODIGO_LOCAL_ENTREGA]
      ,[TIPO_CAIXA]
      ,[NUMERO_CAIXAS]
      ,[DESC_VENDA_CLIENTE]
      ,[COMISSAO_ITEM]
      ,[COMISSAO_ITEM_GERENTE]
      ,[ID_MODIFICACAO]
      ,[COMISSAO_VALOR_GERENTE]
      ,[COMISSAO_VALOR]
  FROM [DRVAREJO].[dbo].[VENDAS_LOTE_PROD_COPIA_PEDIDO]
WHERE PEDIDO_EXTERNO IN ( 
'0058g.001212',
'0059g.001212',
'0060g.001212',
'0061g.001212',
'0062g.001212',
'0063g.001212',
'0064g.001212',
'0065g.001212',
'0066g.001212',
'0067g.001212')



SELECT * FROM VENDAS_LOTE_COPIA_PEDIDO
WHERE PEDIDO_EXTERNO='0228s.001351'
