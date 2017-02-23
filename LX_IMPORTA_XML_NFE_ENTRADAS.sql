USE [WM]
GO
/****** Object:  StoredProcedure [dbo].[LX_IMPORTA_XML_NFE_ENTRADAS]    Script Date: 22/02/2017 07:54:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[LX_IMPORTA_XML_NFE_ENTRADAS] @MENSAGEM VARCHAR(MAX) 
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
    
    -- TRATAMENTO DE MENSAGEM FORA DO PADRAO NFEPROT E PROTNFE COM STATUS     
	IF @MENSAGEM NOT LIKE '%nfeProc%' AND @MENSAGEM NOT LIKE '%protNFe%' AND @MENSAGEM IS NOT NULL    
	BEGIN    
		
		SELECT @STATUS_LINX = 97, @MENSAGEM_ERRO = 'Mensagem de retorno fora do padrão da SEFAZ(nfeProc / protNFe). Impossível processar o retorno da NF-e!'    
       
		SELECT @MENSAGEM_ERRO = ''''+CHAR(13)+'CHAVE NFE: '+@CHAVE_NFE_LINX+CHAR(13)+'STATUS: '+CAST(@STATUS_LINX AS VARCHAR(5))+CHAR(13)+'MOTIVO: '+@MENSAGEM_ERRO+CHAR(13)+''''    
      
		---------------------------------------------------------    
		-- GRAVA O LOG E ATUALIZA NOTA COM RETORNO FORA DO PADRAO    
		---------------------------------------------------------    
		EXEC @RETORNO = LX_EXECUTE_PROCESS 'LX_IMPORTA_XML_NFE_ENTRADAS',@MENSAGEM_ERRO     
		
		SELECT	@ID_PROCESSO = PA.ID_PROCESSO, @ITEM_PROCESSO =  PA.ITEM_PROCESSO, @STATUS_PROCESSO = PA.STATUS_PROCESSO     
		FROM	PROCESSOS_SISTEMA_ATIVIDADES PA (NOLOCK)     
		INNER JOIN PROCESSOS_SISTEMA PS (NOLOCK) ON PA.ID_PROCESSO = PS.ID_PROCESSO     
		WHERE	PA.ITEM_PROCESSO = @RETORNO    
				AND PS.NOME_PROCESSO = 'LX_IMPORTA_XML_NFE_ENTRADAS'    
    
	END     
        
	SELECT	@TIPO_EMISSAO = NULL, @DH_CONTINGENCIA = NULL, @JUSTIFICATIVA = NULL, @CHAVE_NFE = NULL    
	select	@CHAVE_NFE   = cast(@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:protNFe/ns0:infProt/ns0:chNFe)') AS varchar(44))-- as chNFe    
	select	@DTH_RECEBIMENTO  = cast(@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:protNFe/ns0:infProt/ns0:dhRecbto)') AS varchar(30))-- as dhRecbto    
	select	@STATUS    = cast(@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:protNFe/ns0:infProt/ns0:cStat)') AS VARCHAR(5)) -- as cStat    
	select	@MOTIVO    = cast(@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:protNFe/ns0:infProt/ns0:xMotivo)') AS varchar(500)) -- as xMotivo    
	select	@NUMERO_PROTOCOLO = cast(@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:protNFe/ns0:infProt/ns0:nProt)') AS varchar(15)) -- as nProt
	select	@TIPO_EMISSAO  = cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:ide/ns0:tpEmis)') AS varchar(2))  -- as tpEmis    
	select	@DH_CONTINGENCIA  = cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:ide/ns0:dhCont)') AS varchar(25)) -- as dhCont    
	select	@JUSTIFICATIVA  = cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:ide/ns0:xJust)') AS varchar(256)) -- as xJust    
	select	@INFORMACAO_COMP  = cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:infAdic/ns0:InfCpl)') AS varchar(max)) -- as infCpl    
	select	@CNPJ_EMITENTE    = case when cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:emit/ns0:CNPJ)') AS varchar(14)) = '' then  -- as CNPJ    
			cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:emit/ns0:CPF)') AS varchar(11)) else -- as CPF     
			cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:emit/ns0:CNPJ)') AS varchar(14)) end -- as CNPJ    
	select	@CNPJ_DESTINATARIO   = case when cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:dest/ns0:CNPJ)') AS varchar(14)) = '' then   -- as CNPJ    
			cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:dest/ns0:CPF)') AS varchar(11)) else -- as CPF    
			cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:dest/ns0:CNPJ)') AS varchar(14)) end-- as CNPJ   
	select	@AMBIENTE = cast(@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:protNFe/ns0:infProt/ns0:tpAmb)') AS varchar(1)) -- as tpAmb
	select	@NUMERO_MODELO = cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:ide/ns0:mod)') AS varchar(3)) -- as mod
	
	--**#3#
	SELECT	@DTH_RECEBIMENTO = SUBSTRING(REPLACE(@DTH_RECEBIMENTO,'T',' '),1,19)
	
	
	SELECT	@MOTIVO = DBO.FX_REPLACE_CARACTER_ESPECIAL_NFE(DEFAULT,@MOTIVO)   
	SELECT	@EMAIL_NFE =           cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:dest/ns0:email)') AS varchar(60)) --
	SELECT	@CNPJ_TRANSPORTADORA = cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:transp/ns0:transporta/ns0:CNPJ)') AS varchar(60)) -- as CNPJ

	-- #2#
	SELECT	@NF_ENTRADA = cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:ide/ns0:nNF)') AS varchar(9)) -- as nNF
	SELECT	@NF_ENTRADA = REPLICATE(0, (7-LEN(RTRIM(@NF_ENTRADA))))+RTRIM(@NF_ENTRADA)

	SELECT	@SERIE_NF_ENTRADA = cast (@msg_xml.query('declare namespace ns0="http://www.portalfiscal.inf.br/nfe";data(ns0:nfeProc/ns0:NFe/ns0:infNFe/ns0:ide/ns0:serie)') AS varchar(3)) -- as serie
	-- #2#

  
	SELECT	@CMD = NULL, @MENSAGEM_ERRO = '', @STATUS_LINX = 0    
	----------------------------------------------------------    
	-- FAZ A VERIFICACAO SOBRE QUAL TABELA VAI SER ATUALIZADA    
	----------------------------------------------------------    
	SELECT	@TIPO_DOC = NULL, @FILIAL = NULL, @NF_SAIDA = NULL, @SERIE_NF = NULL, @ID_CAIXA_PGTO = NULL, @NOME_CLIFOR = NULL    

	-- #2#
	SELECT @NOME_CLIFOR = FORNECEDOR FROM FORNECEDORES JOIN PARAMETROS_IMPORT_XML ON PARAMETROS_IMPORT_XML.COD_CLIFOR_SACADO=FORNECEDORES.CLIFOR WHERE CGC_CPF = @CNPJ_EMITENTE AND INATIVO = 0
	-- #2#

	SELECT	@CHAVE_NFE AS CHAVE_NFE, @DTH_RECEBIMENTO AS DATAHORA_RECEBIMENTO, @STATUS AS STATUS_PROTOCOLO,     
			@MOTIVO AS MOTIVO_PROTOCOLO, @NUMERO_PROTOCOLO AS NUMERO_PROTOCOLO, @TIPO_EMISSAO AS TIPO_EMISSAO,     
			@DH_CONTINGENCIA AS DATAHORA_CONTINGENCIA, @JUSTIFICATIVA AS JUSTIFICATIVA_CONTINGENCIA,     
			@CNPJ_EMITENTE AS CNPJ_EMITENTE, @CNPJ_DESTINATARIO AS CNPJ_DESTINATARIO, @AMBIENTE AS AMBIENTE,  
			@EMAIL_NFE AS EMAIL_DESTINATARIO,@CNPJ_TRANSPORTADORA AS CNPJ_TRANSPORTADORA, @NUMERO_MODELO AS NUMERO_MODELO_FISCAL, 
			@MSG_XML AS  XML_NFE,
			@NF_ENTRADA as NF_ENTRADA, @SERIE_NF_ENTRADA as SERIE_NF_ENTRADA, @NOME_CLIFOR as NOME_CLIFOR --#2#

    -- GRAVA DADOS NAS TABELAS CRIADAS PARA ARMAZENAR AS INFORMAÇÕES DO ARQUIVO XML DA NFE
	-- CAPA NFe
	;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
 
	INSERT INTO XML_NFE_CAPA (chNFe,nProt,dhRecbto,cUF,cNF,natOp,indPag,mod,serie,nNF,dhEmi,dhSaiEnt,tpNF,idDest,cMunFG,tpImp,
	tpEmis,cDV,tpAmb,finNFe,indFinal,indPres,procEmi,emit_CNPJ,emit_xNome,emit_xFant,emit_xLgr,emit_nro,emit_xBairro,emit_cMun,
	emit_xMun,emit_UF,emit_CEP,emit_cPais,emit_xPais,emit_fone,emit_IE,emit_CRT,dest_CNPJ,dest_xNome,dest_xLgr,dest_nro,dest_xBairro,
	dest_cMun,dest_xMun,dest_UF,dest_CEP,dest_cPais,dest_xPais,dest_fone,dest_indIEDest,dest_IE,dest_email,infAdic)
 
	SELECT
		NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') as chNFe
	,              NFe.value('../../../protNFe[1]/infProt[1]/nProt[1]', 'varchar(20)') as nProt
	,              NFe.value('../../../protNFe[1]/infProt[1]/dhRecbto[1]', 'datetime') as dhRecbto
	,              NFe.value('cUF[1]', 'char(2)') as cUF
	,              NFe.value('cNF[1]', 'char(10)') AS cNF
	,              NFe.value('natOp[1]','varchar(max)') as natOp
	,              NFe.value('indPag[1]', 'int') as indPag
	,              NFe.value('mod[1]', 'int') as mod
	,              NFe.value('serie[1]','int') as serie
	,              NFe.value('nNF[1]','char(10)') as nNF
	,              NFe.value('dhEmi[1]','datetime') as dhEmi
	,              NFe.value('dhSaiEnt[1]','datetime') as dhSaiEnt
	,              NFe.value('tpNF[1]','int') as tpNF
	,              NFe.value('idDest[1]','int') as idDest
	,              NFe.value('cMunFG[1]','int') as cMunFG
	,              NFe.value('tpImp[1]','int') as tpImp
	,              NFe.value('tpEmis[1]','int') as tpEmis
	,              NFe.value('cDV[1]','int') as cDV
	,              NFe.value('tpAmb[1]','int') as tpAmb
	,              NFe.value('finNFe[1]','int') as finNFe
	,              NFe.value('indFinal[1]','int') as indFinal
	,              NFe.value('indPres[1]','int') as indPres
	,              NFe.value('procEmi[1]','int') as procEmi
	,              NFe.value('../emit[1]/CNPJ[1]','varchar(20)') as emit_CNPJ
	,              NFe.value('../emit[1]/xNome[1]','varchar(80)') as emit_xNome
	,              NFe.value('../emit[1]/xFant[1]','varchar(30)') as emit_xFant
	,              NFe.value('../emit[1]/enderEmit[1]/xLgr[1]','varchar(max)') as emit_xLgr
	,              NFe.value('../emit[1]/enderEmit[1]/nro[1]','varchar(50)') as emit_nro
	,              NFe.value('../emit[1]/enderEmit[1]/xBairro[1]','varchar(max)') as emit_xBairro
	,              NFe.value('../emit[1]/enderEmit[1]/cMun[1]','int') as emit_cMun
	,              NFe.value('../emit[1]/enderEmit[1]/xMun[1]','varchar(50)') as emit_xMun
	,              NFe.value('../emit[1]/enderEmit[1]/UF[1]','char(2)') as emit_UF
	,              NFe.value('../emit[1]/enderEmit[1]/CEP[1]','char(10)') as emit_CEP
	,              NFe.value('../emit[1]/enderEmit[1]/cPais[1]','char(6)') as emit_cPais
	,              NFe.value('../emit[1]/enderEmit[1]/xPais[1]','char(20)') as emit_xPais
	,              NFe.value('../emit[1]/enderEmit[1]/fone[1]','char(20)') as emit_fone
	,              NFe.value('../emit[1]/IE[1]','char(20)') as emit_IE
	,              NFe.value('../emit[1]/CRT[1]','int') as emit_CRT
	,              NFe.value('../dest[1]/CNPJ[1]','varchar(20)') as dest_CNPJ
	,              NFe.value('../dest[1]/xNome[1]','varchar(80)') as dest_xNome
	,              NFe.value('../dest[1]/enderDest[1]/xLgr[1]','varchar(max)') as dest_xLgr
	,              NFe.value('../dest[1]/enderDest[1]/nro[1]','varchar(50)') as dest_nro
	,              NFe.value('../dest[1]/enderDest[1]/xBairro[1]','varchar(max)') as dest_xBairro
	,              NFe.value('../dest[1]/enderDest[1]/cMun[1]','int') as dest_cMun
	,              NFe.value('../dest[1]/enderDest[1]/xMun[1]','varchar(50)') as dest_xMun
	,              NFe.value('../dest[1]/enderDest[1]/UF[1]','char(2)') as dest_UF
	,              NFe.value('../dest[1]/enderDest[1]/CEP[1]','char(10)') as dest_CEP
	,              NFe.value('../dest[1]/enderDest[1]/cPais[1]','char(6)') as dest_cPais
	,              NFe.value('../dest[1]/enderDest[1]/xPais[1]','char(20)') as dest_xPais
	,              NFe.value('../dest[1]/enderDest[1]/fone[1]','char(20)') as dest_fone
	,              NFe.value('../dest[1]/indIEDest[1]','int') as dest_indIEDest
	,              NFe.value('../dest[1]/IE[1]','char(20)') as dest_IE
	,              NFe.value('../dest[1]/email[1]','varchar(80)') as dest_email
	,              NFe.value('../infAdic[1]/infCpl[1]','varchar(max)') as infAdic
	FROM @XML.nodes('//infNFe/ide') AS NFes(NFe) -- Caminho que ira iniciar a varredura

	-- ITENS NFE
	;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
 
	INSERT INTO XML_NFE_ITEM(chNFe,nItem,cProd,cEAN,xProd,NCM,CFOP,uCom,qCom,vUnCom,vProd,cEANTrib,uTrib,qTrib,vUnTrib,indTot,infAdProd,
	vTotTrib,ICMS_orig,ICMS_CST,ICMS_modBC,ICMS_vBC,ICMS_pICMS,ICMS_vICMS,IPI_cEnq,IPI_CST,IPI_vBC,IPI_pIPI,IPI_vIPI,PIS_CST,PIS_vBC,
	PIS_pPIS,PIS_vPIS,COFINS_CST,COFINS_vBC,COFINS_pCOFINS,COFINS_vCOFINS)
 
	SELECT
		   NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AS chNFe
	,      NFe.value('@nItem', 'int') AS nItem
	,      NFe.value('prod[1]/cProd[1]','varchar(50)') AS cProd
	,      NFe.value('prod[1]/cEAN[1]','varchar(30)') AS cEAN
	,      NFe.value('prod[1]/xProd[1]','varchar(max)') AS xProd
	,      NFe.value('prod[1]/NCM[1]','varchar(20)') AS NCM
	,      NFe.value('prod[1]/CFOP[1]','varchar(4)') AS CFOP
	,      NFe.value('prod[1]/uCom[1]','varchar(10)') AS uCom
	,      NFe.value('prod[1]/qCom[1]','numeric(15,4)') AS qCom
	,      NFe.value('prod[1]/vUnCom[1]','numeric(25,10)') AS vUnCom
	,      NFe.value('prod[1]/vProd[1]','numeric(15,2)') AS vProd
	,      NFe.value('prod[1]/cEANTrib[1]','varchar(30)') AS cEANTrib
	,      NFe.value('prod[1]/uTrib[1]','varchar(10)') AS uTrib
	,      NFe.value('prod[1]/qTrib[1]','numeric(15,4)') AS qTrib
	,      NFe.value('prod[1]/vUnTrib[1]','numeric(25,10)') AS vUnTrib
	,      NFe.value('prod[1]/indTot[1]','char(1)') AS indTot
	,      NFe.value('prod[1]/infAdProd[1]','varchar(max)') AS infAdProd
		   -- ICMS
	,      NFe.value('imposto[1]/vTotTrib[1]','numeric(14,2)') AS vTotTrib
	,      NFe.value('imposto[1]/ICMS[1]/ICMS40[1]/orig[1]','int') AS ICMS_orig
	,      NFe.value('imposto[1]/ICMS[1]/ICMS40[1]/CST[1]','char(5)') AS ICMS_CST
	,      NFe.value('imposto[1]/ICMS[1]/ICMS40[1]/modBC[1]','int') AS ICMS_modBC
	,      NFe.value('imposto[1]/ICMS[1]/ICMS40[1]/vBC[1]','numeric(14,2)') AS ICMS_vBC
	,      NFe.value('imposto[1]/ICMS[1]/ICMS40[1]/pICMS[1]','numeric(18,4)') AS ICMS_pICMS
	,      NFe.value('imposto[1]/ICMS[1]/ICMS40[1]/vICMS[1]','numeric(14,2)') AS ICMS_vICMS
		   -- IPI
	,      NFe.value('imposto[1]/IPI[1]/cEnq[1]','char(3)') AS IPI_cEnq
	,      NFe.value('imposto[1]/IPI[1]/IPITrib[1]/CST[1]','char(3)') AS IPI_CST
	,      NFe.value('imposto[1]/IPI[1]/IPITrib[1]/vBC[1]','numeric(14,2)') AS IPI_vBC
	,      NFe.value('imposto[1]/IPI[1]/IPITrib[1]/pIPI[1]','numeric(18,4)') AS IPI_pIPI
	,      NFe.value('imposto[1]/IPI[1]/IPITrib[1]/vIPI[1]','numeric(14,2)') AS IPI_vIPI
		   -- PIS
	,      NFe.value('imposto[1]/PIS[1]/PISAliq[1]/CST[1]','char(3)') AS PIS_CST
	,      NFe.value('imposto[1]/PIS[1]/PISAliq[1]/vBC[1]','numeric(14,2)') AS PIS_vBC
	,      NFe.value('imposto[1]/PIS[1]/PISAliq[1]/pPIS[1]','numeric(18,4)') AS PIS_pPIS
	,      NFe.value('imposto[1]/PIS[1]/PISAliq[1]/vPIS[1]','numeric(14,2)') AS PIS_vPIS
		   -- COFINS
	,      NFe.value('imposto[1]/COFINS[1]/COFINSAliq[1]/CST[1]','char(3)') AS COFINS_CST
	,      NFe.value('imposto[1]/COFINS[1]/COFINSAliq[1]/vBC[1]','numeric(14,2)') AS COFINS_vBC
	,      NFe.value('imposto[1]/COFINS[1]/COFINSAliq[1]/pCOFINS[1]','numeric(18,4)') AS COFINS_pCOFINS
	,      NFe.value('imposto[1]/COFINS[1]/COFINSAliq[1]/vCOFINS[1]','numeric(14,2)') AS COFINS_vCOFINS
	FROM @XML.nodes('//infNFe/det') AS NFes(NFe) -- Caminho que ira iniciar a varredura
	order by nItem
 
 
	-- TOTAL NFE
	;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
 
	INSERT INTO XML_NFE_TOTAL(chNFe,vBC,vICMS,vICMSDeson,vBCST,vST,vProd,vFrete,vSeg,vDesc,vII,vIPI,vPIS,vCOFINS,vOutro,vNF,vTotTrib)
	SELECT
		   NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AS chNFe
	,      NFe.value('ICMSTot[1]/vBC[1]','numeric(14,2)') AS vBC
	,      NFe.value('ICMSTot[1]/vICMS[1]','numeric(14,2)') AS vICMS
	,      NFe.value('ICMSTot[1]/vICMSDeson[1]','numeric(14,2)') AS vICMSDeson
	,      NFe.value('ICMSTot[1]/vBCST[1]','numeric(14,2)') AS vBCST
	,      NFe.value('ICMSTot[1]/vST[1]','numeric(14,2)') AS vST
	,      NFe.value('ICMSTot[1]/vProd[1]','numeric(14,2)') AS vProd
	,      NFe.value('ICMSTot[1]/vFrete[1]','numeric(14,2)') AS vFrete
	,      NFe.value('ICMSTot[1]/vSeg[1]','numeric(14,2)') AS vSeg
	,      NFe.value('ICMSTot[1]/vDesc[1]','numeric(14,2)') AS vDesc
	,      NFe.value('ICMSTot[1]/vII[1]','numeric(14,2)') AS vII
	,      NFe.value('ICMSTot[1]/vIPI[1]','numeric(14,2)') AS vIPI
	,      NFe.value('ICMSTot[1]/vPIS[1]','numeric(14,2)') AS vPIS
	,      NFe.value('ICMSTot[1]/vCOFINS[1]','numeric(14,2)') AS vCOFINS
	,      NFe.value('ICMSTot[1]/vOutro[1]','numeric(14,2)') AS vOutro
	,      NFe.value('ICMSTot[1]/vNF[1]','numeric(14,2)') AS vNF
	,      NFe.value('ICMSTot[1]/vTotTrib[1]','numeric(14,2)') AS vTotTrib
	FROM @XML.nodes('//infNFe/total') AS NFes(NFe) -- Caminho que ira iniciar a varredura
 
 
	-- Transportadora NFE
	;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
 
	INSERT INTO XML_NFE_TRANSPORTADOR(chNFe,modFrete,CNPJ,xNome,IE,xEnder,xMun,UF,qVol,esp,pesoL,pesoB)
	SELECT
		   NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AS chNFe
	,      NFe.value('modFrete[1]','int') AS modFrete
	,      NFe.value('transporta[1]/CNPJ[1]','char(14)') AS CNPJ
	,      NFe.value('transporta[1]/xNome[1]','varchar(80)') AS xNome
	,      NFe.value('transporta[1]/IE[1]','char(20)') AS IE
	,      NFe.value('transporta[1]/xEnder[1]','varchar(max)') AS xEnder
	,      NFe.value('transporta[1]/xMun[1]','varchar(35)') AS xMun
	,      NFe.value('transporta[1]/UF[1]','char(2)') AS UF
	,      NFe.value('vol[1]/qVol[1]','int') AS qVol
	,      NFe.value('vol[1]/esp[1]','varchar(40)') AS esp
	,      NFe.value('vol[1]/pesoL[1]','numeric(14,3)') AS pesoL
	,      NFe.value('vol[1]/pesoB[1]','numeric(14,3)') AS pesoB
	FROM @XML.nodes('//infNFe/transp') AS NFes(NFe) -- Caminho que ira iniciar a varredura
 
 	-- Duplicatas NFE
	;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
 
	INSERT INTO XML_NFE_DUPLICATA(chNFe,nFat,vOrig,vLiq,nDup,dVenc,vDup)
	SELECT
		   NFe.value('../../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AS chNFe
	,      NFe.value('../fat[1]/nFat[1]','char(10)') AS nFat
	,      NFe.value('../fat[1]/vOrig[1]','numeric(14,2)') AS vOrig
	,      NFe.value('../fat[1]/vLiq[1]','numeric(14,2)') AS vLiq
	,      NFe.value('nDup[1]','char(10)') AS nDup
	,      NFe.value('dVenc[1]','datetime') AS dVenc
	,      NFe.value('vDup[1]','numeric(14,2)') AS vDup
	FROM @XML.nodes('//infNFe/cobr/dup') AS NFes(NFe) -- Caminho que ira iniciar a varredura

	--- verificar os itens em FATURAMENTO_ITEM, pois o Linx retira caracteres especiais do XML
	update a
	set a.cProd=b.CODIGO_ITEM
	from XML_NFE_ITEM a with (nolock)
	join DRLINGERIE.dbo.faturamento_item b with (nolock) on substring(b.codigo_item,1,7) = substring(A.CPROD,1,7)
	join DRLINGERIE.dbo.faturamento c with (nolock) on c.CHAVE_NFE=a.chNFe
    where a.xprod like '%O.S.:%' and a.cProd <> b.CODIGO_ITEM and c.CHAVE_NFE=@CHAVE_NFE

    --- GRAVA OS DADOS NAS TABELAS ENTRADAS E ENTRADAS_ITEM E GERA IMPOSTOS E LANÇAMENTO CONTÁBIL
	--- entrada ordem de serviço
	---
	INSERT INTO ENTRADAS (
	NF_ENTRADA,                        
	NOME_CLIFOR,                       
	EMISSAO,                           
	FILIAL,                            
	EMPRESA,                           
	AGRUPAMENTO_ITENS,                 
	COD_TRANSACAO,                     
	NATUREZA,                          
	CONDICAO_PGTO,                     
	RECEBIMENTO,                       
	NF_FATURA,                         
	SERIE_NF_ENTRADA,                  
	TABELA_FILHA,                      
	TRANSF_FILIAL,                     
	TIPO_ENTRADAS,                     
	MOEDA,                             
	MOEDA_COMPRA,                      
	DATA_DIGITACAO,                    
	RATEIO_FILIAL,                     
	RATEIO_CENTRO_CUSTO,               
	DATA_FATURAMENTO_RELATIVO,         
	UTILIZA_DIAS_FIXOS_FORNECEDOR,     
	NOME_CLIFOR_TRIANGULAR,            
	SERIE_NF,                          
	NUMERO_ENTRADA,                    
	FATURA_NOME_CLIFOR,                
	FATURA_SERIE,                      
	FATURA_NUMERO,                     
	DIFERENCA_VALOR,                   
	QTDE_TOTAL,                        
	VALOR_TOTAL,                       
	FRETE_A_PAGAR,
	IMPORTACAO_IMPOSTO,                
	IMPORTACAO_ICMS,                   
	IMPORTACAO_IPI,                    
	IMPORTACAO_ALFANDEGA,              
	IMPORTACAO_OUTRAS_DESPESAS,        
	IMPORTACAO_FRETE,                  
	IMPORTACAO_SEGURO,                 
	IMPORTACAO_DESEMBARACO,            
	PORC_DESCONTO,                     
	PORC_ENCARGO,                      
	COMISSAO_VALOR,                    
	COMISSAO_VALOR_GERENTE,            
	VALOR_IMPOSTO_AGREGAR,             
	VALOR_SUB_ITENS,                   
	CAMBIO_NA_DATA,                    
	ESPECIE_SERIE,                     
	NOTA_CANCELADA,                    
	COD_CLIFOR_SACADO,                 
	IMPORTACAO_TX_CAPATAZIA,           
	CHAVE_NFE,
	PROTOCOLO_AUTORIZACAO_NFE,
	DATA_AUTORIZACAO_NFE,
	INFORMACAO_COMPLEMENTAR,
	TRANSPORTADORA_A_PAGAR)                          

	SELECT 
	REPLICATE(0, (7-LEN(RTRIM(A.nNF))))+RTRIM(A.nNF) AS NF_ENTRADA,                  
	C.NOME_CLIFOR,
	convert(date,A.dhEmi,103),
	D.NOME_CLIFOR,
	1,
	1,
	'ENTRADAS_108',
	F.NATUREZA_ENTRADA,
	'000',
	convert(date,A.dhSaiEnt,103),
	0,
	A.serie,
	'ENTRADAS_NF',
	0,
	F.TIPO_ENTRADAS,
	'R$',
	'R$',
	convert(date,GETDATE(),103),
	D.CLIFOR,
	F.RATEIO_CENTRO_CUSTO,
	NULL,
	0,
	C.NOME_CLIFOR,
	1,
	NULL,
	NULL,
	NULL,
	NULL,
	0,
	E.qTrib,
	E.vProd,
	1,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	E.vProd,
	1.000000,
	3,
	0,
	C.CLIFOR,
	0,
	A.chNFe,
	A.nProt,
	(A.dhRecbto-.125),
	A.infAdic,
	G.xNome
	FROM XML_NFE_CAPA A
	JOIN XML_NFE_TOTAL B ON B.chNFe=A.chNFe
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=A.emit_CNPJ
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=A.dest_CNPJ
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN PARAMETROS_IMPORT_XML F ON F.natop=a.natOp 
	LEFT JOIN XML_NFE_TRANSPORTADOR G ON G.chNFe=A.chNFe
	where a.chNFe=@CHAVE_NFE
	AND NOT EXISTS(SELECT * FROM ENTRADAS WHERE CHAVE_NFE=A.CHNFE)

	--- ENTRADAS_ITEM
	INSERT INTO ENTRADAS_ITEM(
	NOME_CLIFOR,                                
	NF_ENTRADA,                                 
	SERIE_NF_ENTRADA,                           
	ITEM_IMPRESSAO,                             
	SUB_ITEM_TAMANHO,                           
	DESCRICAO_ITEM,                             
	QTDE_ITEM,                                  
	PRECO_UNITARIO,                             
	CODIGO_ITEM,                                
	DESCONTO_ITEM,                              
	VALOR_ITEM,                                 
	COD_TABELA_FILHA,                           
	TRIBUT_ICMS,                                
	TRIBUT_ORIGEM,                              
	UNIDADE,                                    
	CLASSIF_FISCAL,                             
	CODIGO_FISCAL_OPERACAO,                     
	PESO,                                       
	CONTA_CONTABIL,                             
	QTDE_RETORNAR_BENEFICIAMENTO,               
	FAIXA,                                      
	COMISSAO_ITEM,                              
	COMISSAO_ITEM_GERENTE,                      
	INDICADOR_CFOP,                             
	QTDE_DEVOLVIDA,                             
	PORCENTAGEM_ITEM_RATEIO,                    
	ID_EXCECAO_IMPOSTO,                         
	REFERENCIA,                                 
	REFERENCIA_ITEM,                            
	REFERENCIA_PEDIDO,                          
	VALOR_ENCARGOS,                             
	VALOR_DESCONTOS,                            
	NAO_SOMA_VALOR,                             
	VALOR_ENCARGOS_IMPORTACAO,                  
	RATEIO_FILIAL,                              
	RATEIO_CENTRO_CUSTO,                        
	VALOR_ENCARGOS_ADUANEIROS,                  
	PORC_ITEM_RATEIO_FRETE,                     
	ITEM_NFE,                                   
	MPADRAO_SEGURO_ITEM,                        
	MPADRAO_FRETE_ITEM,                         
	MPADRAO_ENCARGO_ITEM,                       
	ORIGEM_ITEM,
	PRECO_UNITARIO_ORIGINAL)

	SELECT 
	C.NOME_CLIFOR,
	REPLICATE(0, (7-LEN(RTRIM(B.nNF))))+RTRIM(B.nNF) AS NF_ENTRADA,
	B.SERIE,
	REPLICATE(0, (4-LEN(RTRIM(A.nItem))))+RTRIM(A.nItem) AS  nItem,
	0,
	case when charindex('O.S.:',A.xProd) > 0 then substring(A.XPROD,1,charindex('O.S.:',A.xProd)-1) else A.XPROD end,
	A.QTRIB,
	A.VUNTRIB,
	case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end,
	0,
	A.VPROD,
	'R',
	F.TRIBUT_ICMS,
	ISNULL(F.TRIBUT_ORIGEM,0),
	A.UCOM,
	A.NCM,
	I.CODIGO_FISCAL_OPERACAO,
	0,
	J.CONTA_CONTABIL,
	0,
	'1',
	0,
	0,
	J.INDICADOR_CFOP,
	0,
	((A.QTRIB*A.VUNTRIB)/E.vProd)*100,
	F.ID_EXCECAO_IMPOSTO,
	case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end,
	case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end,
	NULL,
	0,
	0,
	0,
	0,
	D.CLIFOR,
	I.RATEIO_CENTRO_CUSTO,
	0,
	((A.QTRIB*A.VUNTRIB)/E.vProd)*100,
	A.NITEM,
	0,
	0,
	0,
	J.ORIGEM_ITEM,
	A.VUNTRIB
	FROM XML_NFE_ITEM A
	JOIN XML_NFE_CAPA B ON B.chNFe=A.chNFe
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=B.emit_CNPJ
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=B.dest_CNPJ
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN (SELECT A.*,B.COD_CLIFOR_SACADO FROM CTB_EXCECAO_IMPOSTO A JOIN PARAMETROS_IMPORT_XML B ON B.NATUREZA_ENTRADA=A.NATUREZA_ENTRADA WHERE A.INATIVO=0) F ON F.COD_CLIFOR_SACADO=C.CLIFOR
	--LEFT JOIN PRODUTOS G ON G.PRODUTO = case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end
	--LEFT JOIN MATERIAIS H ON H.MATERIAL=A.CPROD
	JOIN PARAMETROS_IMPORT_XML I ON I.natop=B.natOp 
	LEFT JOIN IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM J ON J.REFERENCIA=case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end
	where a.chNFe=@CHAVE_NFE
	AND NOT EXISTS(SELECT * FROM ENTRADAS_ITEM WHERE NF_ENTRADA=B.NNF AND CODIGO_ITEM=A.CPROD)

	--- GERA IMPOSTOS ENTRADA
	EXEC LX_GERA_IMPOSTOS_ENTRADA @NOME_CLIFOR,@NF_ENTRADA,@SERIE_NF_ENTRADA,1,1,1

	--- GERA INTEGRAÇÃO 
	EXEC LX_CTB_Integrar_Entrada @NOME_CLIFOR,@NF_ENTRADA,@SERIE_NF_ENTRADA

END 

