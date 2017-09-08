--- LMC
--- INSERT SEGUNDA PERNA LANCAMENTO 
INSERT INTO [afrodite].[dbo].[CTB_LANCAMENTO_ITEM]           ([EMPRESA]
           ,[LANCAMENTO]           ,[ITEM]           ,[CONTA_CONTABIL]           ,[LX_TIPO_LANCAMENTO]           ,[CREDITO]
           ,[DEBITO]           ,[HISTORICO]           ,[CODIGO_HISTORICO]           ,[RATEIO_CENTRO_CUSTO]           ,[CONCILIADO]
           ,[PERMITE_ALTERACAO]           ,[DISPARA_FORMULA]           ,[DEBITO_MOEDA]           ,[CREDITO_MOEDA]
           ,[GERADO_AUTOMATICO_TIPO]           ,[DATA_DIGITACAO]           ,[RATEIO_FILIAL]           ,[COD_CLIFOR]
           ,[MOEDA]           ,[CAMBIO_NA_DATA]           ,[ID_CONTRAPARTIDA]           ,[VALOR_FINANCEIRO]
           ,[VALOR_FINANCEIRO_PADRAO]           ,[DATA_MOV]           ,[USUARIO_MOV]           ,[DOCUMENTO])
VALUES('1',
'3156',
'2','29204','LMC',
158.17,0,
'SAIDA DE MERCADORIA P/RETORNO FUTURO','LMC','01',0,0,0,0,
158.17,1,
'2015-05-14 00:00:00.000',
'601408','018855','R$',1.000000,1,0.00,0.00,GETDATE(),'SA',NULL)

update [afrodite].[dbo].[CTB_LANCAMENTO_ITEM]
set  rateio_filial='601408'
where lancamento='5203' and item = 2

--- LMD
--- INSERT SEGUNDA PERNA LANCAMENTO 
INSERT INTO [afrodite].[dbo].[CTB_LANCAMENTO_ITEM]           ([EMPRESA]
           ,[LANCAMENTO]           ,[ITEM]           ,[CONTA_CONTABIL]           ,[LX_TIPO_LANCAMENTO]           ,[CREDITO]
           ,[DEBITO]           ,[HISTORICO]           ,[CODIGO_HISTORICO]           ,[RATEIO_CENTRO_CUSTO]           ,[CONCILIADO]
           ,[PERMITE_ALTERACAO]           ,[DISPARA_FORMULA]           ,[DEBITO_MOEDA]           ,[CREDITO_MOEDA]
           ,[GERADO_AUTOMATICO_TIPO]           ,[DATA_DIGITACAO]           ,[RATEIO_FILIAL]           ,[COD_CLIFOR]
           ,[MOEDA]           ,[CAMBIO_NA_DATA]           ,[ID_CONTRAPARTIDA]           ,[VALOR_FINANCEIRO]
           ,[VALOR_FINANCEIRO_PADRAO]           ,[DATA_MOV]           ,[USUARIO_MOV]           ,[DOCUMENTO])
VALUES('1',
'5191',
'2','19104','LMD',
0,343.52,
'SAIDA DE MERCADORIA P/RETORNO FUTURO','LMD','01',0,0,0,0,
343.52,1,
'2015-10-19 00:00:00.000',
'601408','018855','R$',1.000000,1,0.00,0.00,GETDATE(),'SA',NULL)
