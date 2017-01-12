SELECT * FROM CTB_LANCAMENTO_ITEM
WHERE LANCAMENTO='259575'



INSERT INTO [DRVAREJO].[dbo].[CTB_LANCAMENTO_ITEM]           ([EMPRESA]
           ,[LANCAMENTO]           ,[ITEM]           ,[CONTA_CONTABIL]           ,[LX_TIPO_LANCAMENTO]           ,[CREDITO]
           ,[DEBITO]           ,[HISTORICO]           ,[CODIGO_HISTORICO]           ,[RATEIO_CENTRO_CUSTO]           ,[CONCILIADO]
           ,[PERMITE_ALTERACAO]           ,[DISPARA_FORMULA]           ,[DEBITO_MOEDA]           ,[CREDITO_MOEDA]
           ,[GERADO_AUTOMATICO_TIPO]           ,[DATA_DIGITACAO]           ,[RATEIO_FILIAL]           ,[COD_CLIFOR]
           ,[MOEDA]           ,[CAMBIO_NA_DATA]           ,[ID_CONTRAPARTIDA]           ,[VALOR_FINANCEIRO]
           ,[VALOR_FINANCEIRO_PADRAO]           ,[DATA_MOV]           ,[USUARIO_MOV]           ,[DOCUMENTO])
VALUES('1','259575','3','3110102','VMS',11812.50,0,'VENDA NESTA DATA','LMC','01',0,0,0,0,11812.50,1,'2013-04-24 00:00:00.000','000001','031082','R$',1.000000,1,0.00,0.00,GETDATE(),'SA',NULL)
     

INSERT INTO [DRVAREJO].[dbo].[CTB_LANCAMENTO_ITEM]           ([EMPRESA]
           ,[LANCAMENTO]           ,[ITEM]           ,[CONTA_CONTABIL]           ,[LX_TIPO_LANCAMENTO]           ,[CREDITO]
           ,[DEBITO]           ,[HISTORICO]           ,[CODIGO_HISTORICO]           ,[RATEIO_CENTRO_CUSTO]           ,[CONCILIADO]
           ,[PERMITE_ALTERACAO]           ,[DISPARA_FORMULA]           ,[DEBITO_MOEDA]           ,[CREDITO_MOEDA]
           ,[GERADO_AUTOMATICO_TIPO]           ,[DATA_DIGITACAO]           ,[RATEIO_FILIAL]           ,[COD_CLIFOR]
           ,[MOEDA]           ,[CAMBIO_NA_DATA]           ,[ID_CONTRAPARTIDA]           ,[VALOR_FINANCEIRO]
           ,[VALOR_FINANCEIRO_PADRAO]           ,[DATA_MOV]           ,[USUARIO_MOV]           ,[DOCUMENTO])
VALUES('1','259575','4','1120106','IAC',43.58,0,'ESTORNO','LMC','01',0,0,0,0,43.58,1,'2013-04-24 00:00:00.000','000001','001247','R$',1.000000,1,0.00,0.00,GETDATE(),'SA',NULL)
     
