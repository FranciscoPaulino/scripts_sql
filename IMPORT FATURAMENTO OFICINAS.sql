---- IMPORTA��O DE FATURAMENTO OFICINAS NO BANCO DRLINGERIE PARA BANCO DA OFICINA
INSERT INTO FATURAMENTO ([FILIAL]
      ,[NF_SAIDA]
      ,[SERIE_NF]
      ,[CODIGO_LOCAL_ENTREGA]
      ,[FILIAL_FATURADA]
      ,[TIPO_FATURAMENTO]
      ,[LANCAMENTO]
      ,[NOME_CLIFOR]
      ,[CONDICAO_PGTO]
      ,[NATUREZA_SAIDA]
      ,[TRANSPORTADORA]
      ,[TRANSP_REDESPACHO]
      ,[TIPO_FRETE]
      ,[COD_TRANSACAO]
      ,[EMISSAO]
      ,[DATA_SAIDA]
      ,[FRETE]
      ,[SEGURO]
      ,[DESCONTO]
      ,[DESCONTO_COND_PGTO]
      ,[ENCARGO]
      ,[ICMS]
      ,[IPI_VALOR]
      ,[VALOR_TOTAL]
      ,[QTDE_TOTAL]
      ,[NF_FATURA]
      ,[FATURA]
      ,[NOTA_IMPRESSA]
      ,[ACERTO_CONTAS_P_R]
      ,[TABELA_FILHA]
      ,[OBS]
      ,[PESO_LIQUIDO]
      ,[PESO_BRUTO]
      ,[VOLUMES]
      ,[TIPO_VOLUME]
      ,[CONFERIDO]
      ,[CONFERIDO_POR]
      ,[ENTREGA_CIF]
      ,[IRRF]
      ,[IRRF_RET_FONTE]
      ,[NOTA_CANCELADA]
      ,[DEVOLUCAO]
      ,[REPRESENTANTE]
      ,[COMISSAO]
      ,[PORCENTAGEM_ACERTO]
      ,[GERENTE]
      ,[COMISSAO_GERENTE]
      ,[DESCONTO_BRUTO]
      ,[CONFERENCIA]
      ,[MARCA_EXPORTACAO]
      ,[ATUALIZACAO_EXPORTAR]
      ,[DATA_EXPORTACAO]
      ,[ICMS_BASE]
      ,[STATUS_TRANSITO]
      ,[DATA_CANCELAMENTO]
      ,[VALOR_CANCELADO]
      ,[QTDE_CANCELADA]
      ,[MOEDA]
      ,[CAMBIO_NA_DATA]
      ,[COBRAR_MOEDA_PADRAO]
      ,[DATA_FATURAMENTO_RELATIVO]
      ,[RECARGO]
      ,[DATA_PARA_TRANSFERENCIA]
      ,[NOME_CLIFOR_ENTREGA]
      ,[TABELA_PRECO_FRETE]
      ,[VALOR_FRETE]
      ,[NOME_CLIFOR_COBRANCA]
      ,[OBS_TRANSPORTE]
      ,[VALOR_ADICIONAL]
      ,[EMPRESA]
      ,[IPI_ADICIONAL]
      ,[CTB_LANCAMENTO]
      ,[CTB_ITEM]
      ,[NUMERO_CONFERENCIA]
      ,[ICMS_ISENTO]
      ,[ICMS_OUTROS]
      ,[RATEIO_FILIAL]
      ,[RATEIO_CENTRO_CUSTO]
      ,[NUMERO_CONFERENCIA_ITEM]
      ,[FATURA_FILIAL]
      ,[FATURA_NUMERO]
      ,[FATURA_SERIE]
      ,[AGRUPAMENTO_ITENS]
      ,[COMISSAO_VALOR]
      ,[COMISSAO_VALOR_GERENTE]
      ,[DESCONTO_BRUTO_1]
      ,[DESCONTO_BRUTO_2]
      ,[DESCONTO_BRUTO_3]
      ,[DESCONTO_BRUTO_4]
      ,[DESCONTO_SOBRE_1]
      ,[DESCONTO_SOBRE_2]
      ,[DESCONTO_SOBRE_3]
      ,[DESCONTO_SOBRE_4]
      ,[MPADRAO_DESCONTO]
      ,[MPADRAO_DESCONTO_COND_PGTO]
      ,[MPADRAO_ENCARGO]
      ,[MPADRAO_FRETE]
      ,[MPADRAO_SEGURO]
      ,[MPADRAO_VALOR_SUB_ITENS]
      ,[MPADRAO_VALOR_TOTAL]
      ,[MULTI_DESCONTO_ACUMULAR]
      ,[PORC_DESCONTO]
      ,[PORC_DESCONTO_BRUTO]
      ,[PORC_DESCONTO_COND_PGTO]
      ,[PORC_DESCONTO_DIGITADO]
      ,[PORC_ENCARGO]
      ,[VALOR_DIFERENCA_GUIA_FATURA]
      ,[VALOR_SUB_ITENS]
      ,[MPADRAO_IMPOSTO_AGREGAR]
      ,[VALOR_IMPOSTO_AGREGAR]
      ,[IMPRIMIR_ENDERECO_COBRANCA]
      ,[INDICA_CONSUMIDOR_FINAL]
      ,[BANCO]
      ,[AGENCIA]
      ,[RESPONSAVEL_TRANSPORTE]
      ,[NOTA_COMPLEMENTAR]
      ,[NUMERO_CONHECIMENTO_RELACIONADO]
      ,[PORC_DESCONTO_SEFAZ]
      ,[DESCONTO_SEFAZ]
      ,[MPADRAO_DESCONTO_SEFAZ]
      ,[ID_CAIXA_PGTO]
      ,[NRO_DE]
      ,[DATA_DE]
      ,[NATUREZA_EXPORTACAO]
      ,[NRO_RE]
      ,[DATA_RE]
      ,[NRO_CONHECIMENTO_EMBARQUE]
      ,[DATA_CONHECIMENTO]
      ,[TIPO_CONHECIMENTO]
      ,[COD_PAIS]
      ,[NRO_COMPROVANTE_EXPORTACAO]
      ,[DATA_COMPROVANTE_EXPORTACAO]
      ,[DATA_AVERBACAO]
      ,[NF_EMITIDA_EXPORTADOR]
      ,[COD_RELACIONAMENTO_RE_NF]
      ,[NF_E_NUMERO]
      ,[NF_E_DATA_EMISSAO]
      ,[NF_E_COD_VERIFICACAO]
      ,[NF_E_DATA_QUITACAO_GUIA]
      ,[NF_E_GERACAO]
      ,[SEQUENCIAL_UNICO]
      ,[DATA_GERACAO_NSU]
      ,[CODIGO_CLIENTE_VAREJO]
      ,[PIN]
      ,[CHAVE_NFE]
      ,[PROTOCOLO_AUTORIZACAO_NFE]
      ,[PROTOCOLO_CANCELAMENTO_NFE]
      ,[DATA_AUTORIZACAO_NFE]
      ,[GERAR_AUTOMATICO]
      ,[STATUS_NFE]
      ,[LOG_STATUS_NFE]
      ,[MOTIVO_CANCELAMENTO_NFE]
      ,[ITEM_NFE]
      ,[PRIORIZACAO]
      ,[REGISTRO_DPEC]
      ,[DATA_REGISTRO_DPEC]
      ,[TIPO_EMISSAO_NFE]
      ,[FIN_EMISSAO_NFE]
      ,[COD_MOTIVO_CANC]
      ,[VALOR_DESPACHO]
      ,[OBS_INTERESSE_FISCO]
      ,[DATA_CONTINGENCIA]
      ,[JUSTIFICATIVA_CONTINGENCIA]
      ,[UF_EMBARQUE_EXPORTACAO]
      ,[LOCAL_EMBARQUE_EXPORTACAO]
      ,[CFOP_CANCELAMENTO]
      ,[VALOR_IMPOSTO_INCIDENCIA]
      ,[MPADRAO_VALOR_IMPOSTO_INCIDENCIA]
      ,[VEICULO_PLACA]
      ,[UF_PLACA_VEICULO]
      ,[MARCA_VOLUMES]
      ,[NUMERACAO_VOLUMES]
      ,[INFORMACAO_COMPLEMENTAR]
      ,[DATA_HORA_EMISSAO]
      ,[INDICA_PRESENCA_COMPRADOR]
      ,[LOCAL_DESPACHO_EXPORTACAO]
      ,[UTC_DATA_AUTORIZACAO_NFE]
      ,[UTC_DATA_SAIDA]
      ,[UTC_EMISSAO]
      ,[INDICA_ENDERECO_ENTREGA])


SELECT A.[FILIAL]
      ,[NF_SAIDA]
      ,[SERIE_NF]
      ,[CODIGO_LOCAL_ENTREGA]
      ,[FILIAL_FATURADA]
      ,[TIPO_FATURAMENTO]
      ,[LANCAMENTO]
      ,A.[NOME_CLIFOR]
      ,[CONDICAO_PGTO]
      ,[NATUREZA_SAIDA]
      ,[TRANSPORTADORA]
      ,[TRANSP_REDESPACHO]
      ,[TIPO_FRETE]
      ,[COD_TRANSACAO]
      ,[EMISSAO]
      ,[DATA_SAIDA]
      ,[FRETE]
      ,[SEGURO]
      ,[DESCONTO]
      ,[DESCONTO_COND_PGTO]
      ,[ENCARGO]
      ,[ICMS]
      ,[IPI_VALOR]
      ,[VALOR_TOTAL]
      ,[QTDE_TOTAL]
      ,[NF_FATURA]
      ,[FATURA]
      ,[NOTA_IMPRESSA]
      ,[ACERTO_CONTAS_P_R]
      ,[TABELA_FILHA]
      ,[OBS]
      ,[PESO_LIQUIDO]
      ,[PESO_BRUTO]
      ,[VOLUMES]
      ,[TIPO_VOLUME]
      ,[CONFERIDO]
      ,[CONFERIDO_POR]
      ,[ENTREGA_CIF]
      ,A.[IRRF]
      ,[IRRF_RET_FONTE]
      ,[NOTA_CANCELADA]
      ,[DEVOLUCAO]
      ,[REPRESENTANTE]
      ,[COMISSAO]
      ,[PORCENTAGEM_ACERTO]
      ,[GERENTE]
      ,[COMISSAO_GERENTE]
      ,[DESCONTO_BRUTO]
      ,[CONFERENCIA]
      ,[MARCA_EXPORTACAO]
      ,A.[ATUALIZACAO_EXPORTAR]
      ,A.[DATA_EXPORTACAO]
      ,[ICMS_BASE]
      ,[STATUS_TRANSITO]
      ,[DATA_CANCELAMENTO]
      ,[VALOR_CANCELADO]
      ,[QTDE_CANCELADA]
      ,[MOEDA]
      ,[CAMBIO_NA_DATA]
      ,[COBRAR_MOEDA_PADRAO]
      ,[DATA_FATURAMENTO_RELATIVO]
      ,[RECARGO]
      ,A.[DATA_PARA_TRANSFERENCIA]
      ,[NOME_CLIFOR_ENTREGA]
      ,[TABELA_PRECO_FRETE]
      ,[VALOR_FRETE]
      ,[NOME_CLIFOR_COBRANCA]
      ,[OBS_TRANSPORTE]
      ,[VALOR_ADICIONAL]
      ,A.[EMPRESA]
      ,[IPI_ADICIONAL]
      ,[CTB_LANCAMENTO]
      ,[CTB_ITEM]
      ,[NUMERO_CONFERENCIA]
      ,[ICMS_ISENTO]
      ,[ICMS_OUTROS]
      ,D.[RATEIO_FILIAL]
      ,[RATEIO_CENTRO_CUSTO]
      ,[NUMERO_CONFERENCIA_ITEM]
      ,[FATURA_FILIAL]
      ,[FATURA_NUMERO]
      ,[FATURA_SERIE]
      ,A.[AGRUPAMENTO_ITENS]
      ,[COMISSAO_VALOR]
      ,[COMISSAO_VALOR_GERENTE]
      ,[DESCONTO_BRUTO_1]
      ,[DESCONTO_BRUTO_2]
      ,[DESCONTO_BRUTO_3]
      ,[DESCONTO_BRUTO_4]
      ,[DESCONTO_SOBRE_1]
      ,[DESCONTO_SOBRE_2]
      ,[DESCONTO_SOBRE_3]
      ,[DESCONTO_SOBRE_4]
      ,[MPADRAO_DESCONTO]
      ,[MPADRAO_DESCONTO_COND_PGTO]
      ,[MPADRAO_ENCARGO]
      ,[MPADRAO_FRETE]
      ,[MPADRAO_SEGURO]
      ,[MPADRAO_VALOR_SUB_ITENS]
      ,[MPADRAO_VALOR_TOTAL]
      ,[MULTI_DESCONTO_ACUMULAR]
      ,[PORC_DESCONTO]
      ,[PORC_DESCONTO_BRUTO]
      ,[PORC_DESCONTO_COND_PGTO]
      ,[PORC_DESCONTO_DIGITADO]
      ,[PORC_ENCARGO]
      ,[VALOR_DIFERENCA_GUIA_FATURA]
      ,[VALOR_SUB_ITENS]
      ,[MPADRAO_IMPOSTO_AGREGAR]
      ,[VALOR_IMPOSTO_AGREGAR]
      ,[IMPRIMIR_ENDERECO_COBRANCA]
      ,[INDICA_CONSUMIDOR_FINAL]
      ,A.[BANCO]
      ,[AGENCIA]
      ,[RESPONSAVEL_TRANSPORTE]
      ,[NOTA_COMPLEMENTAR]
      ,[NUMERO_CONHECIMENTO_RELACIONADO]
      ,[PORC_DESCONTO_SEFAZ]
      ,[DESCONTO_SEFAZ]
      ,[MPADRAO_DESCONTO_SEFAZ]
      ,[ID_CAIXA_PGTO]
      ,[NRO_DE]
      ,[DATA_DE]
      ,[NATUREZA_EXPORTACAO]
      ,[NRO_RE]
      ,[DATA_RE]
      ,[NRO_CONHECIMENTO_EMBARQUE]
      ,[DATA_CONHECIMENTO]
      ,[TIPO_CONHECIMENTO]
      ,[COD_PAIS]
      ,[NRO_COMPROVANTE_EXPORTACAO]
      ,[DATA_COMPROVANTE_EXPORTACAO]
      ,[DATA_AVERBACAO]
      ,[NF_EMITIDA_EXPORTADOR]
      ,[COD_RELACIONAMENTO_RE_NF]
      ,[NF_E_NUMERO]
      ,[NF_E_DATA_EMISSAO]
      ,[NF_E_COD_VERIFICACAO]
      ,[NF_E_DATA_QUITACAO_GUIA]
      ,[NF_E_GERACAO]
      ,[SEQUENCIAL_UNICO]
      ,[DATA_GERACAO_NSU]
      ,[CODIGO_CLIENTE_VAREJO]
      ,[PIN]
      ,[CHAVE_NFE]
      ,[PROTOCOLO_AUTORIZACAO_NFE]
      ,[PROTOCOLO_CANCELAMENTO_NFE]
      ,[DATA_AUTORIZACAO_NFE]
      ,[GERAR_AUTOMATICO]
      ,[STATUS_NFE]
      ,[LOG_STATUS_NFE]
      ,[MOTIVO_CANCELAMENTO_NFE]
      ,[ITEM_NFE]
      ,[PRIORIZACAO]
      ,[REGISTRO_DPEC]
      ,[DATA_REGISTRO_DPEC]
      ,[TIPO_EMISSAO_NFE]
      ,[FIN_EMISSAO_NFE]
      ,[COD_MOTIVO_CANC]
      ,[VALOR_DESPACHO]
      ,[OBS_INTERESSE_FISCO]
      ,[DATA_CONTINGENCIA]
      ,[JUSTIFICATIVA_CONTINGENCIA]
      ,[UF_EMBARQUE_EXPORTACAO]
      ,[LOCAL_EMBARQUE_EXPORTACAO]
      ,[CFOP_CANCELAMENTO]
      ,[VALOR_IMPOSTO_INCIDENCIA]
      ,[MPADRAO_VALOR_IMPOSTO_INCIDENCIA]
      ,[VEICULO_PLACA]
      ,[UF_PLACA_VEICULO]
      ,[MARCA_VOLUMES]
      ,[NUMERACAO_VOLUMES]
      ,[INFORMACAO_COMPLEMENTAR]
      ,[DATA_HORA_EMISSAO]
      ,[INDICA_PRESENCA_COMPRADOR]
      ,[LOCAL_DESPACHO_EXPORTACAO]
      ,[UTC_DATA_AUTORIZACAO_NFE]
      ,[UTC_DATA_SAIDA]
      ,[UTC_EMISSAO]
      ,[INDICA_ENDERECO_ENTREGA]
FROM DRLINGERIE.DBO.FATURAMENTO A
JOIN DRLINGERIE.DBO.FILIAIS B ON B.FILIAL=A.FILIAL
JOIN FILIAIS C ON C.CGC_CPF=B.CGC_CPF
JOIN W_CTB_RATEIO_FILIAIS D ON D.COD_FILIAL=C.COD_FILIAL
WHERE NOT EXISTS(SELECT * FROM FATURAMENTO WHERE NF_SAIDA=A.NF_SAIDA AND SERIE_NF=A.SERIE_NF AND NOME_CLIFOR=A.NOME_CLIFOR)
AND A.FILIAL='LAN�ADORA' and A.nf_saida='0000527' AND A.SERIE_NF='109'



INSERT INTO FATURAMENTO_ITEM ([CLASSIF_FISCAL]
      ,[CODIGO_FISCAL_OPERACAO]
      ,[CODIGO_ITEM]
      ,[COD_TABELA_FILHA]
      ,[COMISSAO_ITEM]
      ,[COMISSAO_ITEM_GERENTE]
      ,[CONTA_CONTABIL]
      ,[DESCONTO_ITEM]
      ,[DESCRICAO_ITEM]
      ,[FAIXA]
      ,[FILIAL]
      ,[ID_EXCECAO_IMPOSTO]
      ,[INDICADOR_CFOP]
      ,[ITEM_IMPRESSAO]
      ,[MPADRAO_DESCONTO_ITEM]
      ,[MPADRAO_PRECO_UNITARIO]
      ,[MPADRAO_VALOR_ITEM]
      ,[NF_SAIDA]
      ,[PESO]
      ,[PORCENTAGEM_ITEM_RATEIO]
      ,[PRECO_UNITARIO]
      ,[QTDE_DEVOLVIDA]
      ,[QTDE_ITEM]
      ,[QTDE_RETORNAR_BENEFICIAMENTO]
      ,[SERIE_NF]
      ,[SUB_ITEM_TAMANHO]
      ,[TRIBUT_ICMS]
      ,[TRIBUT_ORIGEM]
      ,[UNIDADE]
      ,[VALOR_ITEM]
      ,[REFERENCIA]
      ,[REFERENCIA_ITEM]
      ,[REFERENCIA_PEDIDO]
      ,[MPADRAO_VALOR_DESCONTOS]
      ,[MPADRAO_VALOR_ENCARGOS]
      ,[NAO_SOMA_VALOR]
      ,[OBS_ITEM]
      ,[ITEM_NFE]
      ,[RATEIO_FILIAL]
      ,[RATEIO_CENTRO_CUSTO]
      ,[MPADRAO_SEGURO_ITEM]
      ,[MPADRAO_FRETE_ITEM]
      ,[MPADRAO_ENCARGO_ITEM]
      ,[ORIGEM_ITEM]
      ,[VALOR_IMPOSTO_ITEM]
      ,[INDICA_PRODUTO_PROCESSO]
      ,[CODIGO_FCI]
      ,[PRECO_UNITARIO_ORIGINAL]
      ,[CTB_TIPO_OPERACAO]
      ,[ID_SUB_PROJETO]
      ,[VALOR_IMPOSTO_ITEM_MUNICIPAL]
      ,[VALOR_IMPOSTO_ITEM_ESTADUAL]
      ,[ID_CEST_NCM])

SELECT [CLASSIF_FISCAL]
      ,A.[CODIGO_FISCAL_OPERACAO]
      ,[CODIGO_ITEM]
      ,[COD_TABELA_FILHA]
      ,[COMISSAO_ITEM]
      ,[COMISSAO_ITEM_GERENTE]
      ,A.[CONTA_CONTABIL]
      ,[DESCONTO_ITEM]
      ,[DESCRICAO_ITEM]
      ,[FAIXA]
      ,A.[FILIAL]
      ,C.[ID_EXCECAO_IMPOSTO]
      ,A.[INDICADOR_CFOP]
      ,[ITEM_IMPRESSAO]
      ,[MPADRAO_DESCONTO_ITEM]
      ,[MPADRAO_PRECO_UNITARIO]
      ,[MPADRAO_VALOR_ITEM]
      ,[NF_SAIDA]
      ,[PESO]
      ,[PORCENTAGEM_ITEM_RATEIO]
      ,[PRECO_UNITARIO]
      ,[QTDE_DEVOLVIDA]
      ,[QTDE_ITEM]
      ,[QTDE_RETORNAR_BENEFICIAMENTO]
      ,[SERIE_NF]
      ,[SUB_ITEM_TAMANHO]
      ,A.[TRIBUT_ICMS]
      ,A.[TRIBUT_ORIGEM]
      ,[UNIDADE]
      ,[VALOR_ITEM]
      ,[REFERENCIA]
      ,[REFERENCIA_ITEM]
      ,[REFERENCIA_PEDIDO]
      ,[MPADRAO_VALOR_DESCONTOS]
      ,[MPADRAO_VALOR_ENCARGOS]
      ,[NAO_SOMA_VALOR]
      ,[OBS_ITEM]
      ,[ITEM_NFE]
      ,F.[RATEIO_FILIAL]
      ,[RATEIO_CENTRO_CUSTO]
      ,[MPADRAO_SEGURO_ITEM]
      ,[MPADRAO_FRETE_ITEM]
      ,[MPADRAO_ENCARGO_ITEM]
      ,[ORIGEM_ITEM]
      ,[VALOR_IMPOSTO_ITEM]
      ,[INDICA_PRODUTO_PROCESSO]
      ,[CODIGO_FCI]
      ,[PRECO_UNITARIO_ORIGINAL]
      ,A.[CTB_TIPO_OPERACAO]
      ,[ID_SUB_PROJETO]
      ,[VALOR_IMPOSTO_ITEM_MUNICIPAL]
      ,[VALOR_IMPOSTO_ITEM_ESTADUAL]
      ,[ID_CEST_NCM]
FROM DRLINGERIE.DBO.FATURAMENTO_ITEM A
JOIN DRLINGERIE.DBO.CTB_EXCECAO_IMPOSTO B ON B.ID_EXCECAO_IMPOSTO=A.ID_EXCECAO_IMPOSTO
JOIN CTB_EXCECAO_IMPOSTO C ON C.NATUREZA_SAIDA=B.NATUREZA_SAIDA
JOIN DRLINGERIE.DBO.FILIAIS D ON D.FILIAL=A.FILIAL
JOIN FILIAIS E ON E.CGC_CPF=D.CGC_CPF
JOIN W_CTB_RATEIO_FILIAIS F ON F.COD_FILIAL=E.COD_FILIAL
WHERE EXISTS(SELECT * FROM FATURAMENTO WHERE NF_SAIDA=A.NF_SAIDA AND SERIE_NF=A.SERIE_NF)
AND A.FILIAL='LAN�ADORA' AND A.nf_saida='0000527' AND A.SERIE_NF='109'
AND C.INATIVO=0

EXEC LX_GERA_IMPOSTOS_SAIDA  'LAN�ADORA','0000527','109',1,1,1

SELECT * FROM DRLINGERIE.DBO.FATURAMENTO_ITEM
WHERE NF_SAIDA='0000576        ' AND SERIE_NF='109'

SELECT * FROM FATURAMENTO_IMPOSTO
WHERE nf_saida='0000527' AND SERIE_NF='109'

SELECT 'EXEC LX_GERA_IMPOSTOS_SAIDA '''+RTRIM(FILIAL)+''','+''''+RTRIM(NF_SAIDA)+''','+''''+RTRIM(SERIE_NF)+''',1,1,1' 
FROM FATURAMENTO A
WHERE SERIE_NF='113' AND NOT EXISTS (SELECT NF_SAIDA,SERIE_NF FROM FATURAMENTO_IMPOSTO WHERE NF_SAIDA=A.NF_SAIDA AND SERIE_NF=A.SERIE_NF)

SELECT * FROM DRLINGERIE.DBO.CTB_EXCECAO_IMPOSTO
WHERE ID_EXCECAO_IMPOSTO=1236

SELECT * FROM CTB_EXCECAO_IMPOSTO
WHERE natureza_saida='141.01' and INATIVO=0 AND DESC_EXCECAO LIKE 'RETORNO DE INSUM%'