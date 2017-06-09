-- CAPA 
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\Arquivo_Integracao_Pedido_2017-18896_V201746112434.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)
SELECT
	  NFe.value('NumeroOrdemCompra[1]','varchar(50)') AS cNumeroOrdemCompra,
      NFe.value('DataEmissao[1]','varchar(50)') AS cDataEmissao,
      -- Dados Solicitante
      NFe.value('DadosSolicitante[1]/NomeSolicitante[1]','varchar(50)') AS cNomeSolicitante,
	  NFe.value('DadosSolicitante[1]/FilialSolicitante[1]','varchar(50)') AS cFilialSolicitante,
	  NFe.value('DadosSolicitante[1]/Cnpj[1]','varchar(50)') AS cCnpjSolicitante,
	  NFe.value('DadosSolicitante[1]/InscricaoEstadual[1]','varchar(50)') AS cInscricaoEstadualSolicitante,
	  -- Dados Entrega Faturamento
	  NFe.value('DadosEntregaFaturamento[1]/SemanaEntrega[1]','varchar(50)') AS cSemanaEntrega,
	  NFe.value('DadosEntregaFaturamento[1]/DataInicialSemanaEntrega[1]','varchar(50)') AS cDataInicialSemanaEntrega,
	  NFe.value('DadosEntregaFaturamento[1]/DataFinalSemanaEntrega[1]','varchar(50)') AS cDataFinalSemanaEntrega,
	  NFe.value('DadosEntregaFaturamento[1]/PrazoPagamento[1]/DiasParcela[1]','varchar(50)') AS cDiasParcela,
  	  NFe.value('DadosEntregaFaturamento[1]/PrazoPagamento[1]/PrevisaoData[1]','varchar(50)') AS cPrevisaoData

FROM @XML.nodes('//OrdemCompra') AS NFes(NFe) -- Caminho que ira iniciar a varredura


-- CAPA REFERENCIAS
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\Arquivo_Integracao_Pedido_2017-18896_V201746112434.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)
SELECT
      NFe.value('CodigoProduto[1]','varchar(50)') AS cCodigoProduto,
	  NFe.value('DescricaoProduto[1]','varchar(50)') AS cDescricaoProduto,
	  NFe.value('ProCodNome[1]','varchar(50)') AS cProCodNome,
	  NFe.value('ReferenciaProduto[1]','varchar(50)') AS cReferenciaProduto,
	  NFe.value('QuantidadeTotalItem[1]','varchar(50)') AS cQuantidadeTotalItem,
	  NFe.value('PrecoFornecedor[1]','varchar(50)') AS cPrecoFornecedor,
	  NFe.value('ValorDescontos[1]','varchar(50)') AS cValorDescontos,
	  NFe.value('PrecoUnitarioFinal[1]','varchar(50)') AS cPrecoUnitarioFinal

FROM @XML.nodes('//OrdemCompra/ItensOrdemCompra/ItemOrdemCompra') AS NFes(NFe) -- Caminho que ira iniciar a varredura


-- Dados da Ordem de Compra SKU
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\Arquivo_Integracao_Pedido_2017-18896_V201746112434.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)
SELECT
      -- Dados da Ordem de Compra
	  NFe.value('../../../../NumeroOrdemCompra[1]','varchar(50)') AS cNumeroOrdemCompra,
      NFe.value('../../../../DataEmissao[1]','varchar(50)') AS cDataEmissao,
      -- Dados Solicitante
      NFe.value('../../../../DadosSolicitante[1]/NomeSolicitante[1]','varchar(50)') AS cNomeSolicitante,
	  NFe.value('../../../../DadosSolicitante[1]/FilialSolicitante[1]','varchar(50)') AS cFilialSolicitante,
	  NFe.value('../../../../DadosSolicitante[1]/Cnpj[1]','varchar(50)') AS cCnpjSolicitante,
	  NFe.value('../../../../DadosSolicitante[1]/InscricaoEstadual[1]','varchar(50)') AS cInscricaoEstadualSolicitante,
	  -- Dados Entrega Faturamento
	  NFe.value('../../../../DadosEntregaFaturamento[1]/SemanaEntrega[1]','varchar(50)') AS cSemanaEntrega,
	  NFe.value('../../../../DadosEntregaFaturamento[1]/DataInicialSemanaEntrega[1]','varchar(50)') AS cDataInicialSemanaEntrega,
	  NFe.value('../../../../DadosEntregaFaturamento[1]/DataFinalSemanaEntrega[1]','varchar(50)') AS cDataFinalSemanaEntrega,
	  NFe.value('../../../../DadosEntregaFaturamento[1]/PrazoPagamento[1]/DiasParcela[1]','varchar(50)') AS cDiasParcela,
  	  NFe.value('../../../../DadosEntregaFaturamento[1]/PrazoPagamento[1]/PrevisaoData[1]','varchar(50)') AS cPrevisaoData,

	  -- Dados da Referencia
      NFe.value('../../CodigoProduto[1]','varchar(50)') AS cCodigoProduto,
	  NFe.value('../../DescricaoProduto[1]','varchar(50)') AS cDescricaoProduto,
	  NFe.value('../../ProCodNome[1]','varchar(50)') AS cProCodNome,
	  NFe.value('../../ReferenciaProduto[1]','varchar(50)') AS cReferenciaProduto,
	  NFe.value('../../QuantidadeTotalItem[1]','varchar(50)') AS cQuantidadeTotalItem,
	  NFe.value('../../PrecoFornecedor[1]','varchar(50)') AS cPrecoFornecedor,
	  NFe.value('../../ValorDescontos[1]','varchar(50)') AS cValorDescontos,
	  NFe.value('../../PrecoUnitarioFinal[1]','varchar(50)') AS cPrecoUnitarioFinal,
	  -- SKU da Referencia
      NFe.value('CodigoVariacao[1]','varchar(50)') AS cCodigoVariacao,
	  NFe.value('DescricaoVariacaoCompleta[1]','varchar(50)') AS cDescricaoVariacaoCompleta,
	  NFe.value('DescricaoVariacaoParteA[1]','varchar(50)') AS cDescricaoVariacaoParteA,
	  NFe.value('DescricaoVariacaoParteB[1]','varchar(50)') AS cDescricaoVariacaoParteB,
	  NFe.value('CodigoBarrasVariacao[1]','varchar(50)') AS cCodigoBarrasVariacao,
	  NFe.value('QuantidadePrimariaTotalSolicitada[1]','varchar(50)') AS cQuantidadePrimariaTotalSolicitada

FROM @XML.nodes('//OrdemCompra/ItensOrdemCompra/ItemOrdemCompra/DetalhamentoVariacoesItem/VariacaoItem') AS NFes(NFe) -- Caminho que ira iniciar a varredura


EXEC LX_IMPORTA_XML_HAVAN


USE [DESENV]
GO
/****** Object:  StoredProcedure [dbo].[LX_IMPORTA_XML_NFE_ENTRADAS]    Script Date: 05/05/2017 16:25:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[LX_IMPORTA_XML_HAVAN] @MENSAGEM VARCHAR(MAX) 
AS    
SET NOCOUNT OFF    
SET ANSI_WARNINGS ON    
    
DECLARE @MSG_XML AS XML,  @XML AS XML, @CHAVE_NFE AS VARCHAR(44),@DTH_RECEBIMENTO AS VARCHAR(30),@TIPO_EMISSAO  VARCHAR(2), @STATUS AS INT,    
		@CNPJ_EMITENTE AS VARCHAR(14), @NUMERO_PROTOCOLO VARCHAR(15),@CNPJ_DESTINATARIO AS VARCHAR(14), @MOTIVO AS VARCHAR(500),      
		@ID_MSG AS INT, @MENSAGEM_ERRO AS VARCHAR(1000), @CONTINGENCIA VARCHAR(10), @CHAVE_NFE_DPEC  AS VARCHAR(44), @DHREGDPEC AS VARCHAR(24),    
		@NREGDPEC AS VARCHAR(15), @DH_CONTINGENCIA VARCHAR(24), @JUSTIFICATIVA VARCHAR(256), @AMBIENTE AS VARCHAR(1),   
		@RETORNO INT, @ID_PROCESSO INT, @ITEM_PROCESSO INT, @STATUS_PROCESSO TINYINT, @COD_LAYOUT_NFE AS SMALLINT, @ID_EDI_ARQUIVO AS INT,    
		@TIPO_DOC CHAR(2), @CMD VARCHAR(2000), @TABELA_STATUS VARCHAR(30), @FILIAL VARCHAR(25), @NF_SAIDA CHAR(7), @SERIE_NF CHAR(2), @ID_CAIXA_PGTO INT,    
		@GERA_FINANCEIRO BIT, @ERRMSG VARCHAR(8000), @XMLNAMESPACE AS BIT,  @IDDPEC VARCHAR(25), @ERRNO AS INT, 
		@STATUS_LINX INT, @NOME_CLIFOR VARCHAR(25), @CHAVE_NFE_LINX AS VARCHAR(44), @TIPO_MENSAGEM AS VARCHAR(1), @INFORMACAO_COMP as VARCHAR(MAX),  
		@EMAIL_NFE VARCHAR(60),@CNPJ_TRANSPORTADORA AS VARCHAR(14), @NUMERO_MODELO AS VARCHAR(3),          
		@NF_ENTRADA CHAR(15), @SERIE_NF_ENTRADA VARCHAR(6) -- #2#

SET @CHAVE_NFE_LINX= NULL    
SET @TIPO_MENSAGEM = '0'    
SET @MSG_XML = CONVERT(XML,@MENSAGEM)     
SET @XML = CONVERT(XML,@MENSAGEM)     
  
BEGIN     
	-- Dados da Ordem de Compra SKU
	SELECT
		  -- Dados da Ordem de Compra
		  NFe.value('../../../../NumeroOrdemCompra[1]','varchar(50)') AS cNumeroOrdemCompra,
		  NFe.value('../../../../DataEmissao[1]','varchar(50)') AS cDataEmissao,
		  -- Dados Solicitante
		  NFe.value('../../../../DadosSolicitante[1]/NomeSolicitante[1]','varchar(50)') AS cNomeSolicitante,
		  NFe.value('../../../../DadosSolicitante[1]/FilialSolicitante[1]','varchar(50)') AS cFilialSolicitante,
		  NFe.value('../../../../DadosSolicitante[1]/Cnpj[1]','varchar(50)') AS cCnpjSolicitante,
		  NFe.value('../../../../DadosSolicitante[1]/InscricaoEstadual[1]','varchar(50)') AS cInscricaoEstadualSolicitante,
		  -- Dados Entrega Faturamento
		  NFe.value('../../../../DadosEntregaFaturamento[1]/SemanaEntrega[1]','varchar(50)') AS cSemanaEntrega,
		  NFe.value('../../../../DadosEntregaFaturamento[1]/DataInicialSemanaEntrega[1]','varchar(50)') AS cDataInicialSemanaEntrega,
		  NFe.value('../../../../DadosEntregaFaturamento[1]/DataFinalSemanaEntrega[1]','varchar(50)') AS cDataFinalSemanaEntrega,
		  NFe.value('../../../../DadosEntregaFaturamento[1]/PrazoPagamento[1]/DiasParcela[1]','varchar(50)') AS cDiasParcela,
  		  NFe.value('../../../../DadosEntregaFaturamento[1]/PrazoPagamento[1]/PrevisaoData[1]','varchar(50)') AS cPrevisaoData,

		  -- Dados da Referencia
		  NFe.value('../../CodigoProduto[1]','varchar(50)') AS cCodigoProduto,
		  NFe.value('../../DescricaoProduto[1]','varchar(50)') AS cDescricaoProduto,
		  NFe.value('../../ProCodNome[1]','varchar(50)') AS cProCodNome,
		  NFe.value('../../ReferenciaProduto[1]','varchar(50)') AS cReferenciaProduto,
		  NFe.value('../../QuantidadeTotalItem[1]','varchar(50)') AS cQuantidadeTotalItem,
		  NFe.value('../../PrecoFornecedor[1]','varchar(50)') AS cPrecoFornecedor,
		  NFe.value('../../ValorDescontos[1]','varchar(50)') AS cValorDescontos,
		  NFe.value('../../PrecoUnitarioFinal[1]','varchar(50)') AS cPrecoUnitarioFinal,
		  -- SKU da Referencia
		  NFe.value('CodigoVariacao[1]','varchar(50)') AS cCodigoVariacao,
		  NFe.value('DescricaoVariacaoCompleta[1]','varchar(50)') AS cDescricaoVariacaoCompleta,
		  NFe.value('DescricaoVariacaoParteA[1]','varchar(50)') AS cDescricaoVariacaoParteA,
		  NFe.value('DescricaoVariacaoParteB[1]','varchar(50)') AS cDescricaoVariacaoParteB,
		  NFe.value('CodigoBarrasVariacao[1]','varchar(50)') AS cCodigoBarrasVariacao,
		  NFe.value('QuantidadePrimariaTotalSolicitada[1]','varchar(50)') AS cQuantidadePrimariaTotalSolicitada

	FROM @XML.nodes('//OrdemCompra/ItensOrdemCompra/ItemOrdemCompra/DetalhamentoVariacoesItem/VariacaoItem') AS NFes(NFe) -- Caminho que ira iniciar a varredura
END 

