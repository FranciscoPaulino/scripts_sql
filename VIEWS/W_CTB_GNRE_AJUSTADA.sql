USE [DRLINGERIE]
GO

/****** Object:  View [dbo].[W_CTB_GNRE]    Script Date: 17/03/2017 15:31:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER VIEW [dbo].[W_CTB_GNRE] 
AS
  -- 19/10/2016 - LUCAS SOUZA	  - #3# - ID 10912 - 02.16    - PREENCHER O C�DIGO IBGE DE MUNIC�PIO MESMO CASO SEJA CLIENTE VAREJO
  -- 15/09/2016 - CARLOS ALBERTO  - #2# - ID 3598 - 02.16     - ALTERA��O PARA TRAZER NOS CAMPOS 'SACADO' OS DADOS DO TERCEIRO DA NOTA FISCAL EMITIDA
  -- 10/02/2016 - MARCELO FUSTINI -     - ID 1635 - 02.15.013 - CRIA��O DA VIEW  
  SELECT CTB_A_PAGAR_PARCELA.EMPRESA, 
         CTB_A_PAGAR_PARCELA.LANCAMENTO, 
         CTB_LANCAMENTO.TIPO_MOVIMENTO, 
         CTB_MOVIMENTO_TIPO.DESC_TIPO_MOVIMENTO, 
         CTB_LANCAMENTO.LOTE_LANCAMENTO, 
         CTB_LANCAMENTO.LANCAMENTO_PADRAO, 
         CTB_LANCAMENTO.GERADO_INTEGRACAO, 
         CTB_LANCAMENTO.DATA_LANCAMENTO, 
         CTB_LANCAMENTO.COD_FILIAL                                                                                        AS COD_FILIAL_LANCAMENTO,
         FILIAIS_LANCAMENTO.FILIAL                                                                                        AS FILIAL_LANCAMENTO,
         CTB_A_PAGAR_PARCELA.ITEM, 
         CTB_LANCAMENTO_ITEM.CONTA_CONTABIL, 
         CTB_CONTA_PLANO.DESC_CONTA, 
         CTB_LANCAMENTO_ITEM.LX_TIPO_LANCAMENTO, 
         CTB_LX_LANCAMENTO_TIPO.DESC_TIPO_LANCAMENTO, 
         CTB_LANCAMENTO_ITEM.HISTORICO, 
         CTB_LANCAMENTO_ITEM.RATEIO_CENTRO_CUSTO, 
         CTB_CENTRO_CUSTO_RATEIO.DESC_RATEIO_CENTRO_CUSTO, 
         CTB_LANCAMENTO_ITEM.CONCILIADO, 
         CTB_LANCAMENTO.DATA_DIGITACAO, 
         CTB_LANCAMENTO_ITEM.RATEIO_FILIAL, 
         CTB_FILIAL_RATEIO.DESC_RATEIO_FILIAL, 
         CTB_A_PAGAR_FATURA.COD_CLIFOR, 
         CADASTRO_CLI_FOR.NOME_CLIFOR, 
         CADASTRO_CLI_FOR.RAZAO_SOCIAL, 
         CTB_LANCAMENTO_ITEM.MOEDA                                                                                        AS MOEDA_LANCAMENTO,
         CTB_LANCAMENTO_ITEM.CAMBIO_NA_DATA                                                                               AS CAMBIO_NA_DATA_LANCAMENTO,
         CTB_A_PAGAR_FATURA.FATURA, 
         CASE 
           WHEN CTB_A_PAGAR_FATURA.FATURA LIKE '%-%' THEN SUBSTRING(CTB_A_PAGAR_FATURA.FATURA, 1, CHARINDEX('-', CTB_A_PAGAR_FATURA.FATURA, 1) - 1)
		   WHEN CTB_A_PAGAR_FATURA.FATURA LIKE '%/%' THEN SUBSTRING(CTB_A_PAGAR_FATURA.FATURA, 1, CHARINDEX('/', CTB_A_PAGAR_FATURA.FATURA, 1) - 1)
           ELSE CTB_A_PAGAR_FATURA.FATURA 
         END																											  AS FATURA_GNRE,
         CTB_A_PAGAR_FATURA.ESPECIE_SERIE, 
         CTB_A_PAGAR_FATURA.LX_TIPO_DOCUMENTO, 
         CTB_LX_DOCUMENTO_TIPO.TIPO_DOCUMENTO, 
         CTB_A_PAGAR_FATURA.EMISSAO, 
         CTB_A_PAGAR_FATURA.FATURA_SERIE, 
         CTB_A_PAGAR_FATURA.FATURA_OK, 
         CTB_A_PAGAR_FATURA.POSSUI_ENTRADA, 
         CTB_A_PAGAR_FATURA.PROVISAO, 
         CTB_A_PAGAR_FATURA.COMPLEMENTO_NOME, 
         CTB_A_PAGAR_FATURA.TAXA_JUROS, 
         CTB_A_PAGAR_FATURA.CAMBIO_NA_DATA_EMISSAO, 
         CTB_A_PAGAR_FATURA.TAXA_MULTA, 
         CTB_A_PAGAR_FATURA.DATA_ENTRADA, 
         CTB_A_PAGAR_FATURA.NUMERO_ENTRADA, 
         CTB_A_PAGAR_FATURA.COD_FILIAL, 
         FILIAIS.FILIAL, 
         F.PJ_PF                                                                                                          AS PJ_PF_FILIAL,
         F.CGC_CPF                                                                                                        AS CNPJ_FILIAL,
         F.RAZAO_SOCIAL                                                                                                   AS RAZAO_FILIAL,
         F.ENDERECO                                                                                                       AS ENDERECO_FILIAL,
         F.COD_MUNICIPIO_IBGE                                                                                             AS COD_MUNICIPIO_IBGE_FILIAL,
         F.UF                                                                                                             AS UF_FILIAL,
         F.CEP                                                                                                            AS CEP_FILIAL,
         F.TELEFONE1                                                                                                      AS TELEFONE_FILIAL,
         CTB_A_PAGAR_FATURA.MOEDA, 
         CTB_A_PAGAR_PARCELA.ID_PARCELA, 
         CTB_A_PAGAR_PARCELA.BANCO, 
         CTB_A_PAGAR_PARCELA.CONTA_PORTADOR, 
         CTB_CONTA_PLANO_PORTADOR.DESC_CONTA                                                                              AS DESC_CONTA_PORTADOR,
         CTB_A_PAGAR_PARCELA.DATA_DESCONTO_VENC, 
         CTB_A_PAGAR_PARCELA.DESCONTO_VENC, 
         CTB_A_PAGAR_PARCELA.NUMERO_BANCARIO, 
         CTB_A_PAGAR_PARCELA.VENCIMENTO, 
         CTB_A_PAGAR_PARCELA.DIAS_PRORROGADOS, 
         CTB_A_PAGAR_PARCELA.PAGAMENTO_APROVADO, 
         CTB_A_PAGAR_PARCELA.CODIGO_BARRA, 
         CTB_A_PAGAR_PARCELA.VENCIMENTO_REAL, 
         CTB_A_PAGAR_PARCELA.VALOR_ORIGINAL, 
         CTB_A_PAGAR_PARCELA.VALOR_ORIGINAL_PADRAO, 
         CTB_A_PAGAR_PARCELA.VALOR_A_PAGAR, 
         W_CTB_A_PAGAR_PARCELA_SALDO.VALOR_A_PAGAR_PADRAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.SALDO_PRINCIPAL_DEVIDO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.SALDO_MULTA_GERADA, 
         W_CTB_A_PAGAR_PARCELA_SALDO.SALDO_JUROS_GERADO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.SALDO_DESCONTO_OBTIDO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_PRINCIPAL_PAGO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_MULTA_PAGA, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_JUROS_PAGO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_DESCONTO_EFETIVADO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_MULTA_GERADA, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_JUROS_GERADO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_DESCONTO_OBTIDO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_PRINCIPAL_PAGO_PADRAO, 
         CASE 
           WHEN DATEDIFF(DD, W_CTB_A_PAGAR_PARCELA_SALDO.VENCIMENTO_REAL, GETDATE()) > 0 THEN 'VENCIDOS'
           WHEN DATEDIFF(DD, W_CTB_A_PAGAR_PARCELA_SALDO.VENCIMENTO_REAL, GETDATE()) < 0 THEN 'A VENCER'
           WHEN DATEDIFF(DD, W_CTB_A_PAGAR_PARCELA_SALDO.VENCIMENTO_REAL, GETDATE()) = 0 THEN 'VENCENDO HOJE'
         END                                                                                                              AS POSICAO,
         DATEDIFF(DD, W_CTB_A_PAGAR_PARCELA_SALDO.VENCIMENTO_REAL, GETDATE())                                             AS PERIODO,
         FORNECEDORES.TIPO, 
         FORNECEDORES.SUBTIPO_FORNECEDOR, 
         CTB_CONTA_PLANO_PORTADOR.ID_CARTEIRA_COBRANCA, 
         CTB_CARTEIRA_COBRANCA.CARTEIRA, 
         ASSINATURA_PA.LOTE_DOCUMENTO                                                                                     AS LOTE_DOCUMENTO_PA,
         ASSINATURA_CP.LOTE_DOCUMENTO                                                                                     AS LOTE_DOCUMENTO_CP,
         W_CTB_RATEIO_FILIAL_MATRIZ_CONTABIL.MATRIZ_CONTABIL, 
         W_CTB_RATEIO_FILIAL_MATRIZ_CONTABIL.COD_MATRIZ_CONTABIL, 
         W_CTB_A_PAGAR_PARCELA_CONTA_CONTRAPARTIDA.CONTA_CONTABIL_CONTRAPARTIDA, 
         CTB_CONTA_PLANO_CONTRAPARTIDA.DESC_CONTA                                                                         AS DESC_CONTA_CONTRAPARTIDA,
         COALESCE(CADASTRO_CLI_FOR_SACADO.COD_CLIFOR, CLIENTES_VAREJO_SACADO.CODIGO_CLIENTE)                              AS COD_CLIFOR_SACADO,		/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.NOME_CLIFOR, CLIENTES_VAREJO_SACADO.CLIENTE_VAREJO)                             AS NOME_CLIFOR_SACADO,	/*#2#*/
         CAST(FORNECEDORES.TIPO AS VARCHAR(100))                                                                          AS TIPO_FORNECEDOR,
         CTB_A_PAGAR_PARCELA.VALOR_OUTRAS_ENTIDADES, 
         W_CTB_A_PAGAR_PARCELA_SALDO.VALOR_FINANCEIRO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.VALOR_FINANCEIRO_PADRAO, 
         CASE 
           WHEN PRAZO_PAGAMENTO_REAL = 0 THEN ABS(CAST(ISNULL(CTB_A_PAGAR_FATURA.EMISSAO, 0) AS INT) - CAST(ISNULL(CTB_A_PAGAR_PARCELA.VENCIMENTO, 0) AS INT))
           ELSE PRAZO_PAGAMENTO_REAL 
         END                                                                                                              AS PRAZO_PAGAMENTO_REAL,
         ABS(CAST(ISNULL(CTB_A_PAGAR_FATURA.EMISSAO, 0) AS INT) - CAST(ISNULL(CTB_A_PAGAR_PARCELA.VENCIMENTO, 0) AS INT)) AS PRAZO_COMPRA,
         CASE 
           WHEN ABS(CAST(ISNULL(CTB_A_PAGAR_FATURA.EMISSAO, 0) AS INT) - CAST(ISNULL(CTB_A_PAGAR_PARCELA.VENCIMENTO, 0) AS INT)) > PRAZO_PAGAMENTO_REAL THEN ABS(CAST(ISNULL(CTB_A_PAGAR_FATURA.EMISSAO, 0) AS INT) - CAST(ISNULL(CTB_A_PAGAR_PARCELA.VENCIMENTO, 0) AS INT))
           ELSE PRAZO_PAGAMENTO_REAL 
         END                                                                                                              AS PRAZO_PAGAMENTO_MEDIO,
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_MULTA_PAGA_PADRAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_JUROS_PAGO_PADRAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_DESCONTO_EFETIVADO_PADRAO, 
         CTB_A_PAGAR_FATURA.DOCUMENTO, 
         CTB_LANCAMENTO.NUMERO_CORRELATIVO, 
         COALESCE(CADASTRO_CLI_FOR_SACADO.CEP, CLIENTES_VAREJO_SACADO.CEP)                                                AS CEP_SACADO,				/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.PJ_PF, 0)                                                                       AS PJ_PF_SACADO,				/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.CGC_CPF, CLIENTES_VAREJO_SACADO.CPF_CGC)                                        AS CNPJ_SACADO,				/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.ENDERECO, CLIENTES_VAREJO_SACADO.ENDERECO)                                      AS ENDERECO_SACADO,			/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.COD_MUNICIPIO_IBGE, LCF_LX_MUNICIPIO.COD_MUNICIPIO_IBGE, '') /*#3#*/			  AS COD_MUNICIPIO_IBGE_SACADO,	/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.RG_IE, CLIENTES_VAREJO_SACADO.RG_IE)                                            AS INSCRICAO_ESTADUAL_SACADO,	/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.CIDADE, CLIENTES_VAREJO_SACADO.CIDADE)                                          AS MUNICIPIO_SACADO,			/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.RAZAO_SOCIAL, CLIENTES_VAREJO_SACADO.CLIENTE_VAREJO)                            AS RAZAO_SOCIAL_SACADO,		/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.TELEFONE1, CLIENTES_VAREJO_SACADO.TELEFONE)                                     AS TELEFONE_SACADO,			/*#2#*/
         COALESCE(CADASTRO_CLI_FOR_SACADO.UF, CLIENTES_VAREJO_SACADO.UF)                                                  AS UF_SACADO,					/*#2#*/
         CTB_LOTE.DESC_LOTE, 
         CTB_LOTE.DATA_EXPORTACAO                                                                                         AS DATA_LOTE,
         CTB_LOTE.CONCILIADO                                                                                              AS LOTE_CONCILIADO,
         CTB_CONTA_PLANO.CODIGO_RESUMIDO, 
         CTB_CONTA_PLANO.DESC_CONTA_REDUZIDA, 
         CTB_LX_LANCAMENTO_TIPO.CONTA_PADRAO, 
         CTB_LX_LANCAMENTO_TIPO.CREDITO_DEBITO, 
         CTB_LX_LANCAMENTO_TIPO.INDICA_ID_CONTABIL_TERCEIRO, 
         CTB_LANCAMENTO_ITEM.CODIGO_HISTORICO, 
         CADASTRO_CLI_FOR.CGC_CPF, 
         CTB_LX_DOCUMENTO_TIPO.SERIE_NF, 
         CTB_LX_DOCUMENTO_TIPO.NOME_RECIBO, 
         CTB_A_PAGAR_FATURA.NUMERO_PARCELAS, 
         CTB_A_PAGAR_PARCELA.ID_ASSINATURA_DOCUMENTO, 
         CTB_A_PAGAR_PARCELA.ID_ASSINATURA_APROVACAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.SALDO_PRINCIPAL_DEVIDO_PADRAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.SALDO_MULTA_GERADA_PADRAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.SALDO_JUROS_GERADO_PADRAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.SALDO_DESCONTO_OBTIDO_PADRAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_MULTA_GERADA_PADRAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_JUROS_GERADO_PADRAO, 
         W_CTB_A_PAGAR_PARCELA_SALDO.TOTAL_DESCONTO_OBTIDO_PADRAO, 
         CTB_A_PAGAR_PARCELA.CAMBIO_FIXO_PGTO, 
         EM_CARTEIRA = CONVERT(BIT, CASE 
                                      WHEN CTB_LANCAMENTO_ITEM.CONTA_CONTABIL = CTB_A_PAGAR_PARCELA.CONTA_PORTADOR THEN 1
                                      ELSE 0 
                                    END), 
         EM_COBRANCA = CONVERT(BIT, CASE 
                                      WHEN CTB_LANCAMENTO_ITEM.CONTA_CONTABIL = CTB_A_PAGAR_PARCELA.CONTA_PORTADOR THEN 0
                                      ELSE 1 
                                    END), 
         POSSUI_DEBITO = CONVERT(BIT, 0), 
         CADASTRO_CLI_FOR.COBRANCA_CIDADE, 
         CADASTRO_CLI_FOR.COBRANCA_BAIRRO, 
         CADASTRO_CLI_FOR.COBRANCA_UF, 
         ISNULL(FATURAMENTO.CHAVE_NFE, LOJA_NOTA_FISCAL.CHAVE_NFE)                                                        AS CHAVE_NFE_SAIDA,
         ISNULL(FATURAMENTO.INFORMACAO_COMPLEMENTAR, LOJA_NOTA_FISCAL.INFORMACAO_COMPLEMENTAR)                            AS OBS_SAIDA,
         REPLICATE('0', (2 - LEN(MONTH(CTB_A_PAGAR_FATURA.EMISSAO)))) 
         + CAST(MONTH(CTB_A_PAGAR_FATURA.EMISSAO) AS CHAR(2))                                                             AS MES_EMISSAO,
         CAST(YEAR(CTB_A_PAGAR_FATURA.EMISSAO) AS CHAR(4))                                                                AS ANO_EMISSAO,
         LF_DADOS_ARRECADACAO.PERIODICIDADE, 
         LF_DADOS_ARRECADACAO.VARIACAO 		 
  FROM   CTB_A_PAGAR_PARCELA 
         INNER JOIN CTB_A_PAGAR_FATURA 
                 ON CTB_A_PAGAR_PARCELA.EMPRESA = CTB_A_PAGAR_FATURA.EMPRESA 
                    AND CTB_A_PAGAR_PARCELA.LANCAMENTO = CTB_A_PAGAR_FATURA.LANCAMENTO 
                    AND CTB_A_PAGAR_PARCELA.ITEM = CTB_A_PAGAR_FATURA.ITEM 
         INNER JOIN LF_DADOS_ARRECADACAO 
                 ON CTB_A_PAGAR_FATURA.ID_DADOS_ARRECADACAO = LF_DADOS_ARRECADACAO.ID_DADOS_ARRECADACAO
         INNER JOIN W_CTB_A_PAGAR_PARCELA_SALDO 
                 ON CTB_A_PAGAR_PARCELA.EMPRESA = W_CTB_A_PAGAR_PARCELA_SALDO.EMPRESA 
                    AND CTB_A_PAGAR_PARCELA.LANCAMENTO = W_CTB_A_PAGAR_PARCELA_SALDO.LANCAMENTO
                    AND CTB_A_PAGAR_PARCELA.ITEM = W_CTB_A_PAGAR_PARCELA_SALDO.ITEM 
                    AND CTB_A_PAGAR_PARCELA.ID_PARCELA = W_CTB_A_PAGAR_PARCELA_SALDO.ID_PARCELA
         INNER JOIN CTB_LANCAMENTO_ITEM 
                 ON CTB_A_PAGAR_PARCELA.EMPRESA = CTB_LANCAMENTO_ITEM.EMPRESA 
                    AND CTB_A_PAGAR_PARCELA.LANCAMENTO = CTB_LANCAMENTO_ITEM.LANCAMENTO 
                    AND CTB_A_PAGAR_PARCELA.ITEM = CTB_LANCAMENTO_ITEM.ITEM 
         INNER JOIN CTB_LANCAMENTO 
                 ON CTB_LANCAMENTO.EMPRESA = CTB_LANCAMENTO_ITEM.EMPRESA 
                    AND CTB_LANCAMENTO.LANCAMENTO = CTB_LANCAMENTO_ITEM.LANCAMENTO 
         INNER JOIN CTB_CONTA_PLANO 
                 ON CTB_LANCAMENTO_ITEM.CONTA_CONTABIL = CTB_CONTA_PLANO.CONTA_CONTABIL 
         INNER JOIN CTB_LX_LANCAMENTO_TIPO 
                 ON CTB_LANCAMENTO_ITEM.LX_TIPO_LANCAMENTO = CTB_LX_LANCAMENTO_TIPO.LX_TIPO_LANCAMENTO
         INNER JOIN FILIAIS 
                 ON CTB_A_PAGAR_FATURA.COD_FILIAL = FILIAIS.COD_FILIAL 
         LEFT JOIN DBO.LOJAS_VAREJO 
                ON FILIAIS.FILIAL = LOJAS_VAREJO.FILIAL 
         INNER JOIN CADASTRO_CLI_FOR AS F 
                 ON FILIAIS.FILIAL = F.NOME_CLIFOR 
         INNER JOIN CADASTRO_CLI_FOR 
                 ON CTB_A_PAGAR_FATURA.COD_CLIFOR = CADASTRO_CLI_FOR.COD_CLIFOR 
		 /*#2#*/
         /*INNER JOIN CADASTRO_CLI_FOR CADASTRO_CLI_FOR_SACADO 
                 ON LF_DADOS_ARRECADACAO.COD_CLIFOR = CADASTRO_CLI_FOR_SACADO.COD_CLIFOR */
         INNER JOIN FILIAIS FILIAIS_LANCAMENTO 
                 ON CTB_LANCAMENTO.COD_FILIAL = FILIAIS_LANCAMENTO.COD_FILIAL 
         LEFT JOIN FORNECEDORES 
                ON CADASTRO_CLI_FOR.COD_CLIFOR = FORNECEDORES.COD_FORNECEDOR 
         LEFT JOIN CTB_MOVIMENTO_TIPO 
                ON CTB_LANCAMENTO.TIPO_MOVIMENTO = CTB_MOVIMENTO_TIPO.TIPO_MOVIMENTO 
         LEFT JOIN CTB_CONTA_PLANO CTB_CONTA_PLANO_PORTADOR 
                ON CTB_A_PAGAR_PARCELA.CONTA_PORTADOR = CTB_CONTA_PLANO_PORTADOR.CONTA_CONTABIL
         LEFT JOIN CTB_CARTEIRA_COBRANCA 
                ON CTB_CONTA_PLANO_PORTADOR.ID_CARTEIRA_COBRANCA = CTB_CARTEIRA_COBRANCA.ID_CARTEIRA_COBRANCA
         LEFT JOIN CTB_LX_DOCUMENTO_TIPO 
                ON CTB_A_PAGAR_FATURA.LX_TIPO_DOCUMENTO = CTB_LX_DOCUMENTO_TIPO.LX_TIPO_DOCUMENTO
         LEFT JOIN CTB_FILIAL_RATEIO 
                ON CTB_LANCAMENTO_ITEM.RATEIO_FILIAL = CTB_FILIAL_RATEIO.RATEIO_FILIAL 
         LEFT JOIN CTB_CENTRO_CUSTO_RATEIO 
                ON CTB_LANCAMENTO_ITEM.RATEIO_CENTRO_CUSTO = CTB_CENTRO_CUSTO_RATEIO.RATEIO_CENTRO_CUSTO
         LEFT JOIN CTB_LOTE 
                ON CTB_LANCAMENTO.LOTE_LANCAMENTO = CTB_LOTE.LOTE_LANCAMENTO 
         LEFT JOIN AE_AUTENTICACAO ASSINATURA_CP 
                ON CTB_A_PAGAR_PARCELA.ID_ASSINATURA_DOCUMENTO = ASSINATURA_CP.ID_ASSINATURA_DOCUMENTO
         LEFT JOIN AE_AUTENTICACAO ASSINATURA_PA 
                ON CTB_A_PAGAR_PARCELA.ID_ASSINATURA_APROVACAO = ASSINATURA_PA.ID_ASSINATURA_DOCUMENTO
         LEFT JOIN W_CTB_RATEIO_FILIAL_MATRIZ_CONTABIL 
                ON W_CTB_RATEIO_FILIAL_MATRIZ_CONTABIL.RATEIO_FILIAL = CTB_LANCAMENTO_ITEM.RATEIO_FILIAL
         LEFT JOIN W_CTB_A_PAGAR_PARCELA_CONTA_CONTRAPARTIDA 
                ON W_CTB_A_PAGAR_PARCELA_CONTA_CONTRAPARTIDA.EMPRESA = CTB_A_PAGAR_PARCELA.EMPRESA
                   AND W_CTB_A_PAGAR_PARCELA_CONTA_CONTRAPARTIDA.LANCAMENTO = CTB_A_PAGAR_PARCELA.LANCAMENTO
                   AND W_CTB_A_PAGAR_PARCELA_CONTA_CONTRAPARTIDA.ITEM = CTB_A_PAGAR_PARCELA.ITEM
         LEFT JOIN CTB_CONTA_PLANO CTB_CONTA_PLANO_CONTRAPARTIDA 
                ON CTB_CONTA_PLANO_CONTRAPARTIDA.CONTA_CONTABIL = W_CTB_A_PAGAR_PARCELA_CONTA_CONTRAPARTIDA.CONTA_CONTABIL_CONTRAPARTIDA
         LEFT JOIN CTB_LX_DOCUMENTO_TIPO CTB_LX_DOCUMENTO_TIPO_PARCELA 
                ON CTB_A_PAGAR_PARCELA.LX_TIPO_DOCUMENTO_PARCELA = CTB_LX_DOCUMENTO_TIPO_PARCELA.LX_TIPO_DOCUMENTO
         LEFT JOIN CTB_LX_METODO_PAGAMENTO CTB_LX_METODO_PAGAMENTO 
                ON CTB_A_PAGAR_PARCELA.LX_METODO_PAGAMENTO_PARCELA = CTB_LX_METODO_PAGAMENTO.LX_METODO_PAGAMENTO
         LEFT JOIN DBO.FATURAMENTO 
                ON FATURAMENTO.CTB_LANCAMENTO = CTB_A_PAGAR_FATURA.LANCAMENTO 
                   AND FATURAMENTO.EMPRESA = CTB_A_PAGAR_FATURA.EMPRESA 
                   --AND FATURAMENTO.FILIAL = FILIAIS.FILIAL 
         LEFT JOIN DBO.LOJA_NOTA_FISCAL 
                ON LOJA_NOTA_FISCAL.CTB_LANCAMENTO = CTB_A_PAGAR_FATURA.LANCAMENTO 
                   AND LOJA_NOTA_FISCAL.EMPRESA = CTB_A_PAGAR_FATURA.EMPRESA 
                   AND LOJA_NOTA_FISCAL.CODIGO_FILIAL = LOJAS_VAREJO.CODIGO_FILIAL 
                   AND LOJA_NOTA_FISCAL.RECEBIMENTO = 0 
		/*#2#*/
		LEFT JOIN CADASTRO_CLI_FOR CADASTRO_CLI_FOR_SACADO 
                 ON CTB_A_PAGAR_FATURA.COD_CLIFOR_SACADO = CADASTRO_CLI_FOR_SACADO.COD_CLIFOR 
		LEFT JOIN CLIENTES_VAREJO CLIENTES_VAREJO_SACADO 
                 ON LOJA_NOTA_FISCAL.CODIGO_CLIENTE = CLIENTES_VAREJO_SACADO.CODIGO_CLIENTE
		/*#3#*/
		LEFT JOIN LCF_LX_UF
			ON LCF_LX_UF.UF = CLIENTES_VAREJO_SACADO.UF
		LEFT JOIN LCF_LX_MUNICIPIO 
			ON LCF_LX_MUNICIPIO.DESC_MUNICIPIO = CLIENTES_VAREJO_SACADO.CIDADE
			AND LCF_LX_MUNICIPIO.ID_UF = LCF_LX_UF.ID_UF
		/*#2#*/
  WHERE  CTB_A_PAGAR_FATURA.LX_TIPO_DOCUMENTO = 12;

GO

