-- PROCEDURE PARA IMPORT DO XML DA NFE -  CRIAR ANTES DE EXECUTAR O PROCESSO DE IMPORTAÇÃO DO XML DA NFE
ALTER PROCEDURE [dbo].[LX_IMPORTA_XML_NFE_ENTRADAS] @MENSAGEM VARCHAR(MAX) 
AS    
SET NOCOUNT ON    
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
	where not exists (select * from XML_NFE_CAPA where chNFe=NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)'))

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
	where not exists (select * from XML_NFE_ITEM where chNFe=NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') and nItem=NFe.value('@nItem', 'int'))
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
	where not exists (select * from XML_NFE_TOTAL where chNFe=NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)')) 
 
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
 	where not exists (select * from XML_NFE_TOTAL where chNFe=NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)')) 

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
 	where not exists (select * from XML_NFE_DUPLICATA where chNFe=NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AND nFat=NFe.value('../fat[1]/nFat[1]','char(10)')) 

	--- verificar os itens em FATURAMENTO_ITEM, pois o Linx retira caracteres especiais do XML
	update a
	set a.cProd=b.CODIGO_ITEM
	from XML_NFE_ITEM a with (nolock)
	join tmp_faturamento_item_dr b with (nolock) on substring(b.codigo_item,1,7) = substring(A.CPROD,1,7)
	join tmp_faturamento_dr c with (nolock) on c.CHAVE_NFE=a.chNFe
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
	JOIN (SELECT distinct CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=A.emit_CNPJ
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=A.dest_CNPJ
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN PARAMETROS_IMPORT_XML F ON F.natop=a.natOp and f.rateio_filial=d.clifor 
	LEFT JOIN XML_NFE_TRANSPORTADOR G ON G.chNFe=A.chNFe
	where a.chNFe=@CHAVE_NFE AND NOT EXISTS(SELECT * FROM ENTRADAS WHERE CHAVE_NFE=A.CHNFE)

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
	case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else substring(A.CPROD,1,12) end,
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
	JOIN (SELECT distinct CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=B.emit_CNPJ
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=B.dest_CNPJ
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN (SELECT DISTINCT A.*,B.COD_CLIFOR_SACADO FROM CTB_EXCECAO_IMPOSTO A JOIN PARAMETROS_IMPORT_XML B ON B.NATUREZA_ENTRADA=A.NATUREZA_ENTRADA WHERE A.INATIVO=0) F ON F.COD_CLIFOR_SACADO=C.CLIFOR
	JOIN PARAMETROS_IMPORT_XML I ON I.natop=B.natOp and I.rateio_filial=d.clifor 
	LEFT JOIN IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM J ON J.REFERENCIA=case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end
	where a.chNFe= @CHAVE_NFE AND NOT EXISTS(SELECT * FROM ENTRADAS_ITEM WHERE NOME_CLIFOR=C.NOME_CLIFOR AND NF_ENTRADA=REPLICATE(0, (7-LEN(RTRIM(B.nNF))))+RTRIM(B.nNF) AND SERIE_NF_ENTRADA=B.SERIE AND ITEM_IMPRESSAO=REPLICATE(0, (4-LEN(RTRIM(A.nItem))))+RTRIM(A.nItem))

	--- GERA IMPOSTOS ENTRADA
	EXEC LX_GERA_IMPOSTOS_ENTRADA @NOME_CLIFOR,@NF_ENTRADA,@SERIE_NF_ENTRADA,1,1,1

	--- GERA INTEGRAÇÃO 
	EXEC LX_CTB_Integrar_Entrada @NOME_CLIFOR,@NF_ENTRADA,@SERIE_NF_ENTRADA

END 
GO


-- PROCEDURE PARA CADASTROS AUXILIARES
alter PROCEDURE [dbo].[SP_INCLUI_CADASTROS_AUXILIARES_OFICINAS]
AS 
------*****************************************************************************************************------
--- IMPORTAÇÃO DE PRODUTOS, MATERIAIS E ITEM FISCAL
begin
	DECLARE @ERRMSG VARCHAR(500)
	set ANSI_WARNINGS off
	SET NOCOUNT ON;  

	-- CTB_LX_INDICADOR_CFOP
	begin
		INSERT INTO [dbo].[CTB_LX_INDICADOR_CFOP]
				   ([INDICADOR_CFOP]
				   ,[DESCRICAO_INDICADOR_CFOP]
				   ,[INATIVO]
				   ,[DATA_PARA_TRANSFERENCIA])
		SELECT      [INDICADOR_CFOP]
				   ,[DESCRICAO_INDICADOR_CFOP]
				   ,[INATIVO]
				   ,[DATA_PARA_TRANSFERENCIA]
		FROM DRLINGERIE.[dbo].[CTB_LX_INDICADOR_CFOP] A
		WHERE NOT EXISTS(SELECT * FROM CTB_LX_INDICADOR_CFOP WHERE INDICADOR_CFOP=A.INDICADOR_CFOP)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_GRIFFES
    begin
		INSERT INTO [dbo].[PRODUTOS_GRIFFES]
			   ([GRIFFE]
			   ,[LICENCIADO]
			   ,[ROYALTIES]
			   ,[LICENCIADOR]
			   ,[Data_para_transferencia]
			   ,[COD_GRIFFE]
			   ,[INATIVO]
			   ,[RECEBIMENTO]
			   ,[VALOR_MINIMO_PEDIDO]
			   ,[RATEIO_CENTRO_CUSTO]
			   ,[RATEIO_FILIAL])
		 SELECT [GRIFFE]
			   ,[LICENCIADO]
			   ,[ROYALTIES]
			   ,[LICENCIADOR]
			   ,[Data_para_transferencia]
			   ,'DR'
			   ,[INATIVO]
			   ,[RECEBIMENTO]
			   ,[VALOR_MINIMO_PEDIDO]
			   ,[RATEIO_CENTRO_CUSTO]
			   ,[RATEIO_FILIAL]
		FROM DRLINGERIE.DBO.PRODUTOS_GRIFFES A
		WHERE A.GRIFFE='DR. LINGERIE' AND NOT EXISTS(SELECT * FROM PRODUTOS_GRIFFES WHERE GRIFFE=A.GRIFFE)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_SEGMENTO
    begin
		INSERT INTO [dbo].[PRODUTOS_SEGMENTO]
				   ([COD_PRODUTO_SEGMENTO]
				   ,[DESC_PRODUTO_SEGMENTO]
				   ,[CBD_COD_SOLUCAO]
				   ,[CBD_COD_SOBRENOME]
				   ,[CBD_DESC_SOBRENOME]
				   ,[INATIVO])
		SELECT [COD_PRODUTO_SEGMENTO]
				   ,[DESC_PRODUTO_SEGMENTO]
				   ,[CBD_COD_SOLUCAO]
				   ,[CBD_COD_SOBRENOME]
				   ,[CBD_DESC_SOBRENOME]
				   ,[INATIVO]
		FROM DRLINGERIE.DBO.PRODUTOS_SEGMENTO A
		WHERE NOT EXISTS(SELECT * FROM PRODUTOS_SEGMENTO WHERE COD_PRODUTO_SEGMENTO=A.COD_PRODUTO_SEGMENTO)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_PERIODOS_PCP
	begin
		INSERT INTO [dbo].[PRODUTOS_PERIODOS_PCP]
				   ([PERIODO_PCP]
				   ,[TIPO_PERIODO]
				   ,[Data_para_transferencia]
				   ,[OBS])
		SELECT      [PERIODO_PCP]
				   ,[TIPO_PERIODO]
				   ,[Data_para_transferencia]
				   ,[OBS]
		FROM DRLINGERIE.DBO.PRODUTOS_PERIODOS_PCP A
		WHERE NOT EXISTS(SELECT * FROM PRODUTOS_PERIODOS_PCP WHERE PERIODO_PCP=A.PERIODO_PCP) AND PERIODO_PCP='INDEFINIDO'
		IF @@ERROR > 0	GOTO ERROR	   
    end

	-- PRODUTIV_TOLERANCIAS
	begin
		INSERT INTO [dbo].[PRODUTIV_TOLERANCIAS]
				   ([TOLERANCIA]
				   ,[INDICE_TOLERANCIA])
		SELECT      [TOLERANCIA]
				   ,[INDICE_TOLERANCIA]
		FROM DRLINGERIE.DBO.[PRODUTIV_TOLERANCIAS] A
		WHERE NOT EXISTS(SELECT * FROM PRODUTIV_TOLERANCIAS WHERE TOLERANCIA=A.TOLERANCIA)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_GRUPO
	begin
		INSERT INTO [dbo].[PRODUTOS_GRUPO]
				   ([GRUPO_PRODUTO]
				   ,[CODIGO_GRUPO]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[VARIA_TEMPO_TAMANHO]
				   ,[FECHA_CM_AJUSTE_INFLACAO]
				   ,[INATIVO])
		SELECT      [GRUPO_PRODUTO]
				   ,[CODIGO_GRUPO]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[VARIA_TEMPO_TAMANHO]
				   ,[FECHA_CM_AJUSTE_INFLACAO]
				   ,[INATIVO]
		FROM DRLINGERIE.DBO.PRODUTOS_GRUPO A
		WHERE NOT EXISTS(SELECT * FROM PRODUTOS_GRUPO WHERE GRUPO_PRODUTO=A.GRUPO_PRODUTO)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	----- EXCLUIR INDICE UNICO E ALTERAR O CODIGO DO GRUPO DEPOIS DE IMPORTAR OS DADOS
	--SELECT * FROM PRODUTOS_GRUPO
	--ORDER BY CODIGO_GRUPO

	-- GERAR CODIGO HEXDECIMAL PARA PRODUTOS_GRUPO
	--UPDATE A
	--SET A.CODIGO_GRUPO=B.COD
	--FROM PRODUTOS_GRUPO  A
	--JOIN (SELECT COD=SUBSTRING(DBO.fn_IntToStrHex(CAST('1' AS INT)+ ROW_NUMBER() OVER(ORDER BY CODIGO_GRUPO)),3,2),* FROM PRODUTOS_GRUPO ) B ON B.CODIGO_GRUPO=A.CODIGO_GRUPO AND B.GRUPO_PRODUTO=A.GRUPO_PRODUTO

	-- PRODUTOS_SUBGRUPO
	begin
		INSERT INTO [dbo].[PRODUTOS_SUBGRUPO]
				   ([GRUPO_PRODUTO]
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
				   ,[INATIVO])
		SELECT      [GRUPO_PRODUTO]
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
		FROM DRLINGERIE.DBO.PRODUTOS_SUBGRUPO A 
		WHERE NOT EXISTS(SELECT * FROM PRODUTOS_SUBGRUPO WHERE GRUPO_PRODUTO=A.GRUPO_PRODUTO AND SUBGRUPO_PRODUTO=A.SUBGRUPO_PRODUTO)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	--SELECT * FROM PRODUTOS_SUBGRUPO
	--ORDER BY CODIGO_SUBGRUPO

	--SELECT CODIGO_SUBGRUPO,GRUPO_PRODUTO,COUNT(*)
	--FROM PRODUTOS_SUBGRUPO
	--GROUP BY CODIGO_SUBGRUPO,GRUPO_PRODUTO
	--HAVING COUNT(*)>1
	--ORDER BY CODIGO_SUBGRUPO,GRUPO_PRODUTO

	--- GERAR CODIGO HEXDECIMAL PARA CODIGO SUBGRUPO PRODUTO
	--UPDATE A
	--SET A.CODIGO_SUBGRUPO=B.COD
	--FROM PRODUTOS_SUBGRUPO A
	--JOIN (SELECT COD=SUBSTRING(DBO.fn_IntToStrHex(CAST('14' AS INT)+ ROW_NUMBER() OVER(ORDER BY CODIGO_SUBGRUPO)),3,2),* FROM PRODUTOS_SUBGRUPO) B ON B.GRUPO_PRODUTO=A.GRUPO_PRODUTO AND B.SUBGRUPO_PRODUTO=A.SUBGRUPO_PRODUTO AND B.CODIGO_SUBGRUPO=A.CODIGO_SUBGRUPO 
 --   WHERE A.CODIGO_SUBGRUPO IN('10')

	-- PRODUTIV_LINHA_INDUSTRIAL
	begin
		INSERT INTO [dbo].[PRODUTIV_LINHA_INDUSTRIAL]
				   ([LINHA_INDUSTRIAL]
				   ,[CAPACIDADE])
		SELECT      [LINHA_INDUSTRIAL]
				   ,[CAPACIDADE]
		FROM DRLINGERIE.DBO.PRODUTIV_LINHA_INDUSTRIAL A
		WHERE NOT EXISTS(SELECT * FROM PRODUTIV_LINHA_INDUSTRIAL WHERE LINHA_INDUSTRIAL=A.LINHA_INDUSTRIAL)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_TAB_OPERACOES
	begin
		INSERT INTO [dbo].[PRODUTOS_TAB_OPERACOES]
				   ([TABELA_OPERACOES]
				   ,[TOLERANCIA]
				   ,[GRUPO_PRODUTO]
				   ,[LINHA_INDUSTRIAL]
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
				   ,[ROTA_CONSERTO])
		SELECT      [TABELA_OPERACOES]
				   ,[TOLERANCIA]
				   ,[GRUPO_PRODUTO]
				   ,[LINHA_INDUSTRIAL]
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
		FROM DRLINGERIE.DBO.[PRODUTOS_TAB_OPERACOES] A
		WHERE NOT EXISTS(SELECT * FROM PRODUTOS_TAB_OPERACOES WHERE TABELA_OPERACOES=A.TABELA_OPERACOES)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- MATERIAIS_TIPO_LAVAGEM
	begin
		INSERT INTO [dbo].[MATERIAIS_TIPO_LAVAGEM]
				   ([RESTRICAO_LAVAGEM]
				   ,[DESC_RESTRICAO_LAVAGEM]
				   ,[PASSADORIA_TEMPERATURA]
				   ,[LAVAGEM_TEMPERATURA]
				   ,[LAVAGEM_COM_CLORADOS]
				   ,[LAVAR_A_SECO]
				   ,[SECAR_SECADORA]
				   ,[OBS]
				   ,[DATA_PARA_TRANSFERENCIA])
		SELECT      [RESTRICAO_LAVAGEM]
				   ,[DESC_RESTRICAO_LAVAGEM]
				   ,[PASSADORIA_TEMPERATURA]
				   ,[LAVAGEM_TEMPERATURA]
				   ,[LAVAGEM_COM_CLORADOS]
				   ,[LAVAR_A_SECO]
				   ,[SECAR_SECADORA]
				   ,[OBS]
				   ,[DATA_PARA_TRANSFERENCIA]
		FROM DRLINGERIE.DBO.[MATERIAIS_TIPO_LAVAGEM] A
		WHERE NOT EXISTS(SELECT * FROM MATERIAIS_TIPO_LAVAGEM WHERE RESTRICAO_LAVAGEM=A.RESTRICAO_LAVAGEM )
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_SOLUCAO
	begin
		INSERT INTO [dbo].[PRODUTOS_SOLUCAO]
				   ([COD_PRODUTO_SOLUCAO]
				   ,[DESC_PRODUTO_SOLUCAO]
				   ,[INATIVO])
		SELECT      [COD_PRODUTO_SOLUCAO]
				   ,[DESC_PRODUTO_SOLUCAO]
				   ,[INATIVO]
		FROM DRLINGERIE.DBO.[PRODUTOS_SOLUCAO] A
		WHERE NOT EXISTS(SELECT * FROM PRODUTOS_SOLUCAO WHERE COD_PRODUTO_SOLUCAO=A.COD_PRODUTO_SOLUCAO)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_TAMANHOS
	begin
		INSERT INTO [dbo].[PRODUTOS_TAMANHOS]
				   ([GRADE]
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
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[GRADE_BASE]
				   ,[TAMANHOS_DIGITADOS]
				   ,[GRADE_CODIGO]
				   ,[LX_STATUS_REGISTRO])
		SELECT      [GRADE]
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
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[GRADE_BASE]
				   ,[TAMANHOS_DIGITADOS]
				   ,[GRADE_CODIGO]
				   ,[LX_STATUS_REGISTRO]
		FROM DRLINGERIE.DBO.PRODUTOS_TAMANHOS A
		WHERE NOT EXISTS(SELECT * FROM PRODUTOS_TAMANHOS WHERE GRADE=A.GRADE)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_TAB_MEDIDAS 
	begin
		INSERT INTO [dbo].[PRODUTOS_TAB_MEDIDAS]
				   ([TABELA_MEDIDAS]
				   ,[GRUPO_PRODUTO]
				   ,[GRADE]
				   ,[TAMANHO_BASE]
				   ,[DESCRICAO_TABELA]
				   ,[FOTO_DIANTEIRO]
				   ,[FOTO_TRASEIRO]
				   ,[OBS]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[SUBGRUPO_PRODUTO])
		SELECT      [TABELA_MEDIDAS]
				   ,[GRUPO_PRODUTO]
				   ,[GRADE]
				   ,[TAMANHO_BASE]
				   ,[DESCRICAO_TABELA]
				   ,[FOTO_DIANTEIRO]
				   ,[FOTO_TRASEIRO]
				   ,[OBS]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[SUBGRUPO_PRODUTO]
		FROM DRLINGERIE.[dbo].[PRODUTOS_TAB_MEDIDAS] A
		WHERE NOT EXISTS(SELECT * FROM [PRODUTOS_TAB_MEDIDAS] WHERE TABELA_MEDIDAS=A.TABELA_MEDIDAS)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- TABELA_OPERACOES
	begin
		INSERT INTO [dbo].[PRODUTOS_TAB_OPERACOES]
				   ([TABELA_OPERACOES]
				   ,[TOLERANCIA]
				   ,[GRUPO_PRODUTO]
				   ,[LINHA_INDUSTRIAL]
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
				   ,[ROTA_CONSERTO])
		SELECT      [TABELA_OPERACOES]
				   ,[TOLERANCIA]
				   ,[GRUPO_PRODUTO]
				   ,[LINHA_INDUSTRIAL]
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
		FROM DRLINGERIE.dbo.[PRODUTOS_TAB_OPERACOES] A
		WHERE NOT EXISTS(SELECT * FROM PRODUTOS_TAB_OPERACOES WHERE TABELA_OPERACOES=A.TABELA_OPERACOES)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_STATUS
	begin
		INSERT INTO [dbo].[PRODUTOS_STATUS]
				   ([STATUS_PRODUTO]
				   ,[DESC_STATUS_PRODUTO]
				   ,[TIPO_STATUS_PRODUTO]
				   ,[DATA_PARA_TRANSFERENCIA])
		SELECT      [STATUS_PRODUTO]
				   ,[DESC_STATUS_PRODUTO]
				   ,[TIPO_STATUS_PRODUTO]
				   ,[DATA_PARA_TRANSFERENCIA]
		FROM DRLINGERIE.DBO.[PRODUTOS_STATUS] A
		WHERE NOT EXISTS(SELECT * FROM PRODUTOS_STATUS WHERE STATUS_PRODUTO=A.STATUS_PRODUTO)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- cest_ncm
	begin
		INSERT INTO [dbo].[CEST_NCM]
				   ([ID]
				   ,[ID_CEST]
				   ,[ID_NCM]
				   ,[DATA_PARA_TRANSFERENCIA])
		select      [ID]
				   ,[ID_CEST]
				   ,[ID_NCM]
				   ,[DATA_PARA_TRANSFERENCIA]
		from drlingerie.dbo.CEST_NCM a
		where not exists(select * from CEST_NCM where id=a.ID)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- CORES BASICAS
	begin
		INSERT INTO [dbo].[CORES_BASICAS]
				   ([COR]
				   ,[DESC_COR]
				   ,[USO_PRODUTOS]
				   ,[USO_MATERIAIS]
				   ,[GRUPO_CORES]
				   ,[COR_SORTIDA]
				   ,[COR_RGB]
				   ,[DATA_PARA_TRANSFERENCIA])
		SELECT      [COR]
				   ,[DESC_COR]
				   ,[USO_PRODUTOS]
				   ,[USO_MATERIAIS]
				   ,[GRUPO_CORES]
				   ,[COR_SORTIDA]
				   ,[COR_RGB]
				   ,[DATA_PARA_TRANSFERENCIA]
		FROM DRLINGERIE.[dbo].[CORES_BASICAS] A
		WHERE NOT EXISTS(SELECT * FROM CORES_BASICAS WHERE COR=A.COR)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	--- CLASSIF_FISCAL
	begin
		INSERT INTO [dbo].[CLASSIF_FISCAL]
				   ([CLASSIF_FISCAL]
				   ,[IPI]
				   ,[DESC_CLASSIFICACAO]
				   ,[CLASSIF_REDUZIDA]
				   ,[ABATER_ICMS_NO_MEDIO]
				   ,[ABATER_IPI_NO_MEDIO]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[ABATER_PIS_NO_MEDIO]
				   ,[ABATER_COFINS_NO_MEDIO]
				   ,[RETE_FUENTE]
				   ,[RETE_IVA]
				   ,[RETE_ICA]
				   ,[CODIGO_SERVICO]
				   ,[COD_GENERO_SPED]
				   ,[CODIGO_CONTRIBUICAO_RECEITA_BRUTA]
				   ,[ID_SERVICO_TIPO]
				   ,[INATIVO]
				   ,[LX_STATUS_REGISTRO])
		SELECT      [CLASSIF_FISCAL]
				   ,[IPI]
				   ,[DESC_CLASSIFICACAO]
				   ,[CLASSIF_REDUZIDA]
				   ,[ABATER_ICMS_NO_MEDIO]
				   ,[ABATER_IPI_NO_MEDIO]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[ABATER_PIS_NO_MEDIO]
				   ,[ABATER_COFINS_NO_MEDIO]
				   ,[RETE_FUENTE]
				   ,[RETE_IVA]
				   ,[RETE_ICA]
				   ,[CODIGO_SERVICO]
				   ,[COD_GENERO_SPED]
				   ,[CODIGO_CONTRIBUICAO_RECEITA_BRUTA]
				   ,[ID_SERVICO_TIPO]
				   ,[INATIVO]
				   ,[LX_STATUS_REGISTRO]
		FROM DRLINGERIE.[dbo].[CLASSIF_FISCAL] A
		WHERE NOT EXISTS(SELECT * FROM CLASSIF_FISCAL WHERE CLASSIF_FISCAL=A.CLASSIF_FISCAL)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- CTB_CONTA_TIPO
	begin
		INSERT INTO [dbo].[CTB_CONTA_TIPO]
				   ([TIPO_CONTA]
				   ,[DESC_CONTA_TIPO]
				   ,[CONTA_OBRIGATORIA]
				   ,[INDICA_ID_CONTABIL_TERCEIRO])
		SELECT      [TIPO_CONTA]
				   ,[DESC_CONTA_TIPO]
				   ,[CONTA_OBRIGATORIA]
				   ,[INDICA_ID_CONTABIL_TERCEIRO]
		FROM DRLINGERIE.[dbo].[CTB_CONTA_TIPO] A
		WHERE NOT EXISTS(SELECT * FROM CTB_CONTA_TIPO WHERE TIPO_CONTA=A.TIPO_CONTA)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- CTB_CENTRO_CUSTO_RATEIO
	begin
		INSERT INTO [dbo].[CTB_CENTRO_CUSTO_RATEIO]
				   ([RATEIO_CENTRO_CUSTO]
				   ,[INATIVO]
				   ,[RATEIO_ENTRAR_EM_LISTA]
				   ,[DESC_RATEIO_CENTRO_CUSTO]
				   ,[COD_MATRIZ_CONTABIL])
		select      [RATEIO_CENTRO_CUSTO]
				   ,[INATIVO]
				   ,[RATEIO_ENTRAR_EM_LISTA]
				   ,[DESC_RATEIO_CENTRO_CUSTO]
				   ,[COD_MATRIZ_CONTABIL]
		from drlingerie.dbo.[CTB_CENTRO_CUSTO_RATEIO] a
		where not exists(select * from CTB_CENTRO_CUSTO_RATEIO where RATEIO_CENTRO_CUSTO=a.RATEIO_CENTRO_CUSTO)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- CTB_CONTA_PLANO
	begin
		ALTER TABLE [dbo].[CTB_CONTA_PLANO] DISABLE TRIGGER [LXI_CTB_CONTA_PLANO]
		INSERT INTO [dbo].[CTB_CONTA_PLANO]
				   ([CONTA_CONTABIL]
				   ,[RATEIO_CENTRO_CUSTO]
				   ,[CODIGO_HISTORICO]
				   ,[LX_GRUPO_FLUXO]
				   ,[DESC_CONTA]
				   ,[TIPO_CONTA]
				   ,[INATIVA]
				   ,[CODIGO_RESUMIDO]
				   ,[CONTA_CORRENTE]
				   ,[ULTIMO_CHEQUE]
				   ,[EXPORTACAO_CONTA_CONTABIL]
				   ,[EXPORTACAO_TIPO]
				   ,[CONTA_PORTADORA]
				   ,[DESC_CONTA_REDUZIDA]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[ID_CARTEIRA_COBRANCA]
				   ,[DESC_DETALHADA]
				   ,[BANCO]
				   ,[AGENCIA]
				   ,[NUMERO_CONTA_CORRENTE]
				   ,[COD_CLIFOR]
				   ,[MOEDA]
				   ,[LX_GRUPO_CONTABIL]
				   ,[LANCAMENTO_PADRAO]
				   ,[LANCAMENTO_PADRAO_DEFLACAO]
				   ,[LIMITE_CONTA_CORRENTE]
				   ,[SALDO_BLOQ_CONTA_CORRENTE]
				   ,[PREVISAO_DESPESA]
				   ,[ID_IMPOSTO]
				   ,[COD_FILIAL]
				   ,[INDICA_CONSOLIDACAO]
				   ,[INDICA_CTRL_ORCAMENTO]
				   ,[CONVENIO])
		SELECT      [CONTA_CONTABIL]
				   ,[RATEIO_CENTRO_CUSTO]
				   ,[CODIGO_HISTORICO]
				   ,[LX_GRUPO_FLUXO]
				   ,[DESC_CONTA]
				   ,[TIPO_CONTA]
				   ,[INATIVA]
				   ,[CODIGO_RESUMIDO]
				   ,[CONTA_CORRENTE]
				   ,[ULTIMO_CHEQUE]
				   ,[EXPORTACAO_CONTA_CONTABIL]
				   ,[EXPORTACAO_TIPO]
				   ,[CONTA_PORTADORA]
				   ,[DESC_CONTA_REDUZIDA]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[ID_CARTEIRA_COBRANCA]
				   ,[DESC_DETALHADA]
				   ,[BANCO]
				   ,[AGENCIA]
				   ,[NUMERO_CONTA_CORRENTE]
				   ,[COD_CLIFOR]
				   ,[MOEDA]
				   ,[LX_GRUPO_CONTABIL]
				   ,[LANCAMENTO_PADRAO]
				   ,[LANCAMENTO_PADRAO_DEFLACAO]
				   ,[LIMITE_CONTA_CORRENTE]
				   ,[SALDO_BLOQ_CONTA_CORRENTE]
				   ,[PREVISAO_DESPESA]
				   ,[ID_IMPOSTO]
				   ,[COD_FILIAL]
				   ,[INDICA_CONSOLIDACAO]
				   ,[INDICA_CTRL_ORCAMENTO]
				   ,[CONVENIO]
		FROM DRLINGERIE.DBO.CTB_CONTA_PLANO A
		WHERE NOT EXISTS(SELECT * FROM CTB_CONTA_PLANO WHERE CONTA_CONTABIL=A.CONTA_CONTABIL) --and not exists(select * from CTB_VISAO where CLASSIFICACAO=a.CONTA_CONTABIL)
		ALTER TABLE [dbo].[CTB_CONTA_PLANO] ENABLE TRIGGER [LXI_CTB_CONTA_PLANO]
		IF @@ERROR > 0	GOTO ERROR	   
	end


	-- COLECAO
	begin
		INSERT INTO [dbo].[COLECOES]
				   ([COLECAO]
				   ,[DESC_COLECAO]
				   ,[ENVIA_LOJA_VAREJO]
				   ,[ENVIA_LOJA_ATACADO]
				   ,[ENVIA_REPRESENTANTE]
				   ,[ENVIA_VAREJO_INTERNET]
				   ,[ENVIA_ATACADO_INTERNET]
				   ,[INATIVO]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[INIBE_DESCONTO_CLIENTE]
				   ,[DATA_INICIO_META]
				   ,[DATA_FINAL_META]
				   ,[TEMPORADA])
		SELECT      [COLECAO]
				   ,[DESC_COLECAO]
				   ,[ENVIA_LOJA_VAREJO]
				   ,[ENVIA_LOJA_ATACADO]
				   ,[ENVIA_REPRESENTANTE]
				   ,[ENVIA_VAREJO_INTERNET]
				   ,[ENVIA_ATACADO_INTERNET]
				   ,[INATIVO]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[INIBE_DESCONTO_CLIENTE]
				   ,[DATA_INICIO_META]
				   ,[DATA_FINAL_META]
				   ,[TEMPORADA]
		FROM DRLINGERIE.DBO.[COLECOES] A
		WHERE NOT EXISTS(SELECT * FROM COLECOES WHERE COLECAO=A.COLECAO)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- produto acabado
	begin
		INSERT INTO [dbo].[PRODUTOS]
				   ([PRODUTO]
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
				   ,[TIPO_ITEM_SPED]
				   ,[ID_PRECO]
				   ,[PERC_COMISSAO]
				   ,[ACEITA_ENCOMENDA]
				   ,[DIAS_GARANTIA_LOJA]
				   ,[DIAS_GARANTIA_FABRICANTE]
				   ,[POSSUI_MONTAGEM]
				   ,[NATUREZA_RECEITA]
				   ,[POSSUI_GTIN]
				   ,[PERMITE_ENTREGA_FUTURA]
				   ,[COD_ALIQUOTA_PIS_COFINS_DIF]
				   ,[DATA_LIMITE_PEDIDO]
				   ,[LX_STATUS_REGISTRO]
				   ,[ARREDONDA]
				   ,[ID_ARTIGO]
				   ,[LX_HASH]
				   ,[SPED_DATA_FIM]
				   ,[SPED_DATA_INI]
				   ,[TIPO_PP]
				   ,[ID_CEST_NCM])
		select      [PRODUTO]
				   ,[CODIGO_PRECO]
				   ,NULL
				   ,NULL
				   ,[TABELA_OPERACOES]
				   ,[FATOR_OPERACOES]
				   ,[CLASSIF_FISCAL]
				   ,'INDEFINIDO'
				   ,[TABELA_MEDIDAS]
				   ,[DESC_PRODUTO]
				   ,[GRUPO_PRODUTO]
				   ,[SUBGRUPO_PRODUTO]
				   ,'000001'
				   ,[GRADE]
				   ,[DESC_PROD_NF]
				   ,'INDEFINIDA'
				   ,'DR. LINGERIE'
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
				   ,NULL
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
				   ,[TIPO_ITEM_SPED]
				   ,[ID_PRECO]
				   ,[PERC_COMISSAO]
				   ,[ACEITA_ENCOMENDA]
				   ,[DIAS_GARANTIA_LOJA]
				   ,[DIAS_GARANTIA_FABRICANTE]
				   ,[POSSUI_MONTAGEM]
				   ,[NATUREZA_RECEITA]
				   ,[POSSUI_GTIN]
				   ,[PERMITE_ENTREGA_FUTURA]
				   ,[COD_ALIQUOTA_PIS_COFINS_DIF]
				   ,[DATA_LIMITE_PEDIDO]
				   ,[LX_STATUS_REGISTRO]
				   ,[ARREDONDA]
				   ,[ID_ARTIGO]
				   ,[LX_HASH]
				   ,[SPED_DATA_FIM]
				   ,[SPED_DATA_INI]
				   ,[TIPO_PP]
				   ,[ID_CEST_NCM]
		FROM DRLINGERIE.DBO.PRODUTOS P
		where not exists (select produto from PRODUTOS where PRODUTO=P.PRODUTO) 
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- PRODUTOS_CORES
	begin
		INSERT INTO [dbo].[PRODUTO_CORES]
				   ([PRODUTO]
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
				   ,[LX_HASH])
		SELECT      [PRODUTO]
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
				   ,[COMPOSICAO]
				   ,[CLASSIF_FISCAL]
				   ,[TRIBUT_ORIGEM]
				   ,[LX_STATUS_REGISTRO]
				   ,[LX_HASH]
		FROM DRLINGERIE.[dbo].[PRODUTO_CORES] A
		WHERE not EXISTS(SELECT * FROM PRODUTO_CORES WHERE PRODUTO=A.PRODUTO) and exists(select * from produtos where produto=a.produto)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- MATERIAIS_GRUPO
	begin
		INSERT INTO [dbo].[MATERIAIS_GRUPO]
				   ([GRUPO]
				   ,[CODIGO_GRUPO]
				   ,[CLASSE]
				   ,[FECHA_CM_AJUSTE_INFLACAO]
				   ,[INATIVO])
		SELECT      [GRUPO]
				   ,[CODIGO_GRUPO]
				   ,[CLASSE]
				   ,[FECHA_CM_AJUSTE_INFLACAO]
				   ,[INATIVO]
		FROM DRLINGERIE.[dbo].[MATERIAIS_GRUPO] A
		WHERE NOT EXISTS(SELECT * FROM MATERIAIS_GRUPO WHERE GRUPO=A.GRUPO)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	--SELECT * FROM MATERIAIS_GRUPO
	--ORDER BY CODIGO_GRUPO

	---- GERAR CODIGO HEXDECIMAL PARA CODIGO SUBGRUPO PRODUTO
	--UPDATE A
	--SET A.CODIGO_GRUPO=B.COD
	--FROM MATERIAIS_GRUPO A
	--JOIN (SELECT COD=SUBSTRING(DBO.fn_IntToStrHex(CAST('1' AS INT)+ ROW_NUMBER() OVER(ORDER BY CODIGO_GRUPO)),3,2),* 
	--FROM MATERIAIS_GRUPO) B ON B.GRUPO=A.GRUPO

	-- MATERIAIS_SUBGRUPO
	begin
		INSERT INTO [dbo].[MATERIAIS_SUBGRUPO]
				   ([SUBGRUPO]
				   ,[GRUPO]
				   ,[FASE_PRODUCAO]
				   ,[SETOR_PRODUCAO]
				   ,[CODIGO_SUBGRUPO]
				   ,[CODIGO_SEQUENCIAL]
				   ,[UNIDADE_ESTOQUE]
				   ,[FATOR_CONVERSAO]
				   ,[UNIDADE_FICHA_TEC]
				   ,[UNIDADE_AUXILIAR]
				   ,[CTRL_UNID_AUX]
				   ,[CTRL_PARTIDAS]
				   ,[CTRL_PECAS]
				   ,[CTRL_PECAS_PARCIAL]
				   ,[VARIA_MATERIAL_TAMANHO]
				   ,[MATERIAL_INDIRETO]
				   ,[RESERVA_MATERIAL_OP]
				   ,[ABATER_RESERVA_QTDE]
				   ,[IGNORAR_EM_FORMACAO_PRECO]
				   ,[IMPRESSAO_ETIQUETA_PRODUCAO]
				   ,[INDICA_CORTE]
				   ,[CTRL_DETALHES_TECIDO]
				   ,[CTRL_DETALHES_FIO]
				   ,[MRP_PARTICIPANTE]
				   ,[MRP_AGRUPAR_NECESSIDADE_TIPO]
				   ,[MRP_AGRUPAR_NECESSIDADE_DIAS]
				   ,[MRP_MAIOR_GIRO_MP_DIAS]
				   ,[MRP_EMISSAO_LIBERACAO_DIAS]
				   ,[MRP_ENTREGA_GIRO_DIAS]
				   ,[MRP_DIAS_SEGURANCA]
				   ,[INATIVO])
		SELECT      [SUBGRUPO]
				   ,[GRUPO]
				   ,'001'
				   ,'PCP'
				   ,[CODIGO_SUBGRUPO]
				   ,[CODIGO_SEQUENCIAL]
				   ,[UNIDADE_ESTOQUE]
				   ,[FATOR_CONVERSAO]
				   ,[UNIDADE_FICHA_TEC]
				   ,[UNIDADE_AUXILIAR]
				   ,[CTRL_UNID_AUX]
				   ,[CTRL_PARTIDAS]
				   ,[CTRL_PECAS]
				   ,[CTRL_PECAS_PARCIAL]
				   ,[VARIA_MATERIAL_TAMANHO]
				   ,[MATERIAL_INDIRETO]
				   ,[RESERVA_MATERIAL_OP]
				   ,[ABATER_RESERVA_QTDE]
				   ,[IGNORAR_EM_FORMACAO_PRECO]
				   ,[IMPRESSAO_ETIQUETA_PRODUCAO]
				   ,[INDICA_CORTE]
				   ,[CTRL_DETALHES_TECIDO]
				   ,[CTRL_DETALHES_FIO]
				   ,[MRP_PARTICIPANTE]
				   ,[MRP_AGRUPAR_NECESSIDADE_TIPO]
				   ,[MRP_AGRUPAR_NECESSIDADE_DIAS]
				   ,[MRP_MAIOR_GIRO_MP_DIAS]
				   ,[MRP_EMISSAO_LIBERACAO_DIAS]
				   ,[MRP_ENTREGA_GIRO_DIAS]
				   ,[MRP_DIAS_SEGURANCA]
				   ,[INATIVO]
		FROM DRLINGERIE.[dbo].[MATERIAIS_SUBGRUPO] A
		WHERE NOT EXISTS(SELECT * FROM MATERIAIS_SUBGRUPO WHERE GRUPO=A.GRUPO AND SUBGRUPO=A.SUBGRUPO)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- MATERIAIS
	begin
		INSERT INTO [dbo].[MATERIAIS]
				   ([MATERIAL]
				   ,[SETOR_PRODUCAO]
				   ,[FASE_PRODUCAO]
				   ,[TIPO]
				   ,[TRIBUT_ICMS]
				   ,[TRIBUT_ORIGEM]
				   ,[CLASSIF_FISCAL]
				   ,[FABRICANTE]
				   ,[GRUPO]
				   ,[COLECAO]
				   ,[SUBGRUPO]
				   ,[DESC_MATERIAL]
				   ,[FATOR_CONVERSAO]
				   ,[UNID_ESTOQUE]
				   ,[DIAS_ENTREGA]
				   ,[UNID_FICHA_TEC]
				   ,[CONDICAO_PGTO]
				   ,[UNID_AUXILIAR]
				   ,[CTRL_UNID_AUX]
				   ,[REVENDA]
				   ,[COMPRIMENTO]
				   ,[COD_MATERIAL_TAMANHO]
				   ,[VARIA_MATERIAL_TAMANHO]
				   ,[CTRL_PARTIDAS]
				   ,[LARGURA]
				   ,[VARIA_CUSTO_COR]
				   ,[CTRL_PECAS]
				   ,[VARIA_PRECO_COR]
				   ,[CTRL_PECAS_PARCIAL]
				   ,[DATA_REPOSICAO]
				   ,[CUSTO_REPOSICAO]
				   ,[REF_FABRICANTE]
				   ,[ICMS_CUSTOS]
				   ,[CUSTO_A_VISTA]
				   ,[TAXA_JUROS_CUSTO]
				   ,[MATERIAL_INDIRETO]
				   ,[RESERVA_MATERIAL_OP]
				   ,[ABATER_RESERVA_QTDE]
				   ,[OBS]
				   ,[DESC_NF]
				   ,[CODIGO_ETIQUETA_GRIFFE]
				   ,[CONTA_CONTABIL]
				   ,[INATIVO]
				   ,[SEMI_ACABADO]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[COMPRA_MINIMA]
				   ,[LOTE_ECONOMICO_COMPRAS]
				   ,[TEC_SIMPLES_TUBULAR_ABERTO]
				   ,[TEC_LISO_ESTAMPA_LISTRA_XADREX]
				   ,[TEC_TORNASOL]
				   ,[DATA_CADASTRAMENTO]
				   ,[COMPOSICAO]
				   ,[RESTRICAO_LAVAGEM]
				   ,[REFERENCIA_BASE]
				   ,[DESENHO]
				   ,[ID_EXCECAO_IMPOSTO]
				   ,[MRP_AGRUPAR_NECESSIDADE_TIPO]
				   ,[INDICADOR_CFOP]
				   ,[MRP_AGRUPAR_NECESSIDADE_DIAS]
				   ,[MRP_MAIOR_GIRO_MP_DIAS]
				   ,[MRP_EMISSAO_LIBERACAO_DIAS]
				   ,[MRP_ENTREGA_GIRO_DIAS]
				   ,[MRP_DIAS_SEGURANCA]
				   ,[CONTA_CONTABIL_COMPRA]
				   ,[CONTA_CONTABIL_VENDA]
				   ,[CONTA_CONTABIL_DEV_COMPRA]
				   ,[CONTA_CONTABIL_DEV_VENDA]
				   ,[ID_EXCECAO_GRUPO]
				   ,[TIPO_ITEM_SPED]
				   ,[NATUREZA_RECEITA]
				   ,[COD_ALIQUOTA_PIS_COFINS_DIF]
				   ,[GRIFFE]
				   ,[SPED_DATA_FIM]
				   ,[SPED_DATA_INI]
				   ,[TIPO_PP]
				   ,[ID_CEST_NCM])
		SELECT      [MATERIAL]
				   ,'PCP'
				   ,'001'
				   ,'INDEFINIDO'
				   ,[TRIBUT_ICMS]
				   ,[TRIBUT_ORIGEM]
				   ,[CLASSIF_FISCAL]
				   ,'D.R. LINGERIE            '
				   ,[GRUPO]
				   ,[COLECAO]
				   ,[SUBGRUPO]
				   ,[DESC_MATERIAL]
				   ,[FATOR_CONVERSAO]
				   ,[UNID_ESTOQUE]
				   ,[DIAS_ENTREGA]
				   ,[UNID_FICHA_TEC]
				   ,'000'
				   ,[UNID_AUXILIAR]
				   ,[CTRL_UNID_AUX]
				   ,[REVENDA]
				   ,[COMPRIMENTO]
				   ,[COD_MATERIAL_TAMANHO]
				   ,[VARIA_MATERIAL_TAMANHO]
				   ,[CTRL_PARTIDAS]
				   ,[LARGURA]
				   ,[VARIA_CUSTO_COR]
				   ,[CTRL_PECAS]
				   ,[VARIA_PRECO_COR]
				   ,[CTRL_PECAS_PARCIAL]
				   ,[DATA_REPOSICAO]
				   ,[CUSTO_REPOSICAO]
				   ,[REF_FABRICANTE]
				   ,[ICMS_CUSTOS]
				   ,[CUSTO_A_VISTA]
				   ,[TAXA_JUROS_CUSTO]
				   ,[MATERIAL_INDIRETO]
				   ,[RESERVA_MATERIAL_OP]
				   ,[ABATER_RESERVA_QTDE]
				   ,[OBS]
				   ,[DESC_NF]
				   ,[CODIGO_ETIQUETA_GRIFFE]
				   ,[CONTA_CONTABIL] --'11406'
				   ,[INATIVO]
				   ,[SEMI_ACABADO]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[COMPRA_MINIMA]
				   ,[LOTE_ECONOMICO_COMPRAS]
				   ,[TEC_SIMPLES_TUBULAR_ABERTO]
				   ,[TEC_LISO_ESTAMPA_LISTRA_XADREX]
				   ,[TEC_TORNASOL]
				   ,[DATA_CADASTRAMENTO]
				   ,[COMPOSICAO]
				   ,[RESTRICAO_LAVAGEM]
				   ,[REFERENCIA_BASE]
				   ,[DESENHO]
				   ,NULL
				   ,[MRP_AGRUPAR_NECESSIDADE_TIPO]
				   ,[INDICADOR_CFOP]
				   ,[MRP_AGRUPAR_NECESSIDADE_DIAS]
				   ,[MRP_MAIOR_GIRO_MP_DIAS]
				   ,[MRP_EMISSAO_LIBERACAO_DIAS]
				   ,[MRP_ENTREGA_GIRO_DIAS]
				   ,[MRP_DIAS_SEGURANCA]
				   ,NULL
				   ,NULL
				   ,NULL
				   ,NULL
				   ,NULL
				   ,[TIPO_ITEM_SPED]
				   ,[NATUREZA_RECEITA]
				   ,[COD_ALIQUOTA_PIS_COFINS_DIF]
				   ,[GRIFFE]
				   ,[SPED_DATA_FIM]
				   ,[SPED_DATA_INI]
				   ,[TIPO_PP]
				   ,[ID_CEST_NCM]
		FROM DRLINGERIE.[dbo].[MATERIAIS] A 
		WHERE NOT EXISTS(SELECT * FROM MATERIAIS WHERE MATERIAL=A.MATERIAL)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- MATERIAIS_CORES
	begin
		INSERT INTO [dbo].[MATERIAIS_CORES]
				   ([MATERIAL]
				   ,[COR_MATERIAL]
				   ,[DESC_COR_MATERIAL]
				   ,[REFER_FABRICANTE]
				   ,[CUSTO_REPOSICAO]
				   ,[CUSTO_A_VISTA]
				   ,[CODIGO_EXPORTACAO]
				   ,[LOCALIZACAO]
				   ,[INICIO_VENDAS]
				   ,[FIM_VENDAS]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[PROCESSO_FABRICACAO]
				   ,[TEC_ENCOLHIMENTO_CORTE_X]
				   ,[TEC_ENCOLHIMENTO_CORTE_Y]
				   ,[TEC_ENCOLHIMENTO_ACABAMENTO_X]
				   ,[TEC_ENCOLHIMENTO_ACABAMENTO_Y]
				   ,[TEC_ENCOLHIMENTO_LAVAGEM_X]
				   ,[TEC_ENCOLHIMENTO_LAVAGEM_Y]
				   ,[FIO_TORSAO]
				   ,[FIO_CABOS]
				   ,[FIO_FILAMENTOS]
				   ,[FIO_ESPESSURA]
				   ,[TEC_COM_FALHA_AGULHA]
				   ,[GRAMATURA]
				   ,[DESENHO]
				   ,[VARIANTE_DESENHO]
				   ,[COR]
				   ,[COMPOSICAO]
				   ,[CLASSIF_FISCAL]
				   ,[VERSAO_FICHA]
				   ,[COR_TRANSPARENTE]
				   ,[INATIVO]
				   ,[RECURSO_PRODUTIVO]
				   ,[PROCESSO_PRODUTIVO]
				   ,[COMPRA_MINIMA_COR])
		SELECT      [MATERIAL]
				   ,[COR_MATERIAL]
				   ,[DESC_COR_MATERIAL]
				   ,[REFER_FABRICANTE]
				   ,[CUSTO_REPOSICAO]
				   ,[CUSTO_A_VISTA]
				   ,[CODIGO_EXPORTACAO]
				   ,NULL
				   ,[INICIO_VENDAS]
				   ,[FIM_VENDAS]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[PROCESSO_FABRICACAO]
				   ,[TEC_ENCOLHIMENTO_CORTE_X]
				   ,[TEC_ENCOLHIMENTO_CORTE_Y]
				   ,[TEC_ENCOLHIMENTO_ACABAMENTO_X]
				   ,[TEC_ENCOLHIMENTO_ACABAMENTO_Y]
				   ,[TEC_ENCOLHIMENTO_LAVAGEM_X]
				   ,[TEC_ENCOLHIMENTO_LAVAGEM_Y]
				   ,[FIO_TORSAO]
				   ,[FIO_CABOS]
				   ,[FIO_FILAMENTOS]
				   ,[FIO_ESPESSURA]
				   ,[TEC_COM_FALHA_AGULHA]
				   ,[GRAMATURA]
				   ,[DESENHO]
				   ,[VARIANTE_DESENHO]
				   ,[COR]
				   ,[COMPOSICAO]
				   ,[CLASSIF_FISCAL]
				   ,[VERSAO_FICHA]
				   ,[COR_TRANSPARENTE]
				   ,[INATIVO]
				   ,[RECURSO_PRODUTIVO]
				   ,[PROCESSO_PRODUTIVO]
				   ,[COMPRA_MINIMA_COR]
		FROM DRLINGERIE.[dbo].[MATERIAIS_CORES] A
		WHERE EXISTS(SELECT * FROM MATERIAIS WHERE MATERIAL=A.MATERIAL) and not exists(select * from MATERIAIS_CORES where MATERIAL=a.material and COR_MATERIAL=a.COR_MATERIAL)
		IF @@ERROR > 0	GOTO ERROR	   
	end

	-- CADASTRO_ITENS_FISCAIS
	begin
		INSERT INTO [dbo].[CADASTRO_ITEM_FISCAL]
				   ([ITEM_DESCRICAO]
				   ,[CODIGO_ITEM]
				   ,[UNIDADE]
				   ,[PRECO_UNITARIO]
				   ,[COMISSAO_ITEM]
				   ,[COMISSAO_ITEM_GERENTE]
				   ,[ITEM_FISCAL_GRUPO]
				   ,[RATEIO_CENTRO_CUSTO]
				   ,[CLASSIF_FISCAL]
				   ,[CONTA_CONTABIL]
				   ,[INDICADOR_CFOP]
				   ,[ID_EXCECAO_GRUPO]
				   ,[RATEIO_FILIAL]
				   ,[TRIBUT_ORIGEM]
				   ,[TIPO_ITEM_SPED]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[INATIVO]
				   ,[NATUREZA_RECEITA]
				   ,[COD_ALIQUOTA_PIS_COFINS_DIF]
				   ,[CLASSE_IMOBILIZADO]
				   ,[SUBCLASSE_IMOBILIZADO]
				   ,[TIPO_RECEITA_COMUNICACAO_SPED]
				   ,[LX_STATUS_REGISTRO]
				   ,[IDENT_UTILIZACAO_IMOB]
				   ,[ID_CEST_NCM])
		SELECT      [ITEM_DESCRICAO]
				   ,[CODIGO_ITEM]
				   ,[UNIDADE]
				   ,[PRECO_UNITARIO]
				   ,[COMISSAO_ITEM]
				   ,[COMISSAO_ITEM_GERENTE]
				   ,NULL
				   ,[RATEIO_CENTRO_CUSTO]
				   ,[CLASSIF_FISCAL]
				   ,NULL
				   ,[INDICADOR_CFOP]
				   ,NULL
				   ,NULL
				   ,[TRIBUT_ORIGEM]
				   ,[TIPO_ITEM_SPED]
				   ,[DATA_PARA_TRANSFERENCIA]
				   ,[INATIVO]
				   ,[NATUREZA_RECEITA]
				   ,[COD_ALIQUOTA_PIS_COFINS_DIF]
				   ,[CLASSE_IMOBILIZADO]
				   ,[SUBCLASSE_IMOBILIZADO]
				   ,[TIPO_RECEITA_COMUNICACAO_SPED]
				   ,[LX_STATUS_REGISTRO]
				   ,[IDENT_UTILIZACAO_IMOB]
				   ,[ID_CEST_NCM]
		FROM DRLINGERIE.[dbo].[CADASTRO_ITEM_FISCAL] A
		WHERE NOT EXISTS(SELECT * FROM CADASTRO_ITEM_FISCAL WHERE CODIGO_ITEM=A.CODIGO_ITEM)
		IF @@ERROR > 0	GOTO ERROR	   
	end

    /* CRIAÇÃO DE TABELAS AUXILIARES */
	-- TABELA PARAMETROS PARA IMPORT DE XML
	-- PARAMETROS_IMPORT_XML
	begin
		IF NOT EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='PARAMETROS_IMPORT_XML')
			create table PARAMETROS_IMPORT_XML (
							[CODIGO_FISCAL_OPERACAO] [char](4) NOT NULL,
							[NATUREZA_ENTRADA] [CHAR](15) NOT NULL,
							[RATEIO_CENTRO_CUSTO] [VARCHAR](15) NOT NULL,
							[TIPO_ENTRADAS] [VARCHAR](25) NOT NULL,
							[RATEIO_FILIAL] [VARCHAR](15) NOT NULL,
							[COD_CLIFOR_SACADO] [CHAR](6) NOT NULL,
							[natOp] [varchar](max) not null,
			CONSTRAINT [XPK_PARAMETROS_IMPORT_XML] PRIMARY KEY CLUSTERED
			(
							[NATUREZA_ENTRADA] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
			) ON [PRIMARY]

			ALTER TABLE PARAMETROS_IMPORT_XML ALTER column [RATEIO_FILIAL] [VARCHAR](15) NOT NULL
    end

	-- XML_NFE_CAPA
	begin
		IF NOT EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='XML_NFE_CAPA')
			CREATE TABLE [dbo].[XML_NFE_CAPA](
							[chNFe] [varchar](44) NOT NULL,
							[nProt] [varchar](20) NULL,
							[dhRecbto] [datetime] NULL,
							[cUF] [char](2) NULL,
							[cNF] [char](10) NULL,
							[natOp] [varchar](max) NULL,
							[indPag] [int] NULL,
							[mod] [int] NULL,
							[serie] [int] NULL,
							[nNF] [char](10) NULL,
							[dhEmi] [datetime] NULL,
							[dhSaiEnt] [datetime] NULL,
							[tpNF] [int] NULL,
							[idDest] [int] NULL,
							[cMunFG] [int] NULL,
							[tpImp] [int] NULL,
							[tpEmis] [int] NULL,
							[cDV] [int] NULL,
							[tpAmb] [int] NULL,
							[finNFe] [int] NULL,
							[indFinal] [int] NULL,
							[indPres] [int] NULL,
							[procEmi] [int] NULL,
							[emit_CNPJ] [varchar](20) NULL,
							[emit_xNome] [varchar](80) NULL,
							[emit_xFant] [varchar](30) NULL,
							[emit_xLgr] [varchar](max) NULL,
							[emit_nro] [varchar](50) NULL,
							[emit_xBairro] [varchar](max) NULL,
							[emit_cMun] [int] NULL,
							[emit_xMun] [varchar](50) NULL,
							[emit_UF] [char](2) NULL,
							[emit_CEP] [char](10) NULL,
							[emit_cPais] [char](6) NULL,
							[emit_xPais] [char](20) NULL,
							[emit_fone] [char](20) NULL,
							[emit_IE] [char](20) NULL,
							[emit_CRT] [int] NULL,
							[dest_CNPJ] [varchar](20) NULL,
							[dest_xNome] [varchar](80) NULL,
							[dest_xLgr] [varchar](max) NULL,
							[dest_nro] [varchar](50) NULL,
							[dest_xBairro] [varchar](max) NULL,
							[dest_cMun] [int] NULL,
							[dest_xMun] [varchar](50) NULL,
							[dest_UF] [char](2) NULL,
							[dest_CEP] [char](10) NULL,
							[dest_cPais] [char](6) NULL,
							[dest_xPais] [char](20) NULL,
							[dest_fone] [char](20) NULL,
							[dest_indIEDest] [int] NULL,
							[dest_IE] [char](20) NULL,
							[dest_email] [varchar](80) NULL,
							[infAdic] [varchar](max) NULL,
			CONSTRAINT [XPK_XML_NFE_CAPA] PRIMARY KEY CLUSTERED
			(
							[chNFe] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
			) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
    end

	-- XML_NFE_DUPLICATA
	begin
 		IF NOT EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='XML_NFE_DUPLICATA')
		begin
			CREATE TABLE [dbo].[XML_NFE_DUPLICATA](
							[chNFe] [varchar](44) NULL,
							[nFat] [char](10) NULL,
							[vOrig] [numeric](14, 2) NULL,
							[vLiq] [numeric](14, 2) NULL,
							[nDup] [char](10) NULL,
							[dVenc] [date] NULL,
							[vDup] [numeric](14, 2) NULL
			) ON [PRIMARY]
        end
		ALTER TABLE XML_NFE_DUPLICATA ALTER column chNFe [varchar](44) NOT NULL;
		ALTER TABLE XML_NFE_DUPLICATA ALTER column nFat [char](10) not null;

        IF NOT EXISTS(SELECT * FROM SYS.key_constraints WHERE NAME='XPK_XML_NFE_DUPLICATA')
		begin
			ALTER TABLE XML_NFE_DUPLICATA ADD CONSTRAINT XPK_XML_NFE_DUPLICATA PRIMARY KEY CLUSTERED (chNFe,nFat);
		end
    end

	-- XML_NFE_ITEM
	begin
  		IF NOT EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='XML_NFE_ITEM')
			CREATE TABLE [dbo].[XML_NFE_ITEM](
							[chNFe] [varchar](44) NOT NULL,
							[nItem] [varchar](44) NOT NULL,
							[cProd] [varchar](50) NULL,
							[cEAN] [varchar](30) NULL,
							[xProd] [varchar](max) NULL,
							[NCM] [varchar](20) NULL,
							[CFOP] [char](4) NULL,
							[uCom] [char](10) NULL,
							[qCom] [numeric](15, 4) NULL,
							[vUnCom] [numeric](25, 10) NULL,
							[vProd] [numeric](15, 2) NULL,
							[cEANTrib] [varchar](30) NULL,
							[uTrib] [char](10) NULL,
							[qTrib] [numeric](15, 4) NULL,
							[vUnTrib] [numeric](25, 10) NULL,
							[indTot] [char](1) NULL,
							[infAdProd] [varchar](max) NULL,
							[vTotTrib] [numeric](14, 2) NULL,
							[ICMS_orig] [int] NULL,
							[ICMS_CST] [char](5) NULL,
							[ICMS_modBC] [int] NULL,
							[ICMS_vBC] [numeric](14, 2) NULL,
							[ICMS_pICMS] [numeric](18, 4) NULL,
							[ICMS_vICMS] [numeric](14, 2) NULL,
							[IPI_cEnq] [char](3) NULL,
							[IPI_CST] [char](3) NULL,
							[IPI_vBC] [numeric](14, 2) NULL,
							[IPI_pIPI] [numeric](18, 4) NULL,
							[IPI_vIPI] [numeric](14, 2) NULL,
							[PIS_CST] [char](3) NULL,
							[PIS_vBC] [numeric](14, 2) NULL,
							[PIS_pPIS] [numeric](18, 4) NULL,
							[PIS_vPIS] [numeric](14, 2) NULL,
							[COFINS_CST] [char](3) NULL,
							[COFINS_vBC] [numeric](14, 2) NULL,
							[COFINS_pCOFINS] [numeric](18, 4) NULL,
							[COFINS_vCOFINS] [numeric](14, 2) NULL,
			CONSTRAINT [XPK_XML_NFE_ITEM] PRIMARY KEY CLUSTERED
			(
							[chNFe] ASC,
							[nItem] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
			) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	end
	
	-- XML_NFE_TOTAL
	begin	 
   		IF NOT EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='XML_NFE_TOTAL')
			CREATE TABLE [dbo].[XML_NFE_TOTAL](
							[chNFe] [varchar](44) NOT NULL,
							[vBC] [numeric](14, 2) NULL,
							[vICMS] [numeric](14, 2) NULL,
							[vICMSDeson] [numeric](14, 2) NULL,
							[vBCST] [numeric](14, 2) NULL,
							[vST] [numeric](14, 2) NULL,
							[vProd] [numeric](14, 2) NULL,
							[vFrete] [numeric](14, 2) NULL,
							[vSeg] [numeric](14, 2) NULL,
							[vDesc] [numeric](14, 2) NULL,
							[vII] [numeric](14, 2) NULL,
							[vIPI] [numeric](14, 2) NULL,
							[vPIS] [numeric](14, 2) NULL,
							[vCOFINS] [numeric](14, 2) NULL,
							[vOutro] [numeric](14, 2) NULL,
							[vNF] [numeric](14, 2) NULL,
							[vTotTrib] [numeric](14, 2) NULL,
			CONSTRAINT [XPK_XML_NFE_TOTAL] PRIMARY KEY CLUSTERED
			(
							[chNFe] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
			) ON [PRIMARY]	
	end
	
	-- XML_NFE_TRANSPORTADOR 
	begin
   		IF NOT EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='XML_NFE_TRANSPORTADOR')
			CREATE TABLE [dbo].[XML_NFE_TRANSPORTADOR](
							[chNFe] [varchar](44) NOT NULL,
							[modFrete] [int] NULL,
							[CNPJ] [char](14) NULL,
							[xNome] [varchar](80) NULL,
							[IE] [char](20) NULL,
							[xEnder] [varchar](max) NULL,
							[xMun] [varchar](35) NULL,
							[UF] [char](2) NULL,
							[qVol] [int] NULL,
							[esp] [varchar](40) NULL,
							[pesoL] [numeric](14, 3) NULL,
							[pesoB] [numeric](14, 3) NULL,
			CONSTRAINT [XPK_XML_NFE_TRANSPORTADOR] PRIMARY KEY CLUSTERED
			(
							[chNFe] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
			) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	end
	 
	-- IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM
	begin
   		IF NOT EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM')
			CREATE TABLE [dbo].[IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM](
				[REFERENCIA] [varchar](50) NOT NULL,
				[ORIGEM_ITEM] [char](1) NOT NULL,
				[CONTA_CONTABIL] [varchar](20) NOT NULL,
				[INDICADOR_CFOP] [tinyint] NOT NULL,
			 CONSTRAINT [PK_IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM] PRIMARY KEY CLUSTERED 
			(
				[REFERENCIA] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
			) ON [PRIMARY]
    end

	-- IMPORT DE FATURAMENTO
    begin
		IF NOT EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='tmp_faturamento_dr')
			CREATE TABLE [dbo].[tmp_faturamento_dr](
				[FILIAL] [varchar](25) NOT NULL,
				[NF_SAIDA] [char](15) NOT NULL,
				[SERIE_NF] [varchar](6) NOT NULL,
				[CODIGO_LOCAL_ENTREGA] [char](5) NULL,
				[FILIAL_FATURADA] [varchar](25) NULL,
				[TIPO_FATURAMENTO] [varchar](25) NULL,
				[LANCAMENTO] [char](8) NULL,
				[NOME_CLIFOR] [varchar](25) NOT NULL,
				[CONDICAO_PGTO] [char](3) NOT NULL,
				[NATUREZA_SAIDA] [char](7) NOT NULL,
				[TRANSPORTADORA] [varchar](25) NULL,
				[TRANSP_REDESPACHO] [varchar](25) NULL,
				[TIPO_FRETE] [char](2) NULL,
				[COD_TRANSACAO] [char](23) NOT NULL,
				[EMISSAO] [datetime] NULL,
				[DATA_SAIDA] [datetime] NULL,
				[FRETE] [numeric](14, 2) NULL,
				[SEGURO] [numeric](14, 2) NULL,
				[DESCONTO] [numeric](14, 2) NULL,
				[DESCONTO_COND_PGTO] [numeric](14, 2) NULL,
				[ENCARGO] [numeric](14, 2) NULL,
				[ICMS] [numeric](14, 2) NULL,
				[IPI_VALOR] [numeric](14, 2) NULL,
				[VALOR_TOTAL] [numeric](14, 2) NULL,
				[QTDE_TOTAL] [numeric](9, 3) NULL,
				[NF_FATURA] [bit] NOT NULL,
				[FATURA] [char](15) NULL,
				[NOTA_IMPRESSA] [bit] NOT NULL,
				[ACERTO_CONTAS_P_R] [bit] NOT NULL,
				[TABELA_FILHA] [char](18) NOT NULL,
				[OBS] [text] NULL,
				[PESO_LIQUIDO] [numeric](9, 3) NULL,
				[PESO_BRUTO] [numeric](9, 3) NULL,
				[VOLUMES] [int] NULL,
				[TIPO_VOLUME] [varchar](35) NULL,
				[CONFERIDO] [bit] NOT NULL,
				[CONFERIDO_POR] [varchar](25) NULL,
				[ENTREGA_CIF] [tinyint] NULL,
				[IRRF] [numeric](14, 2) NULL,
				[IRRF_RET_FONTE] [bit] NOT NULL,
				[NOTA_CANCELADA] [bit] NOT NULL,
				[DEVOLUCAO] [bit] NOT NULL,
				[REPRESENTANTE] [varchar](25) NULL,
				[COMISSAO] [numeric](8, 5) NULL,
				[PORCENTAGEM_ACERTO] [numeric](8, 5) NULL,
				[GERENTE] [varchar](25) NULL,
				[COMISSAO_GERENTE] [numeric](8, 5) NULL,
				[DESCONTO_BRUTO] [numeric](14, 2) NULL,
				[TIMESTAMP] [varchar](28) NULL,
				[CONFERENCIA] [varchar](11) NULL,
				[MARCA_EXPORTACAO] [char](1) NULL,
				[ATUALIZACAO_EXPORTAR] [datetime] NULL,
				[DATA_EXPORTACAO] [datetime] NULL,
				[ICMS_BASE] [numeric](14, 2) NULL,
				[STATUS_TRANSITO] [char](1) NULL,
				[DATA_CANCELAMENTO] [datetime] NULL,
				[VALOR_CANCELADO] [numeric](14, 2) NULL,
				[QTDE_CANCELADA] [int] NULL,
				[MOEDA] [char](6) NULL,
				[CAMBIO_NA_DATA] [numeric](11, 6) NULL,
				[COBRAR_MOEDA_PADRAO] [bit] NOT NULL,
				[DATA_FATURAMENTO_RELATIVO] [datetime] NULL,
				[RECARGO] [numeric](14, 2) NULL,
				[DATA_PARA_TRANSFERENCIA] [datetime] NULL,
				[NOME_CLIFOR_ENTREGA] [varchar](25) NULL,
				[TABELA_PRECO_FRETE] [varchar](25) NULL,
				[VALOR_FRETE] [numeric](16, 2) NULL,
				[NOME_CLIFOR_COBRANCA] [varchar](25) NULL,
				[OBS_TRANSPORTE] [varchar](200) NULL,
				[VALOR_ADICIONAL] [numeric](14, 2) NULL,
				[EMPRESA] [int] NULL,
				[IPI_ADICIONAL] [numeric](14, 2) NULL,
				[CTB_LANCAMENTO] [int] NULL,
				[CTB_ITEM] [smallint] NULL,
				[NUMERO_CONFERENCIA] [int] NULL,
				[ICMS_ISENTO] [numeric](16, 2) NULL,
				[ICMS_OUTROS] [numeric](16, 2) NULL,
				[RATEIO_FILIAL] [varchar](15) NULL,
				[RATEIO_CENTRO_CUSTO] [varchar](15) NULL,
				[NUMERO_CONFERENCIA_ITEM] [int] NULL,
				[FATURA_FILIAL] [varchar](25) NULL,
				[FATURA_NUMERO] [char](15) NULL,
				[FATURA_SERIE] [varchar](6) NULL,
				[AGRUPAMENTO_ITENS] [smallint] NULL,
				[COMISSAO_VALOR] [numeric](14, 2) NULL,
				[COMISSAO_VALOR_GERENTE] [numeric](14, 2) NULL,
				[DESCONTO_BRUTO_1] [numeric](8, 2) NULL,
				[DESCONTO_BRUTO_2] [numeric](8, 2) NULL,
				[DESCONTO_BRUTO_3] [numeric](8, 2) NULL,
				[DESCONTO_BRUTO_4] [numeric](8, 2) NULL,
				[DESCONTO_SOBRE_1] [numeric](8, 2) NULL,
				[DESCONTO_SOBRE_2] [numeric](8, 2) NULL,
				[DESCONTO_SOBRE_3] [numeric](8, 2) NULL,
				[DESCONTO_SOBRE_4] [numeric](8, 2) NULL,
				[MPADRAO_DESCONTO] [numeric](14, 2) NULL,
				[MPADRAO_DESCONTO_COND_PGTO] [numeric](14, 2) NULL,
				[MPADRAO_ENCARGO] [numeric](14, 2) NULL,
				[MPADRAO_FRETE] [numeric](14, 2) NULL,
				[MPADRAO_SEGURO] [numeric](14, 2) NULL,
				[MPADRAO_VALOR_SUB_ITENS] [numeric](14, 2) NULL,
				[MPADRAO_VALOR_TOTAL] [numeric](14, 2) NULL,
				[MULTI_DESCONTO_ACUMULAR] [bit] NOT NULL,
				[PORC_DESCONTO] [numeric](13, 10) NULL,
				[PORC_DESCONTO_BRUTO] [numeric](13, 10) NULL,
				[PORC_DESCONTO_COND_PGTO] [numeric](13, 10) NULL,
				[PORC_DESCONTO_DIGITADO] [bit] NOT NULL,
				[PORC_ENCARGO] [numeric](13, 10) NULL,
				[VALOR_DIFERENCA_GUIA_FATURA] [numeric](14, 2) NULL,
				[VALOR_SUB_ITENS] [numeric](14, 2) NULL,
				[MPADRAO_IMPOSTO_AGREGAR] [numeric](14, 2) NULL,
				[VALOR_IMPOSTO_AGREGAR] [numeric](14, 2) NULL,
				[IMPRIMIR_ENDERECO_COBRANCA] [int] NULL,
				[INDICA_CONSUMIDOR_FINAL] [bit] NOT NULL,
				[BANCO] [char](5) NULL,
				[AGENCIA] [varchar](20) NULL,
				[RESPONSAVEL_TRANSPORTE] [varchar](40) NULL,
				[NOTA_COMPLEMENTAR] [bit] NOT NULL,
				[NUMERO_CONHECIMENTO_RELACIONADO] [char](7) NULL,
				[DESCONTO_SEFAZ] [numeric](14, 2) NULL,
				[PORC_DESCONTO_SEFAZ] [numeric](8, 5) NULL,
				[MPADRAO_DESCONTO_SEFAZ] [numeric](14, 2) NULL,
				[ID_CAIXA_PGTO] [int] NULL,
				[NRO_DE] [varchar](15) NULL,
				[DATA_DE] [datetime] NULL,
				[NATUREZA_EXPORTACAO] [char](1) NULL,
				[NRO_RE] [varchar](15) NULL,
				[DATA_RE] [datetime] NULL,
				[NRO_CONHECIMENTO_EMBARQUE] [varchar](20) NULL,
				[DATA_CONHECIMENTO] [datetime] NULL,
				[TIPO_CONHECIMENTO] [char](2) NULL,
				[COD_PAIS] [varchar](4) NULL,
				[NRO_COMPROVANTE_EXPORTACAO] [varchar](15) NULL,
				[DATA_COMPROVANTE_EXPORTACAO] [datetime] NULL,
				[DATA_AVERBACAO] [datetime] NULL,
				[NF_EMITIDA_EXPORTADOR] [varchar](15) NULL,
				[COD_RELACIONAMENTO_RE_NF] [char](1) NULL,
				[NF_E_NUMERO] [char](10) NULL,
				[NF_E_DATA_EMISSAO] [datetime] NULL,
				[NF_E_COD_VERIFICACAO] [char](10) NULL,
				[NF_E_DATA_QUITACAO_GUIA] [datetime] NULL,
				[NF_E_GERACAO] [datetime] NULL,
				[SEQUENCIAL_UNICO] [int] NULL,
				[DATA_GERACAO_NSU] [datetime] NULL,
				[CODIGO_CLIENTE_VAREJO] [varchar](14) NULL,
				[CHAVE_NFE] [varchar](44) NULL,
				[PROTOCOLO_AUTORIZACAO_NFE] [varchar](15) NULL,
				[COD_MOTIVO_CANC] [char](2) NULL,
				[PIN] [varchar](9) NULL,
				[PROTOCOLO_CANCELAMENTO_NFE] [varchar](15) NULL,
				[DATA_AUTORIZACAO_NFE] [datetime] NULL,
				[GERAR_AUTOMATICO] [bit] NOT NULL,
				[STATUS_NFE] [smallint] NULL,
				[LOG_STATUS_NFE] [smallint] NULL,
				[MOTIVO_CANCELAMENTO_NFE] [varchar](255) NULL,
				[PRIORIZACAO] [bit] NOT NULL,
				[TIPO_EMISSAO_NFE] [tinyint] NULL,
				[FIN_EMISSAO_NFE] [tinyint] NULL,
				[REGISTRO_DPEC] [varchar](15) NULL,
				[DATA_REGISTRO_DPEC] [datetime] NULL,
				[ITEM_NFE] [smallint] NULL,
				[OBS_INTERESSE_FISCO] [text] NULL,
				[DATA_CONTINGENCIA] [datetime] NULL,
				[JUSTIFICATIVA_CONTINGENCIA] [varchar](256) NULL,
				[UF_EMBARQUE_EXPORTACAO] [char](2) NULL,
				[LOCAL_EMBARQUE_EXPORTACAO] [varchar](60) NULL,
				[CFOP_CANCELAMENTO] [char](4) NULL,
				[VALOR_DESPACHO] [numeric](14, 2) NULL,
				[VALOR_IMPOSTO_INCIDENCIA] [numeric](14, 2) NULL,
				[MPADRAO_VALOR_IMPOSTO_INCIDENCIA] [numeric](14, 2) NULL,
				[VEICULO_PLACA] [varchar](8) NULL,
				[UF_PLACA_VEICULO] [char](2) NULL,
				[MARCA_VOLUMES] [varchar](60) NULL,
				[NUMERACAO_VOLUMES] [varchar](60) NULL,
				[INFORMACAO_COMPLEMENTAR] [varchar](5000) NULL,
				[DATA_HORA_EMISSAO] [smalldatetime] NULL,
				[INDICA_PRESENCA_COMPRADOR] [tinyint] NOT NULL,
				[LOCAL_DESPACHO_EXPORTACAO] [varchar](60) NULL,
				[UTC_DATA_AUTORIZACAO_NFE] [tinyint] NULL,
				[UTC_DATA_SAIDA] [tinyint] NULL,
				[UTC_EMISSAO] [tinyint] NULL,
				[INDICA_ENDERECO_ENTREGA] [bit] NULL
			) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

        IF NOT EXISTS(SELECT NAME FROM SYS.indexes WHERE NAME='XIE1tmp_faturamento_dr') 
			/****** Object:  Index [XIE1tmp_faturamento_dr]    Script Date: 08/03/2017 09:58:51 ******/
			CREATE NONCLUSTERED INDEX [XIE1tmp_faturamento_dr] ON [dbo].[tmp_faturamento_dr]
			(
				[NF_SAIDA] ASC,
				[SERIE_NF] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	end

	-- IMPORT DE FATURAMENTO_ITEM
	begin
		IF NOT EXISTS(SELECT NAME FROM SYS.tables WHERE NAME='tmp_faturamento_item_dr')
			CREATE TABLE [dbo].[tmp_faturamento_item_dr](
				[CLASSIF_FISCAL] [char](10) NOT NULL,
				[CODIGO_FISCAL_OPERACAO] [char](4) NOT NULL,
				[CODIGO_ITEM] [varchar](50) NOT NULL,
				[COD_TABELA_FILHA] [char](1) NULL,
				[COMISSAO_ITEM] [numeric](13, 10) NULL,
				[COMISSAO_ITEM_GERENTE] [numeric](13, 10) NULL,
				[CONTA_CONTABIL] [varchar](20) NULL,
				[DESCONTO_ITEM] [numeric](14, 2) NULL,
				[DESCRICAO_ITEM] [varchar](max) NULL,
				[FAIXA] [char](1) NOT NULL,
				[FILIAL] [varchar](25) NOT NULL,
				[ID_EXCECAO_IMPOSTO] [int] NULL,
				[INDICADOR_CFOP] [tinyint] NULL,
				[ITEM_IMPRESSAO] [char](4) NOT NULL,
				[MPADRAO_DESCONTO_ITEM] [numeric](15, 5) NULL,
				[MPADRAO_PRECO_UNITARIO] [numeric](15, 5) NULL,
				[MPADRAO_VALOR_ITEM] [numeric](14, 2) NULL,
				[NF_SAIDA] [char](15) NOT NULL,
				[PESO] [numeric](7, 3) NULL,
				[PORCENTAGEM_ITEM_RATEIO] [numeric](13, 10) NULL,
				[PRECO_UNITARIO] [numeric](15, 5) NULL,
				[QTDE_DEVOLVIDA] [numeric](9, 3) NULL,
				[QTDE_ITEM] [numeric](9, 3) NULL,
				[QTDE_RETORNAR_BENEFICIAMENTO] [numeric](9, 3) NULL,
				[SERIE_NF] [varchar](6) NOT NULL,
				[SUB_ITEM_TAMANHO] [int] NOT NULL,
				[TRIBUT_ICMS] [char](3) NOT NULL,
				[TRIBUT_ORIGEM] [char](3) NOT NULL,
				[UNIDADE] [varchar](5) NULL,
				[VALOR_ITEM] [numeric](14, 2) NULL,
				[REFERENCIA] [varchar](50) NULL,
				[REFERENCIA_ITEM] [varchar](12) NULL,
				[REFERENCIA_PEDIDO] [varchar](12) NULL,
				[TIMESTAMP] [varchar](25) NULL,
				[MPADRAO_VALOR_DESCONTOS] [numeric](14, 2) NULL,
				[MPADRAO_VALOR_ENCARGOS] [numeric](14, 2) NULL,
				[NAO_SOMA_VALOR] [bit] NOT NULL,
				[OBS_ITEM] [varchar](254) NULL,
				[ITEM_NFE] [smallint] NULL,
				[MPADRAO_SEGURO_ITEM] [numeric](14, 2) NULL,
				[MPADRAO_FRETE_ITEM] [numeric](14, 2) NULL,
				[MPADRAO_ENCARGO_ITEM] [numeric](14, 2) NULL,
				[RATEIO_FILIAL] [varchar](15) NULL,
				[RATEIO_CENTRO_CUSTO] [varchar](15) NULL,
				[ORIGEM_ITEM] [char](1) NULL,
				[VALOR_IMPOSTO_ITEM] [numeric](14, 2) NULL,
				[INDICA_PRODUTO_PROCESSO] [bit] NOT NULL,
				[CODIGO_FCI] [char](36) NULL,
				[PRECO_UNITARIO_ORIGINAL] [numeric](15, 5) NOT NULL,
				[CTB_TIPO_OPERACAO] [int] NULL,
				[ID_SUB_PROJETO] [int] NULL,
				[VALOR_IMPOSTO_ITEM_MUNICIPAL] [numeric](9, 2) NOT NULL,
				[VALOR_IMPOSTO_ITEM_ESTADUAL] [numeric](9, 2) NOT NULL,
				[ID_CEST_NCM] [int] NULL
			) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

		IF NOT EXISTS(SELECT NAME FROM SYS.indexes WHERE NAME='XIE1_tmp_faturamento_item_dr') 
			/****** Object:  Index [XIE1_tmp_faturamento_item_dr]    Script Date: 08/03/2017 09:59:56 ******/
			CREATE NONCLUSTERED INDEX [XIE1_tmp_faturamento_item_dr] ON [dbo].[tmp_faturamento_item_dr]
			(
				[NF_SAIDA] ASC,
				[SERIE_NF] ASC
			)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	end

	---- POPULAR IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM
	begin
		INSERT INTO IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM (REFERENCIA,ORIGEM_ITEM,CONTA_CONTABIL,INDICADOR_CFOP) 
		SELECT PRODUTO,'P',CONTA_CONTABIL,INDICADOR_CFOP FROM PRODUTOS A
		WHERE NOT EXISTS(SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM WHERE REFERENCIA=A.PRODUTO) AND A.PRODUTO <> '' AND A.CONTA_CONTABIL IS NOT NULL AND A.INDICADOR_CFOP IS NOT NULL
		----
		INSERT INTO IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM (REFERENCIA,ORIGEM_ITEM,CONTA_CONTABIL,INDICADOR_CFOP) 
		SELECT MATERIAL,'M',CONTA_CONTABIL,INDICADOR_CFOP FROM MATERIAIS A
		WHERE NOT EXISTS(SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM WHERE REFERENCIA=A.MATERIAL) AND A.MATERIAL <> '' AND A.CONTA_CONTABIL IS NOT NULL AND A.INDICADOR_CFOP IS NOT NULL
		----
		INSERT INTO IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM (REFERENCIA,ORIGEM_ITEM,CONTA_CONTABIL,INDICADOR_CFOP) 
		SELECT CODIGO_ITEM,'I',CONTA_CONTABIL,INDICADOR_CFOP FROM CADASTRO_ITEM_FISCAL A
		WHERE NOT EXISTS(SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM WHERE REFERENCIA=A.CODIGO_ITEM) AND A.CODIGO_ITEM <> '' AND A.CONTA_CONTABIL IS NOT NULL AND A.INDICADOR_CFOP IS NOT NULL
	end
	----
	/* FIM CRIAÇÃO DE TABELAS */

	-- tabela auxiliar para trocar os caracteres retirados do produto pelo Linx
	begin
		INSERT INTO [dbo].[tmp_faturamento_dr]
				   ([FILIAL]
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
				   ,[DESCONTO_SEFAZ]
				   ,[PORC_DESCONTO_SEFAZ]
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
				   ,[CHAVE_NFE]
				   ,[PROTOCOLO_AUTORIZACAO_NFE]
				   ,[COD_MOTIVO_CANC]
				   ,[PIN]
				   ,[PROTOCOLO_CANCELAMENTO_NFE]
				   ,[DATA_AUTORIZACAO_NFE]
				   ,[GERAR_AUTOMATICO]
				   ,[STATUS_NFE]
				   ,[LOG_STATUS_NFE]
				   ,[MOTIVO_CANCELAMENTO_NFE]
				   ,[PRIORIZACAO]
				   ,[TIPO_EMISSAO_NFE]
				   ,[FIN_EMISSAO_NFE]
				   ,[REGISTRO_DPEC]
				   ,[DATA_REGISTRO_DPEC]
				   ,[ITEM_NFE]
				   ,[OBS_INTERESSE_FISCO]
				   ,[DATA_CONTINGENCIA]
				   ,[JUSTIFICATIVA_CONTINGENCIA]
				   ,[UF_EMBARQUE_EXPORTACAO]
				   ,[LOCAL_EMBARQUE_EXPORTACAO]
				   ,[CFOP_CANCELAMENTO]
				   ,[VALOR_DESPACHO]
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
		SELECT
					a.[FILIAL]
				   ,a.[NF_SAIDA]
				   ,a.[SERIE_NF]
				   ,a.[CODIGO_LOCAL_ENTREGA]
				   ,a.[FILIAL_FATURADA]
				   ,a.[TIPO_FATURAMENTO]
				   ,a.[LANCAMENTO]
				   ,a.[NOME_CLIFOR]
				   ,a.[CONDICAO_PGTO]
				   ,a.[NATUREZA_SAIDA]
				   ,a.[TRANSPORTADORA]
				   ,a.[TRANSP_REDESPACHO]
				   ,a.[TIPO_FRETE]
				   ,a.[COD_TRANSACAO]
				   ,a.[EMISSAO]
				   ,a.[DATA_SAIDA]
				   ,a.[FRETE]
				   ,a.[SEGURO]
				   ,a.[DESCONTO]
				   ,a.[DESCONTO_COND_PGTO]
				   ,a.[ENCARGO]
				   ,a.[ICMS]
				   ,a.[IPI_VALOR]
				   ,a.[VALOR_TOTAL]
				   ,a.[QTDE_TOTAL]
				   ,a.[NF_FATURA]
				   ,a.[FATURA]
				   ,a.[NOTA_IMPRESSA]
				   ,a.[ACERTO_CONTAS_P_R]
				   ,a.[TABELA_FILHA]
				   ,a.[OBS]
				   ,a.[PESO_LIQUIDO]
				   ,a.[PESO_BRUTO]
				   ,a.[VOLUMES]
				   ,a.[TIPO_VOLUME]
				   ,a.[CONFERIDO]
				   ,a.[CONFERIDO_POR]
				   ,a.[ENTREGA_CIF]
				   ,a.[IRRF]
				   ,a.[IRRF_RET_FONTE]
				   ,a.[NOTA_CANCELADA]
				   ,a.[DEVOLUCAO]
				   ,a.[REPRESENTANTE]
				   ,a.[COMISSAO]
				   ,a.[PORCENTAGEM_ACERTO]
				   ,a.[GERENTE]
				   ,a.[COMISSAO_GERENTE]
				   ,a.[DESCONTO_BRUTO]
				   ,a.[CONFERENCIA]
				   ,a.[MARCA_EXPORTACAO]
				   ,a.[ATUALIZACAO_EXPORTAR]
				   ,a.[DATA_EXPORTACAO]
				   ,a.[ICMS_BASE]
				   ,a.[STATUS_TRANSITO]
				   ,a.[DATA_CANCELAMENTO]
				   ,a.[VALOR_CANCELADO]
				   ,a.[QTDE_CANCELADA]
				   ,a.[MOEDA]
				   ,a.[CAMBIO_NA_DATA]
				   ,a.[COBRAR_MOEDA_PADRAO]
				   ,a.[DATA_FATURAMENTO_RELATIVO]
				   ,a.[RECARGO]
				   ,a.[DATA_PARA_TRANSFERENCIA]
				   ,a.[NOME_CLIFOR_ENTREGA]
				   ,a.[TABELA_PRECO_FRETE]
				   ,a.[VALOR_FRETE]
				   ,a.[NOME_CLIFOR_COBRANCA]
				   ,a.[OBS_TRANSPORTE]
				   ,a.[VALOR_ADICIONAL]
				   ,a.[EMPRESA]
				   ,a.[IPI_ADICIONAL]
				   ,a.[CTB_LANCAMENTO]
				   ,a.[CTB_ITEM]
				   ,a.[NUMERO_CONFERENCIA]
				   ,a.[ICMS_ISENTO]
				   ,a.[ICMS_OUTROS]
				   ,a.[RATEIO_FILIAL]
				   ,a.[RATEIO_CENTRO_CUSTO]
				   ,a.[NUMERO_CONFERENCIA_ITEM]
				   ,a.[FATURA_FILIAL]
				   ,a.[FATURA_NUMERO]
				   ,a.[FATURA_SERIE]
				   ,a.[AGRUPAMENTO_ITENS]
				   ,a.[COMISSAO_VALOR]
				   ,a.[COMISSAO_VALOR_GERENTE]
				   ,a.[DESCONTO_BRUTO_1]
				   ,a.[DESCONTO_BRUTO_2]
				   ,a.[DESCONTO_BRUTO_3]
				   ,a.[DESCONTO_BRUTO_4]
				   ,a.[DESCONTO_SOBRE_1]
				   ,a.[DESCONTO_SOBRE_2]
				   ,a.[DESCONTO_SOBRE_3]
				   ,a.[DESCONTO_SOBRE_4]
				   ,a.[MPADRAO_DESCONTO]
				   ,a.[MPADRAO_DESCONTO_COND_PGTO]
				   ,a.[MPADRAO_ENCARGO]
				   ,a.[MPADRAO_FRETE]
				   ,a.[MPADRAO_SEGURO]
				   ,a.[MPADRAO_VALOR_SUB_ITENS]
				   ,a.[MPADRAO_VALOR_TOTAL]
				   ,a.[MULTI_DESCONTO_ACUMULAR]
				   ,a.[PORC_DESCONTO]
				   ,a.[PORC_DESCONTO_BRUTO]
				   ,a.[PORC_DESCONTO_COND_PGTO]
				   ,a.[PORC_DESCONTO_DIGITADO]
				   ,a.[PORC_ENCARGO]
				   ,a.[VALOR_DIFERENCA_GUIA_FATURA]
				   ,a.[VALOR_SUB_ITENS]
				   ,a.[MPADRAO_IMPOSTO_AGREGAR]
				   ,a.[VALOR_IMPOSTO_AGREGAR]
				   ,a.[IMPRIMIR_ENDERECO_COBRANCA]
				   ,a.[INDICA_CONSUMIDOR_FINAL]
				   ,a.[BANCO]
				   ,a.[AGENCIA]
				   ,a.[RESPONSAVEL_TRANSPORTE]
				   ,a.[NOTA_COMPLEMENTAR]
				   ,a.[NUMERO_CONHECIMENTO_RELACIONADO]
				   ,a.[DESCONTO_SEFAZ]
				   ,a.[PORC_DESCONTO_SEFAZ]
				   ,a.[MPADRAO_DESCONTO_SEFAZ]
				   ,a.[ID_CAIXA_PGTO]
				   ,a.[NRO_DE]
				   ,a.[DATA_DE]
				   ,a.[NATUREZA_EXPORTACAO]
				   ,a.[NRO_RE]
				   ,a.[DATA_RE]
				   ,a.[NRO_CONHECIMENTO_EMBARQUE]
				   ,a.[DATA_CONHECIMENTO]
				   ,a.[TIPO_CONHECIMENTO]
				   ,a.[COD_PAIS]
				   ,a.[NRO_COMPROVANTE_EXPORTACAO]
				   ,a.[DATA_COMPROVANTE_EXPORTACAO]
				   ,a.[DATA_AVERBACAO]
				   ,a.[NF_EMITIDA_EXPORTADOR]
				   ,a.[COD_RELACIONAMENTO_RE_NF]
				   ,a.[NF_E_NUMERO]
				   ,a.[NF_E_DATA_EMISSAO]
				   ,a.[NF_E_COD_VERIFICACAO]
				   ,a.[NF_E_DATA_QUITACAO_GUIA]
				   ,a.[NF_E_GERACAO]
				   ,a.[SEQUENCIAL_UNICO]
				   ,a.[DATA_GERACAO_NSU]
				   ,a.[CODIGO_CLIENTE_VAREJO]
				   ,a.[CHAVE_NFE]
				   ,a.[PROTOCOLO_AUTORIZACAO_NFE]
				   ,a.[COD_MOTIVO_CANC]
				   ,a.[PIN]
				   ,a.[PROTOCOLO_CANCELAMENTO_NFE]
				   ,a.[DATA_AUTORIZACAO_NFE]
				   ,a.[GERAR_AUTOMATICO]
				   ,a.[STATUS_NFE]
				   ,a.[LOG_STATUS_NFE]
				   ,a.[MOTIVO_CANCELAMENTO_NFE]
				   ,a.[PRIORIZACAO]
				   ,a.[TIPO_EMISSAO_NFE]
				   ,a.[FIN_EMISSAO_NFE]
				   ,a.[REGISTRO_DPEC]
				   ,a.[DATA_REGISTRO_DPEC]
				   ,a.[ITEM_NFE]
				   ,a.[OBS_INTERESSE_FISCO]
				   ,a.[DATA_CONTINGENCIA]
				   ,a.[JUSTIFICATIVA_CONTINGENCIA]
				   ,a.[UF_EMBARQUE_EXPORTACAO]
				   ,a.[LOCAL_EMBARQUE_EXPORTACAO]
				   ,a.[CFOP_CANCELAMENTO]
				   ,a.[VALOR_DESPACHO]
				   ,a.[VALOR_IMPOSTO_INCIDENCIA]
				   ,a.[MPADRAO_VALOR_IMPOSTO_INCIDENCIA]
				   ,a.[VEICULO_PLACA]
				   ,a.[UF_PLACA_VEICULO]
				   ,a.[MARCA_VOLUMES]
				   ,a.[NUMERACAO_VOLUMES]
				   ,a.[INFORMACAO_COMPLEMENTAR]
				   ,a.[DATA_HORA_EMISSAO]
				   ,a.[INDICA_PRESENCA_COMPRADOR]
				   ,a.[LOCAL_DESPACHO_EXPORTACAO]
				   ,a.[UTC_DATA_AUTORIZACAO_NFE]
				   ,a.[UTC_DATA_SAIDA]
				   ,a.[UTC_EMISSAO]
				   ,a.[INDICA_ENDERECO_ENTREGA]
		from drlingerie.dbo.faturamento a
		join drlingerie.dbo.cadastro_cli_for b on b.nome_clifor=a.nome_clifor
		join filiais c on c.cgc_cpf=b.cgc_cpf
		join PARAMETROS_IMPORT_XML d on d.RATEIO_FILIAL=c.COD_FILIAL
		where serie_nf='56' and year(emissao)>=2017 and --tipo_faturamento='ORDENS DE SERVIÇO' AND 
		NOT EXISTS(SELECT * FROM TMP_FATURAMENTO_DR WHERE NF_SAIDA=A.NF_SAIDA AND SERIE_NF=A.SERIE_NF)
	end

	-- tabela auxiliar para trocar os caracteres retirados do produto pelo Linx
	begin
		INSERT INTO [dbo].[tmp_FATURAMENTO_ITEM_dr]
				   ([CLASSIF_FISCAL]
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
				   ,[MPADRAO_SEGURO_ITEM]
				   ,[MPADRAO_FRETE_ITEM]
				   ,[MPADRAO_ENCARGO_ITEM]
				   ,[RATEIO_FILIAL]
				   ,[RATEIO_CENTRO_CUSTO]
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

		SELECT 
					[CLASSIF_FISCAL]
				   ,a.[CODIGO_FISCAL_OPERACAO]
				   ,[CODIGO_ITEM]
				   ,[COD_TABELA_FILHA]
				   ,[COMISSAO_ITEM]
				   ,[COMISSAO_ITEM_GERENTE]
				   ,a.[CONTA_CONTABIL]
				   ,[DESCONTO_ITEM]
				   ,[DESCRICAO_ITEM]
				   ,[FAIXA]
				   ,a.[FILIAL]
				   ,[ID_EXCECAO_IMPOSTO]
				   ,[INDICADOR_CFOP]
				   ,[ITEM_IMPRESSAO]
				   ,[MPADRAO_DESCONTO_ITEM]
				   ,[MPADRAO_PRECO_UNITARIO]
				   ,[MPADRAO_VALOR_ITEM]
				   ,a.[NF_SAIDA]
				   ,[PESO]
				   ,[PORCENTAGEM_ITEM_RATEIO]
				   ,[PRECO_UNITARIO]
				   ,[QTDE_DEVOLVIDA]
				   ,[QTDE_ITEM]
				   ,[QTDE_RETORNAR_BENEFICIAMENTO]
				   ,a.[SERIE_NF]
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
				   ,a.[ITEM_NFE]
				   ,[MPADRAO_SEGURO_ITEM]
				   ,[MPADRAO_FRETE_ITEM]
				   ,[MPADRAO_ENCARGO_ITEM]
				   ,a.[RATEIO_FILIAL]
				   ,a.[RATEIO_CENTRO_CUSTO]
				   ,[ORIGEM_ITEM]
				   ,[VALOR_IMPOSTO_ITEM]
				   ,[INDICA_PRODUTO_PROCESSO]
				   ,[CODIGO_FCI]
				   ,[PRECO_UNITARIO_ORIGINAL]
				   ,[CTB_TIPO_OPERACAO]
				   ,[ID_SUB_PROJETO]
				   ,[VALOR_IMPOSTO_ITEM_MUNICIPAL]
				   ,[VALOR_IMPOSTO_ITEM_ESTADUAL]
				   ,[ID_CEST_NCM]
		from drlingerie.dbo.faturamento_item a
		join drlingerie.dbo.faturamento b on b.nf_saida=a.nf_saida and  b.serie_nf=a.serie_nf
		join drlingerie.dbo.cadastro_cli_for c on c.nome_clifor=b.nome_clifor
		join filiais d on d.cgc_cpf=c.cgc_cpf
		join parametros_import_xml e on e.RATEIO_FILIAL=d.COD_FILIAL
		where a.serie_nf='56' and year(emissao)>=2017 and --tipo_faturamento='ORDENS DE SERVIÇO' AND 
		NOT EXISTS(SELECT * FROM tmp_faturamento_item_dr WHERE NF_SAIDA=A.NF_SAIDA AND SERIE_NF=A.SERIE_NF)
	end

	-- produtos
	begin
		update a
		set a.conta_contabil=b.conta_contabil,a.indicador_cfop=b.indicador_cfop
		--select b.CONTA_CONTABIL,b.INDICADOR_CFOP,a.CONTA_CONTABIL,a.INDICADOR_CFOP,a.* 
		from produtos a
		join DRLINGERIE.dbo.produtos b on b.PRODUTO=a.produto
		where a.CONTA_CONTABIL is null or a.INDICADOR_CFOP is null
	end

	-- materiais
	begin
		update a
		set a.conta_contabil=b.conta_contabil,a.indicador_cfop=b.indicador_cfop
		--select b.CONTA_CONTABIL,b.INDICADOR_CFOP,a.CONTA_CONTABIL,a.INDICADOR_CFOP,a.* 
		from materiais a
		join DRLINGERIE.dbo.materiais b on b.material=a.material
		where a.CONTA_CONTABIL is null or a.INDICADOR_CFOP is null
	end

	-- item fiscal
	begin
		update a
		set a.conta_contabil=b.conta_contabil,a.indicador_cfop=b.indicador_cfop
		--select b.CONTA_CONTABIL,b.INDICADOR_CFOP,a.CONTA_CONTABIL,a.INDICADOR_CFOP,a.* 
		from cadastro_item_fiscal a
		join DRLINGERIE.dbo.cadastro_item_fiscal b on b.CODIGO_ITEM=a.CODIGO_ITEM
		where a.CONTA_CONTABIL is null or a.INDICADOR_CFOP is null
	end

	set ANSI_WARNINGS on
	SET NOCOUNT off
	
	ERROR: 

	WHILE @@TRANCOUNT > 0 
		IF @ERRMSG IS NOT NULL 
		  RAISERROR (@ERRMSG,16,1)     
end
GO



begin
-- EXECUTAR ANTES DE FAZER O PROCESSO DE IMPORTAÇÃO DO XML DA NFE
EXEC SP_INCLUI_CADASTROS_AUXILIARES_OFICINAS

select * from tmp_faturamento_dr
where nf_saida='0035564'

select * from drlingerie.dbo.faturamento
where nf_saida='0035562'


--- 
select * from xml_nfe_capa
Select * From sys.dm_db_missing_index_details

end