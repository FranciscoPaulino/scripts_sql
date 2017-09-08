-- CAPA NFe
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\23151222562645000150550010000000111760506789-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.

INSERT INTO XML_NFE_CAPA (chNFe,nProt,dhRecbto,cUF,cNF,natOp,indPag,mod,serie,nNF,dhEmi,dhSaiEnt,tpNF,idDest,cMunFG,tpImp,
tpEmis,cDV,tpAmb,finNFe,indFinal,indPres,procEmi,emit_CNPJ,emit_xNome,emit_xFant,emit_xLgr,emit_nro,emit_xBairro,emit_cMun,
emit_xMun,emit_UF,emit_CEP,emit_cPais,emit_xPais,emit_fone,emit_IE,emit_CRT,dest_CNPJ,dest_xNome,dest_xLgr,dest_nro,dest_xBairro,
dest_cMun,dest_xMun,dest_UF,dest_CEP,dest_cPais,dest_xPais,dest_fone,dest_indIEDest,dest_IE,dest_email)

SELECT
    NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') as chNFe
,	NFe.value('../../../protNFe[1]/infProt[1]/nProt[1]', 'varchar(20)') as nProt
,	NFe.value('../../../protNFe[1]/infProt[1]/dhRecbto[1]', 'datetime') as dhRecbto
,	NFe.value('cUF[1]', 'char(2)') as cUF
,	NFe.value('cNF[1]', 'char(10)') AS cNF
,	NFe.value('natOp[1]','varchar(max)') as natOp
,	NFe.value('indPag[1]', 'int') as indPag
,	NFe.value('mod[1]', 'int') as mod
,	NFe.value('serie[1]','int') as serie
,	NFe.value('nNF[1]','char(10)') as nNF
,	NFe.value('dhEmi[1]','datetime') as dhEmi
,	NFe.value('dhSaiEnt[1]','datetime') as dhSaiEnt
,	NFe.value('tpNF[1]','int') as tpNF
,	NFe.value('idDest[1]','int') as idDest
,	NFe.value('cMunFG[1]','int') as cMunFG
,	NFe.value('tpImp[1]','int') as tpImp
,	NFe.value('tpEmis[1]','int') as tpEmis
,	NFe.value('cDV[1]','int') as cDV
,	NFe.value('tpAmb[1]','int') as tpAmb
,	NFe.value('finNFe[1]','int') as finNFe
,	NFe.value('indFinal[1]','int') as indFinal
,	NFe.value('indPres[1]','int') as indPres
,	NFe.value('procEmi[1]','int') as procEmi
,	NFe.value('../emit[1]/CNPJ[1]','varchar(20)') as emit_CNPJ
,	NFe.value('../emit[1]/xNome[1]','varchar(80)') as emit_xNome
,	NFe.value('../emit[1]/xFant[1]','varchar(30)') as emit_xFant
,	NFe.value('../emit[1]/enderEmit[1]/xLgr[1]','varchar(max)') as emit_xLgr
,	NFe.value('../emit[1]/enderEmit[1]/nro[1]','varchar(50)') as emit_nro
,	NFe.value('../emit[1]/enderEmit[1]/xBairro[1]','varchar(max)') as emit_xBairro
,	NFe.value('../emit[1]/enderEmit[1]/cMun[1]','int') as emit_cMun
,	NFe.value('../emit[1]/enderEmit[1]/xMun[1]','varchar(50)') as emit_xMun
,	NFe.value('../emit[1]/enderEmit[1]/UF[1]','char(2)') as emit_UF
,	NFe.value('../emit[1]/enderEmit[1]/CEP[1]','char(10)') as emit_CEP
,	NFe.value('../emit[1]/enderEmit[1]/cPais[1]','char(6)') as emit_cPais
,	NFe.value('../emit[1]/enderEmit[1]/xPais[1]','char(20)') as emit_xPais
,	NFe.value('../emit[1]/enderEmit[1]/fone[1]','char(20)') as emit_fone
,	NFe.value('../emit[1]/IE[1]','char(20)') as emit_IE
,	NFe.value('../emit[1]/CRT[1]','int') as emit_CRT
,	NFe.value('../dest[1]/CNPJ[1]','varchar(20)') as dest_CNPJ
,	NFe.value('../dest[1]/xNome[1]','varchar(80)') as dest_xNome
,	NFe.value('../dest[1]/enderDest[1]/xLgr[1]','varchar(max)') as dest_xLgr
,	NFe.value('../dest[1]/enderDest[1]/nro[1]','varchar(50)') as dest_nro
,	NFe.value('../dest[1]/enderDest[1]/xBairro[1]','varchar(max)') as dest_xBairro
,	NFe.value('../dest[1]/enderDest[1]/cMun[1]','int') as dest_cMun
,	NFe.value('../dest[1]/enderDest[1]/xMun[1]','varchar(50)') as dest_xMun
,	NFe.value('../dest[1]/enderDest[1]/UF[1]','char(2)') as dest_UF
,	NFe.value('../dest[1]/enderDest[1]/CEP[1]','char(10)') as dest_CEP
,	NFe.value('../dest[1]/enderDest[1]/cPais[1]','char(6)') as dest_cPais
,	NFe.value('../dest[1]/enderDest[1]/xPais[1]','char(20)') as dest_xPais
,	NFe.value('../dest[1]/enderDest[1]/fone[1]','char(20)') as dest_fone
,	NFe.value('../dest[1]/indIEDest[1]','int') as indIEDest
,	NFe.value('../dest[1]/IE[1]','char(20)') as dest_IE
,	NFe.value('../dest[1]/email[1]','varchar(80)') as dest_email
FROM @XML.nodes('//infNFe/ide') AS NFes(NFe) -- Caminho que ira iniciar a varredura

-- ITENS NFE
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\23151222562645000150550010000000111760506789-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

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
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\23151222562645000150550010000000111760506789-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

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
--,      NFe.value('../cobr[1]/fat[1]/nFat[1]','numeric(14,2)') AS nFat
--,      NFe.value('../cobr[1]/fat[1]/vOrig[1]','numeric(14,2)') AS vOrig
--,      NFe.value('../cobr[1]/fat[1]/vLiq[1]','numeric(14,2)') AS vLiq
FROM @XML.nodes('//infNFe/total') AS NFes(NFe) -- Caminho que ira iniciar a varredura


-- Transportadora NFE
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\23151222562645000150550010000000111760506789-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

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
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\23151222562645000150550010000000091760506780-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

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

--- SERVIÇOS
--- cabeçalho
INSERT INTO FATURAMENTO (
       [FILIAL]
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

SELECT 
'VM CONFECCOES            ',
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF),
serie,
null,
null,
'VENDA DE SERVIÇO',
null,
B.NOME_CLIFOR,
'000',
'101.01',
'SEU TRANSPORTE',
'SEU TRANSPORTE',
'01',
'FATURAMENTO_023',
convert(date,A.dhEmi,103),
convert(date,A.dhEmi,103),
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
C.vNF,
D.QCOM,
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF),
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF),
0,
0,
'FATURAMENTO_ITEM',
NULL,
0,
0,
1,
'VOLUME',
'0',
null,
0,
0.00,
0,
0,
0,
'FABRICA',
0.00,
0.00,
'FABRICA',
0.00,
0.00,
null,
null,
null,
null,
0.00,
null,
null,
0.00,
0,
'R$',
1.0000,
1,
null,
0.00,
getdate(),
null,
null,
0.00,
null,
null,
null,
1,
null,
null,
1,
null,
0.00,
0.00,
'000023',
'8007',
null,
'VM CONFECCOES            ',
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF) AS NF_SAIDA,
SERIE,
0,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
c.VNF,
C.VNF,
0,
0.00,
0.00,
0.00,
0,
0.00,
0.00,
C.VNF,
0.00,
0.00,
0,
0,
NULL,
NULL,
NULL,
0,
NULL,
0.00000,
0.00,
0.00,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
'1052',
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
A.chNFe,
A.nProt,
NULL,
convert(date,A.dhEmi,103),
0,
5,
0,
NULL,
0,
0,
0,
'19000101',
1,
1,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
0.00,
0.00,
NULL,
NULL,
NULL,
NULL,
NULL,
convert(date,A.dhEmi,103),
0,
NULL,
3,
3,
3,
0
FROM XML_NFE_CAPA A
JOIN CADASTRO_CLI_FOR B ON B.CGC_CPF=A.dest_CNPJ AND B.CLIFOR='600132'
JOIN XML_NFE_TOTAL C ON C.chNFe=A.chNFe
JOIN (SELECT CHNFE,QCOM = SUM(QCOM) FROM XML_NFE_ITEM WHERE chNFe='23151122562645000150550010000000031760506783' GROUP BY chNFe) D ON D.chNFe=A.chNFe
JOIN XML_NFE_TRANSPORTADOR E ON E.chNFe=A.chNFe 
WHERE A.chNFe='23151122562645000150550010000000031760506783'

--- itens
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

SELECT '00000000',CFOP,CPROD,'C',0.00,0.00,'3110103',0.00,XPROD,1,'VM CONFECCOES            ','19','17', REPLICATE(0, (4-LEN(RTRIM(nItem))))+RTRIM(nItem) AS  nItem,
0.00,VUNTRIB,A.VPROD,REPLICATE(0, (9-LEN(RTRIM(B.nNF))))+RTRIM(B.nNF),0.00,((A.QTRIB*A.VUNTRIB)/C.vProd)*100,A.VUNTRIB,0.00,A.QCOM,0.00,
B.SERIE,1,'41',0,A.UCOM,A.VPROD,A.CPROD,NULL,NULL,0.00,0.00,0,NULL,A.NITEM,NULL,'8007',0.00,0.00,0.00,'I',0.00,'0',NULL,0.00,NULL,NULL,
0.00,0.00,NULL
FROM XML_NFE_ITEM A
JOIN XML_NFE_CAPA B ON B.CHNFE=A.CHNFE
JOIN XML_NFE_TOTAL C ON C.CHNFE=A.CHNFE
WHERE A.CHNFE='23151122562645000150550010000000031760506783'


--- RETORNO BENEFICIAMENTO
--- cabeçalho
INSERT INTO FATURAMENTO (
       [FILIAL]
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

SELECT 
'VM CONFECCOES            ',
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF),
serie,
null,
null,
'ORDENS DE SERVIÇO',
null,
B.NOME_CLIFOR,
'000',
'121.01',
'SEU TRANSPORTE',
'SEU TRANSPORTE',
'01',
'FATURAMENTO_028',
convert(date,A.dhEmi,103),
convert(date,A.dhEmi,103),
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
C.vNF,
D.QCOM,
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF),
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF),
0,
0,
'ESTOQUE_SAI1_MAT',
NULL,
0,
0,
1,
'VOLUME',
'0',
null,
0,
0.00,
0,
0,
0,
'FABRICA',
0.00,
0.00,
'FABRICA',
0.00,
0.00,
null,
null,
null,
null,
0.00,
null,
null,
0.00,
0,
'R$',
1.0000,
1,
null,
0.00,
getdate(),
null,
null,
0.00,
null,
null,
null,
1,
null,
null,
1,
null,
0.00,
0.00,
'000023',
'8007',
null,
'VM CONFECCOES            ',
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF) AS NF_SAIDA,
SERIE,
0,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
0.00,
c.VNF,
C.VNF,
0,
0.00,
0.00,
0.00,
0,
0.00,
0.00,
C.VNF,
0.00,
0.00,
0,
0,
NULL,
NULL,
NULL,
0,
NULL,
0.00000,
0.00,
0.00,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
'1052',
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
A.chNFe,
A.nProt,
NULL,
convert(date,A.dhEmi,103),
0,
5,
0,
NULL,
0,
0,
0,
'19000101',
1,
1,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
NULL,
0.00,
0.00,
NULL,
NULL,
NULL,
NULL,
NULL,
convert(date,A.dhEmi,103),
0,
NULL,
3,
3,
3,
0
FROM XML_NFE_CAPA A
JOIN CADASTRO_CLI_FOR B ON B.CGC_CPF=A.dest_CNPJ AND B.CLIFOR='600132'
JOIN XML_NFE_TOTAL C ON C.chNFe=A.chNFe
JOIN (SELECT CHNFE,QCOM = SUM(QCOM) FROM XML_NFE_ITEM WHERE chNFe='23151222562645000150550010000000101760506781' GROUP BY chNFe) D ON D.chNFe=A.chNFe
JOIN XML_NFE_TRANSPORTADOR E ON E.chNFe=A.chNFe 
WHERE A.chNFe='23151222562645000150550010000000101760506781'

--- itens
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

SELECT '00000000',CFOP,CPROD,'C',0.00,0.00,'3110103',0.00,XPROD,1,'VM CONFECCOES            ','17','10', REPLICATE(0, (4-LEN(RTRIM(nItem))))+RTRIM(nItem) AS  nItem,
0.00,VUNTRIB,A.VPROD,REPLICATE(0, (9-LEN(RTRIM(B.nNF))))+RTRIM(B.nNF),0.00,((A.QTRIB*A.VUNTRIB)/C.vProd)*100,A.VUNTRIB,0.00,A.QCOM,0.00,
B.SERIE,1,'41',0,A.UCOM,A.VPROD,A.CPROD,NULL,NULL,0.00,0.00,0,NULL,A.NITEM,NULL,'8007',0.00,0.00,0.00,'I',0.00,'0',NULL,0.00,NULL,NULL,
0.00,0.00,NULL
FROM XML_NFE_ITEM A
JOIN XML_NFE_CAPA B ON B.CHNFE=A.CHNFE
JOIN XML_NFE_TOTAL C ON C.CHNFE=A.CHNFE
WHERE A.CHNFE='23151222562645000150550010000000101760506781'


--- RETORNO DE REMESSA EM COMODATO
--- cabeçalho
INSERT INTO FATURAMENTO (       [FILIAL]      ,[NF_SAIDA]      ,[SERIE_NF]      ,[CODIGO_LOCAL_ENTREGA]
      ,[FILIAL_FATURADA]      ,[TIPO_FATURAMENTO]      ,[LANCAMENTO]      ,[NOME_CLIFOR]      ,[CONDICAO_PGTO]
      ,[NATUREZA_SAIDA]      ,[TRANSPORTADORA]      ,[TRANSP_REDESPACHO]      ,[TIPO_FRETE]      ,[COD_TRANSACAO]
      ,[EMISSAO]      ,[DATA_SAIDA]      ,[FRETE]      ,[SEGURO]      ,[DESCONTO]      ,[DESCONTO_COND_PGTO]
      ,[ENCARGO]      ,[ICMS]      ,[IPI_VALOR]      ,[VALOR_TOTAL]      ,[QTDE_TOTAL]      ,[NF_FATURA]
      ,[FATURA]      ,[NOTA_IMPRESSA]      ,[ACERTO_CONTAS_P_R]      ,[TABELA_FILHA]      ,[OBS]
      ,[PESO_LIQUIDO]      ,[PESO_BRUTO]      ,[VOLUMES]      ,[TIPO_VOLUME]      ,[CONFERIDO]      ,[CONFERIDO_POR]
      ,[ENTREGA_CIF]      ,[IRRF]      ,[IRRF_RET_FONTE]      ,[NOTA_CANCELADA]      ,[DEVOLUCAO]      ,[REPRESENTANTE]
      ,[COMISSAO]      ,[PORCENTAGEM_ACERTO]      ,[GERENTE]      ,[COMISSAO_GERENTE]      ,[DESCONTO_BRUTO]
      ,[CONFERENCIA]      ,[MARCA_EXPORTACAO]      ,[ATUALIZACAO_EXPORTAR]      ,[DATA_EXPORTACAO]      ,[ICMS_BASE]
      ,[STATUS_TRANSITO]      ,[DATA_CANCELAMENTO]      ,[VALOR_CANCELADO]      ,[QTDE_CANCELADA]      ,[MOEDA]
      ,[CAMBIO_NA_DATA]      ,[COBRAR_MOEDA_PADRAO]      ,[DATA_FATURAMENTO_RELATIVO]      ,[RECARGO]      ,[DATA_PARA_TRANSFERENCIA]
      ,[NOME_CLIFOR_ENTREGA]      ,[TABELA_PRECO_FRETE]      ,[VALOR_FRETE]      ,[NOME_CLIFOR_COBRANCA]      ,[OBS_TRANSPORTE]
      ,[VALOR_ADICIONAL]      ,[EMPRESA]      ,[IPI_ADICIONAL]      ,[CTB_LANCAMENTO]      ,[CTB_ITEM]      ,[NUMERO_CONFERENCIA]
      ,[ICMS_ISENTO]      ,[ICMS_OUTROS]      ,[RATEIO_FILIAL]      ,[RATEIO_CENTRO_CUSTO]      ,[NUMERO_CONFERENCIA_ITEM]
      ,[FATURA_FILIAL]      ,[FATURA_NUMERO]      ,[FATURA_SERIE]      ,[AGRUPAMENTO_ITENS]      ,[COMISSAO_VALOR]
      ,[COMISSAO_VALOR_GERENTE]      ,[DESCONTO_BRUTO_1]      ,[DESCONTO_BRUTO_2]      ,[DESCONTO_BRUTO_3]
      ,[DESCONTO_BRUTO_4]      ,[DESCONTO_SOBRE_1]      ,[DESCONTO_SOBRE_2]      ,[DESCONTO_SOBRE_3]      ,[DESCONTO_SOBRE_4]
      ,[MPADRAO_DESCONTO]      ,[MPADRAO_DESCONTO_COND_PGTO]      ,[MPADRAO_ENCARGO]      ,[MPADRAO_FRETE]      ,[MPADRAO_SEGURO]
      ,[MPADRAO_VALOR_SUB_ITENS]      ,[MPADRAO_VALOR_TOTAL]      ,[MULTI_DESCONTO_ACUMULAR]      ,[PORC_DESCONTO]
      ,[PORC_DESCONTO_BRUTO]      ,[PORC_DESCONTO_COND_PGTO]      ,[PORC_DESCONTO_DIGITADO]      ,[PORC_ENCARGO]
      ,[VALOR_DIFERENCA_GUIA_FATURA]      ,[VALOR_SUB_ITENS]      ,[MPADRAO_IMPOSTO_AGREGAR]      ,[VALOR_IMPOSTO_AGREGAR]
      ,[IMPRIMIR_ENDERECO_COBRANCA]      ,[INDICA_CONSUMIDOR_FINAL]      ,[BANCO]      ,[AGENCIA]      ,[RESPONSAVEL_TRANSPORTE]
      ,[NOTA_COMPLEMENTAR]      ,[NUMERO_CONHECIMENTO_RELACIONADO]      ,[PORC_DESCONTO_SEFAZ]      ,[DESCONTO_SEFAZ]
      ,[MPADRAO_DESCONTO_SEFAZ]      ,[ID_CAIXA_PGTO]      ,[NRO_DE]      ,[DATA_DE]      ,[NATUREZA_EXPORTACAO]
      ,[NRO_RE]      ,[DATA_RE]      ,[NRO_CONHECIMENTO_EMBARQUE]      ,[DATA_CONHECIMENTO]      ,[TIPO_CONHECIMENTO]
      ,[COD_PAIS]      ,[NRO_COMPROVANTE_EXPORTACAO]      ,[DATA_COMPROVANTE_EXPORTACAO]      ,[DATA_AVERBACAO]
      ,[NF_EMITIDA_EXPORTADOR]      ,[COD_RELACIONAMENTO_RE_NF]      ,[NF_E_NUMERO]      ,[NF_E_DATA_EMISSAO]
      ,[NF_E_COD_VERIFICACAO]      ,[NF_E_DATA_QUITACAO_GUIA]      ,[NF_E_GERACAO]      ,[SEQUENCIAL_UNICO]
      ,[DATA_GERACAO_NSU]      ,[CODIGO_CLIENTE_VAREJO]      ,[PIN]      ,[CHAVE_NFE]      ,[PROTOCOLO_AUTORIZACAO_NFE]
      ,[PROTOCOLO_CANCELAMENTO_NFE]      ,[DATA_AUTORIZACAO_NFE]      ,[GERAR_AUTOMATICO]      ,[STATUS_NFE]
      ,[LOG_STATUS_NFE]      ,[MOTIVO_CANCELAMENTO_NFE]      ,[ITEM_NFE]      ,[PRIORIZACAO]      ,[REGISTRO_DPEC]
      ,[DATA_REGISTRO_DPEC]      ,[TIPO_EMISSAO_NFE]      ,[FIN_EMISSAO_NFE]      ,[COD_MOTIVO_CANC]      ,[VALOR_DESPACHO]
      ,[OBS_INTERESSE_FISCO]      ,[DATA_CONTINGENCIA]      ,[JUSTIFICATIVA_CONTINGENCIA]      ,[UF_EMBARQUE_EXPORTACAO]
      ,[LOCAL_EMBARQUE_EXPORTACAO]      ,[CFOP_CANCELAMENTO]      ,[VALOR_IMPOSTO_INCIDENCIA]      ,[MPADRAO_VALOR_IMPOSTO_INCIDENCIA]
      ,[VEICULO_PLACA]      ,[UF_PLACA_VEICULO]      ,[MARCA_VOLUMES]      ,[NUMERACAO_VOLUMES]      ,[INFORMACAO_COMPLEMENTAR]
      ,[DATA_HORA_EMISSAO]      ,[INDICA_PRESENCA_COMPRADOR]      ,[LOCAL_DESPACHO_EXPORTACAO]      ,[UTC_DATA_AUTORIZACAO_NFE]
      ,[UTC_DATA_SAIDA]      ,[UTC_EMISSAO]      ,[INDICA_ENDERECO_ENTREGA])
SELECT 'VM CONFECCOES            ',REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF),serie,null,null,'COMODATO',
null,B.NOME_CLIFOR,'000','149.01','SEU TRANSPORTE','SEU TRANSPORTE','01','FATURAMENTO_023',convert(date,A.dhEmi,103),
convert(date,A.dhEmi,103),0.00,0.00,0.00,0.00,0.00,0.00,0.00,C.vNF,D.QCOM,REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF),
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF),0,0,'FATURAMENTO_ITEM',NULL,0,0,1,'VOLUME','0',null,0,0.00,
0,0,0,'FABRICA',0.00,0.00,'FABRICA',0.00,0.00,null,null,null,null,0.00,null,null,0.00,0,'R$',1.0000,1,null,
0.00,getdate(),null,null,0.00,null,null,null,1,null,null,1,null,0.00,0.00,'000023','8007',null,'VM CONFECCOES            ',
REPLICATE(0, (9-LEN(RTRIM(nNF))))+RTRIM(nNF) AS NF_SAIDA,SERIE,0,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,0.00,
0.00,0.00,0.00,0.00,0.00,0.00,c.VNF,C.VNF,0,0.00,0.00,0.00,0,0.00,0.00,C.VNF,0.00,0.00,0,0,NULL,NULL,NULL,0,
NULL,0.00000,0.00,0.00,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'1052',NULL,NULL,NULL,NULL,NULL,NULL,NULL,
NULL,NULL,NULL,NULL,NULL,NULL,NULL,A.chNFe,A.nProt,NULL,convert(date,A.dhEmi,103),0,5,0,NULL,0,0,0,'19000101',
1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0.00,NULL,NULL,NULL,NULL,NULL,convert(date,A.dhEmi,103),
0,NULL,3,3,3,0
FROM XML_NFE_CAPA A
JOIN CADASTRO_CLI_FOR B ON B.CGC_CPF=A.dest_CNPJ AND B.CLIFOR='600132'
JOIN XML_NFE_TOTAL C ON C.chNFe=A.chNFe
JOIN (SELECT CHNFE,QCOM = SUM(QCOM) FROM XML_NFE_ITEM WHERE chNFe='23151222562645000150550010000000111760506789' GROUP BY chNFe) D ON D.chNFe=A.chNFe
JOIN XML_NFE_TRANSPORTADOR E ON E.chNFe=A.chNFe 
WHERE A.chNFe='23151222562645000150550010000000111760506789'

--- itens
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

SELECT '00000000',CFOP,CPROD,'C',0.00,0.00,'3110103',0.00,XPROD,1,'VM CONFECCOES            ','17','20', REPLICATE(0, (4-LEN(RTRIM(nItem))))+RTRIM(nItem) AS  nItem,
0.00,VUNTRIB,A.VPROD,REPLICATE(0, (9-LEN(RTRIM(B.nNF))))+RTRIM(B.nNF),0.00,((A.QTRIB*A.VUNTRIB)/C.vProd)*100,A.VUNTRIB,0.00,A.QCOM,0.00,
B.SERIE,1,'41',0,A.UCOM,A.VPROD,A.CPROD,NULL,NULL,0.00,0.00,0,NULL,A.NITEM,NULL,'8007',0.00,0.00,0.00,'I',0.00,'0',NULL,0.00,NULL,NULL,
0.00,0.00,NULL
FROM XML_NFE_ITEM A
JOIN XML_NFE_CAPA B ON B.CHNFE=A.CHNFE
JOIN XML_NFE_TOTAL C ON C.CHNFE=A.CHNFE
WHERE A.CHNFE='23151222562645000150550010000000111760506789'


ALTER TABLE FATURAMENTO_ITEM ALTER COLUMN DESCRICAO_ITEM VARCHAR(MAX)

EXEC LX_GERA_IMPOSTOS_SAIDA  'VM CONFECCOES            ','000000011','1',1,1,1

EXEC LX_CTB_INTEGRAR_FATURAMENTO 'VM CONFECCOES            ','000000011','1'

DELETE FROM FATURAMENTO
WHERE NF_SAIDA='000000006'


