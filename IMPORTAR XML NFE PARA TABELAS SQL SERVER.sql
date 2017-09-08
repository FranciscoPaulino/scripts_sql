-- CAPA NFe
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\23160305989781000102550010000004071000020248-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
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
FROM OPENROWSET(BULK N'C:\TEMP\XML\23160305989781000102550010000004071000020248-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
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
FROM OPENROWSET(BULK N'C:\TEMP\XML\23160305989781000102550010000004071000020248-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
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
FROM OPENROWSET(BULK N'C:\TEMP\XML\23160305989781000102550010000004071000020248-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
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
FROM OPENROWSET(BULK N'C:\TEMP\XML\23160305989781000102550010000004071000020248-procNfe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
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


-----*********************************************-------------------------------------------
select * from XML_NFE_TOTAL
where chNFe='23160305989781000102550010000003991090000809'


-- tabelas auxiliares
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
 CONSTRAINT [XPK_XML_NFE_CAPA] PRIMARY KEY CLUSTERED 
(
	[chNFe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

CREATE TABLE [dbo].[XML_NFE_DUPLICATA](
	[chNFe] [varchar](44) NULL,
	[nFat] [char](10) NULL,
	[vOrig] [numeric](14, 2) NULL,
	[vLiq] [numeric](14, 2) NULL,
	[nDup] [char](10) NULL,
	[dVenc] [date] NULL,
	[vDup] [numeric](14, 2) NULL
) ON [PRIMARY]

GO

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

GO

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

GO

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

GO

-- exemplo geral
DECLARE @XML XML = '<EventSchedule>
    <Event Uid="2" Type="Main Event">
        <IsFixed>True</IsFixed>
        <EventKind>MainEvent</EventKind>
        <Fields>
            <Parameter Name="Type" Value="TV_Show"/>
            <Parameter Name="Name" Value="The Muppets"/>
            <Parameter Name="Duration" Value="00:30:00"/>
        </Fields>
    </Event>
    <Event Uid="3" Type="Secondary Event">
        <IsFixed>True</IsFixed>
        <EventKind>SecondaryEvent</EventKind>
        <Fields>
            <Parameter Name="Type" Value="TV_Show"/>
            <Parameter Name="Name" Value="The Muppets II"/>
            <Parameter Name="Duration" Value="00:30:00"/>
        </Fields>
    </Event>
</EventSchedule>'

SELECT
    EventUID = Events.value('@Uid', 'int'),
    EventType = Events.value('@Type', 'varchar(20)'),
    EventIsFixed =Events.value('(IsFixed)[1]', 'varchar(20)'),
    EventKind =Events.value('(EventKind)[1]', 'varchar(20)')
FROM
 @XML.nodes('/EventSchedule/Event') AS XTbl(Events)



--- entrada ordem de serviço
---
INSERT INTO ENTRADAS (NF_ENTRADA,NOME_CLIFOR,EMISSAO,FILIAL,EMPRESA,AGRUPAMENTO_ITENS,COD_TRANSACAO,NATUREZA,CONDICAO_PGTO,RECEBIMENTO,NF_FATURA,SERIE_NF_ENTRADA,TABELA_FILHA,TRANSF_FILIAL,TIPO_ENTRADAS,MOEDA,MOEDA_COMPRA,DATA_DIGITACAO,RATEIO_FILIAL,RATEIO_CENTRO_CUSTO,DATA_FATURAMENTO_RELATIVO,UTILIZA_DIAS_FIXOS_FORNECEDOR,NOME_CLIFOR_TRIANGULAR,SERIE_NF,NUMERO_ENTRADA,FATURA_NOME_CLIFOR,FATURA_SERIE,FATURA_NUMERO,DIFERENCA_VALOR,QTDE_TOTAL,VALOR_TOTAL,FRETE_A_PAGAR,IMPORTACAO_IMPOSTO,IMPORTACAO_ICMS,IMPORTACAO_IPI,IMPORTACAO_ALFANDEGA,IMPORTACAO_OUTRAS_DESPESAS,IMPORTACAO_FRETE,IMPORTACAO_SEGURO,IMPORTACAO_DESEMBARACO,PORC_DESCONTO,PORC_ENCARGO,COMISSAO_VALOR,COMISSAO_VALOR_GERENTE,VALOR_IMPOSTO_AGREGAR,VALOR_SUB_ITENS,CAMBIO_NA_DATA,ESPECIE_SERIE,NOTA_CANCELADA,COD_CLIFOR_SACADO,IMPORTACAO_TX_CAPATAZIA,CHAVE_NFE) 
SELECT REPLICATE(0, (7-LEN(RTRIM(A.nNF))))+RTRIM(A.nNF) AS NF_ENTRADA,C.NOME_CLIFOR,A.dhEmi,D.NOME_CLIFOR,1,1,'ENTRADAS_108','230.01         ','000',A.dhSaiEnt,0,A.serie,'ENTRADAS_NF       ',0,'BENEFICIAMENTO           ','R$    ','R$    ',GETDATE(),D.CLIFOR,'21             ',NULL,0,C.NOME_CLIFOR,NULL,NULL,NULL,NULL,NULL,0,10.000,100.00000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,100.00,1.000000,3,0,'600216',0,'23130207938560000130551020000000011756173353'
FROM XML_NFE_CAPA A
JOIN XML_NFE_TOTAL B ON B.chNFe=A.chNFe
JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR WHERE CLIFOR='600132') C ON C.CGC_CPF=A.emit_CNPJ
JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL FROM CADASTRO_CLI_FOR WHERE CLIFOR='601496') D ON D.CGC_CPF=A.dest_CNPJ

exec sp_executesql N'INSERT INTO ENTRADAS 
(NF_ENTRADA,NOME_CLIFOR,EMISSAO,FILIAL,EMPRESA,AGRUPAMENTO_ITENS,COD_TRANSACAO,NATUREZA,CONDICAO_PGTO,RECEBIMENTO,NF_FATURA,SERIE_NF_ENTRADA,TABELA_FILHA,TRANSF_FILIAL,TIPO_ENTRADAS,MOEDA,MOEDA_COMPRA,DATA_DIGITACAO,RATEIO_FILIAL,RATEIO_CENTRO_CUSTO,DATA_FATURAMENTO_RELATIVO,UTILIZA_DIAS_FIXOS_FORNECEDOR,NOME_CLIFOR_TRIANGULAR,SERIE_NF,NUMERO_ENTRADA,FATURA_NOME_CLIFOR,FATURA_SERIE,FATURA_NUMERO,DIFERENCA_VALOR,QTDE_TOTAL,VALOR_TOTAL,FRETE_A_PAGAR,IMPORTACAO_IMPOSTO,IMPORTACAO_ICMS,IMPORTACAO_IPI,IMPORTACAO_ALFANDEGA,IMPORTACAO_OUTRAS_DESPESAS,IMPORTACAO_FRETE,IMPORTACAO_SEGURO,IMPORTACAO_DESEMBARACO,PORC_DESCONTO,PORC_ENCARGO,COMISSAO_VALOR,COMISSAO_VALOR_GERENTE,VALOR_IMPOSTO_AGREGAR,VALOR_SUB_ITENS,CAMBIO_NA_DATA,ESPECIE_SERIE,NOTA_CANCELADA,COD_CLIFOR_SACADO,IMPORTACAO_TX_CAPATAZIA,CHAVE_NFE) 
VALUES (@P1 ,@P2 ,@P3 ,@P4 ,@P5 ,@P6 ,@P7 ,@P8 ,@P9 ,@P10 ,@P11 ,@P12 ,@P13 ,@P14 ,@P15 ,@P16 ,@P17 ,@P18 ,@P19 ,@P20 ,@P21 ,@P22 ,@P23 ,@P24 ,@P25 ,@P26 ,@P27 ,@P28 ,@P29 ,@P30 ,@P31 ,@P32 ,@P33 ,@P34 ,@P35 ,@P36 ,@P37 ,@P38 ,@P39 ,@P40 ,@P41 ,@P42 ,@P43 ,@P44 ,@P45 ,@P46 ,@P47 ,@P48 ,@P49 ,@P50 ,@P51 ,@P52 )',N'@P1 varchar(15),@P2 varchar(25),@P3 datetime,@P4 varchar(25),@P5 int,@P6 smallint,@P7 varchar(23),@P8 varchar(15),@P9 varchar(3),@P10 datetime,@P11 bit,@P12 varchar(6),@P13 varchar(18),@P14 bit,@P15 varchar(25),@P16 varchar(6),@P17 varchar(6),@P18 datetime,@P19 varchar(15),@P20 varchar(15),@P21 datetime,@P22 bit,@P23 varchar(25),@P24 varchar(3),@P25 int,@P26 varchar(25),@P27 varchar(6),@P28 varchar(15),@P29 bit,@P30 numeric(10,3),@P31 numeric(15,5),@P32 tinyint,@P33 numeric(14,2),@P34 numeric(14,2),@P35 numeric(14,2),@P36 numeric(14,2),@P37 numeric(14,2),@P38 numeric(14,2),@P39 numeric(14,2),@P40 numeric(14,2),@P41 numeric(13,10),@P42 numeric(13,10),@P43 numeric(14,2),@P44 numeric(14,2),@P45 numeric(14,2),@P46 numeric(14,2),@P47 numeric(15,6),@P48 int,@P49 bit,@P50 varchar(6),@P51 numeric(14,2),@P52 varchar(44)','452415         ','JULIETE                  ','2013-04-07 00:00:00','DR VAREJO                ',1,1,'ENTRADAS_108           ','240.01         ','000','2013-04-07 00:00:00',0,'1     ','ENTRADAS_NF       ',0,'BENEFICIAMENTO           ','R$    ','R$    ','2013-04-07 00:00:00','000001         ','31             ',NULL,0,'JULIETE                  ',NULL,NULL,NULL,NULL,NULL,0,10.000,100.00000,1,0,0,0,0,0,0,0,0,0,0,0,0,0,100.00,1.000000,3,0,'600216',0,'23130207938560000130551020000000011756173353'



SELECT * FROM  FILIAIS
WHERE COD_FILIAL='601496'

SELECT * FROM W_CTB_RATEIO_FILIAIS

SELECT * FROM XML_NFE_CAPA

SELECT * FROM ENTRADAS

exec sp_executesql N'INSERT INTO ENTRADAS_ITEM 
(NOME_CLIFOR,NF_ENTRADA,SERIE_NF_ENTRADA,ITEM_IMPRESSAO,SUB_ITEM_TAMANHO,DESCRICAO_ITEM,QTDE_ITEM,PRECO_UNITARIO,CODIGO_ITEM,DESCONTO_ITEM,VALOR_ITEM,COD_TABELA_FILHA,TRIBUT_ICMS,TRIBUT_ORIGEM,UNIDADE,CLASSIF_FISCAL,CODIGO_FISCAL_OPERACAO,PESO,CONTA_CONTABIL,QTDE_RETORNAR_BENEFICIAMENTO,FAIXA,COMISSAO_ITEM,COMISSAO_ITEM_GERENTE,INDICADOR_CFOP,QTDE_DEVOLVIDA,PORCENTAGEM_ITEM_RATEIO,ID_EXCECAO_IMPOSTO,REFERENCIA,REFERENCIA_ITEM,REFERENCIA_PEDIDO,TIMESTAMP,VALOR_ENCARGOS,VALOR_DESCONTOS,NAO_SOMA_VALOR,VALOR_ENCARGOS_IMPORTACAO,RATEIO_FILIAL,RATEIO_CENTRO_CUSTO,VALOR_ENCARGOS_ADUANEIROS,PORC_ITEM_RATEIO_FRETE,ITEM_NFE,MPADRAO_SEGURO_ITEM,MPADRAO_FRETE_ITEM,MPADRAO_ENCARGO_ITEM,ORIGEM_ITEM) 
VALUES (@P1 ,@P2 ,@P3 ,@P4 ,@P5 ,@P6 ,@P7 ,@P8 ,@P9 ,@P10 ,@P11 ,@P12 ,@P13 ,@P14 ,@P15 ,@P16 ,@P17 ,@P18 ,@P19 ,@P20 ,@P21 ,@P22 ,@P23 ,@P24 ,@P25 ,@P26 ,@P27 ,@P28 ,@P29 ,@P30 ,@P31 ,@P32 ,@P33 ,@P34 ,@P35 ,@P36 ,@P37 ,@P38 ,@P39 ,@P40 ,@P41 ,@P42 ,@P43 ,@P44 )',N'@P1 varchar(25),@P2 varchar(15),@P3 varchar(6),@P4 varchar(4),@P5 int,@P6 varchar(80),@P7 numeric(9,3),@P8 numeric(15,5),@P9 varchar(50),@P10 numeric(15,5),@P11 numeric(14,2),@P12 varchar(1),@P13 varchar(3),@P14 varchar(3),@P15 varchar(5),@P16 varchar(10),@P17 varchar(4),@P18 numeric(9,5),@P19 varchar(20),@P20 numeric(9,3),@P21 varchar(1),@P22 numeric(8,5),@P23 numeric(8,5),@P24 tinyint,@P25 numeric(9,3),@P26 numeric(13,10),@P27 int,@P28 varchar(50),@P29 varchar(12),@P30 varchar(12),@P31 varchar(25),@P32 numeric(14,2),@P33 numeric(14,2),@P34 bit,@P35 numeric(14,2),@P36 varchar(15),@P37 varchar(15),@P38 numeric(14,2),@P39 numeric(13,10),@P40 smallint,@P41 numeric(14,2),@P42 numeric(14,2),@P43 numeric(14,2),@P44 varchar(1)','JULIETE                  ','452415         ','1     ','0001',0,' BIQUINI FITINESS BRANCO                                                        ',10.000,10.00000,'51015BC0035                                       ',0,100.00,'R','90 ','0  ','PÇ   ','6108.2100 ','1902',0,NULL,0,'1',0,0,10,0,100.0000000000,743,'51015                                             ','BC0035      ',NULL,'ÆÆÆÆÆÆÆÆÆÆÆÆ31Ø11111     ',0,0,0,0,'000001         ','31             ',0,100.0000000000,1,0,0,0,'P'



exec sp_executesql N'INSERT INTO ENTRADAS_IMPOSTO (NOME_CLIFOR,NF_ENTRADA,SERIE_NF_ENTRADA,ITEM_IMPRESSAO,SUB_ITEM_TAMANHO,AGREGA_APOS_DESCONTO,TAXA_IMPOSTO,VALOR_IMPOSTO,BASE_IMPOSTO,TAXA_IMPOSTO_ESPELHO,VALOR_IMPOSTO_ESPELHO,BASE_IMPOSTO_ESPELHO,AGREGA_APOS_ENCARGO,ID_IMPOSTO,INCIDENCIA,TAXA_IMPOSTO_CALC,VALOR_IMPOSTO_CALC,BASE_IMPOSTO_CALC) VALUES (@P1 ,@P2 ,@P3 ,@P4 ,@P5 ,@P6 ,@P7 ,@P8 ,@P9 ,@P10 ,@P11 ,@P12 ,@P13 ,@P14 ,@P15 ,@P16 ,@P17 ,@P18 )',N'@P1 varchar(25),@P2 varchar(15),@P3 varchar(6),@P4 varchar(4),@P5 int,@P6 bit,@P7 numeric(8,5),@P8 numeric(14,2),@P9 numeric(14,2),@P10 numeric(8,5),@P11 numeric(14,2),@P12 numeric(14,2),@P13 bit,@P14 tinyint,@P15 tinyint,@P16 numeric(8,5),@P17 numeric(14,2),@P18 numeric(14,2)','JULIETE                  ','452415         ','1     ','0001',0,0,0,0,0,0,0,0,0,2,1,0,0,0


exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
   UPDATE ENTRADAS SET INFORMACAO_COMPLEMENTAR = '' IPI REDUZIDO A ZERO CONF. DECRETO 6.006 DE 28/12/2006.''  WHERE NF_ENTRADA = @P1 AND SERIE_NF_ENTRADA = @P2 AND NOME_CLIFOR = @P3 ',N'@P1 varchar(6),@P2 varchar(1),@P3 varchar(7)','452415','1','JULIETE'
   
   
exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
  EXEC LX_CTB_Integrar_Entrada @P1, @P2, @P3',N'@P1 varchar(7),@P2 varchar(6),@P3 varchar(1)','JULIETE','452415','1'
  
  
  
  exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  

  DELETE FROM ENTRADAS_OBSERVACAO WHERE NF_ENTRADA = @P1 AND SERIE_NF_ENTRADA = @P2 AND NOME_CLIFOR = @P3',N'@P1 varchar(6),@P2 varchar(1),@P3 varchar(7)','452415','1','JULIETE'

--- gera impostos 
EXEC LX_GERA_IMPOSTOS_ENTRADA ' D R LING','19519','56',1,1,1




---- IMPORTAÇÃO DE FATURAMENTO OFICINAS NO BANCO DRLINGERIE PARA BANCO DA OFICINA
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
AND A.FILIAL='LANÇADORA' and A.nf_saida='0000527' AND A.SERIE_NF='109'



SELECT [CLASSIF_FISCAL]
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
      ,[ID_CEST_NCM]
FROM FATURAMENTO_ITEM
where nf_saida='0000400' and serie_nf='1'


SELECT NCM,CFOP,CPROD,'O',0.00,0.00,'1140101',0.00,XPROD,1,'SIGMA','20','10', REPLICATE(0, (4-LEN(RTRIM(nItem))))+RTRIM(nItem) AS  nItem,
0.00,VUNTRIB,A.VPROD,'0000'+B.nNF,0.00,((A.QTRIB*A.VUNTRIB)/C.vProd)*100,A.VUNTRIB,0.00,A.QCOM,0.00,
B.SERIE,1,'41',0,A.UCOM,A.VPROD,A.CPROD,NULL,NULL,0.00,0.00,0,NULL,A.NITEM,NULL,'21',0.00,0.00,0.00,'P',0.00,'0',NULL,0.00,NULL,NULL,
0.00,0.00,NULL
FROM XML_NFE_ITEM A
JOIN XML_NFE_CAPA B ON B.CHNFE=A.CHNFE
JOIN XML_NFE_TOTAL C ON C.CHNFE=A.CHNFE
WHERE A.CHNFE='23160305989781000102550010000004001090000801'


SELECT * 
FROM XML_NFE_ITEM
WHERE CHNFE='23160305989781000102550010000004001090000801'


--- Faturamento
SELECT [FILIAL]
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
      ,[INDICA_ENDERECO_ENTREGA]
FROM FATURAMENTO A
WHERE NF_SAIDA='0000001' AND SERIE_NF='107'

--SELECT *
--FROM XML_NFE_CAPA A 
--JOIN XML_NFE_TOTAL B ON B.chNFe=A.chNFe
--WHERE A.chNFe='23160305989781000102550010000004071000020248'

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
'SIGMA',
'0000'+nNF,
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
'0000'+nNF,
'0000'+nNF,
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
'600224',
'8007',
null,
'SIGMA',
'0000'+nNF,
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
JOIN (SELECT CHNFE,QCOM = SUM(QCOM) FROM XML_NFE_ITEM WHERE chNFe='23160305989781000102550010000004071000020248' GROUP BY chNFe) D ON D.chNFe=A.chNFe
JOIN XML_NFE_TRANSPORTADOR E ON E.chNFe=A.chNFe 
WHERE A.chNFe='23160305989781000102550010000004071000020248'

SELECT * FROM FATURAMENTO
WHERE NF_SAIDA='0000407' AND SERIE_NF='1'

DELETE  FROM FATURAMENTO
WHERE NF_SAIDA='0000407' AND SERIE_NF='1'


SELECT * FROM FATURAMENTO_ITEM
WHERE NF_SAIDA='0000407' AND SERIE_NF='1'

UPDATE FATURAMENTO_ITEM
SET TRIBUT_ICMS='41'
WHERE NF_SAIDA='0000407' AND SERIE_NF='1'


UPDATE FATURAMENTO
SET TRANSPORTADORA='SEU TRANSPORTE',TRANSP_REDESPACHO='SEU TRANSPORTE'
WHERE NF_SAIDA='0000407' AND SERIE_NF='1'



--- EXCLUIR ITENS DA NFE ERRADA
SELECT * FROM FATURAMENTO_ITEM
WHERE NF_SAIDA='0000400' AND SERIE_NF='1'

BEGIN TRAN
DELETE FROM FATURAMENTO_ITEM
WHERE NF_SAIDA='0000404' AND SERIE_NF='1'
COMMIT

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

SELECT NCM,CFOP,CPROD,'C',0.00,0.00,'3110103',0.00,XPROD,1,'SIGMA','7','17', REPLICATE(0, (4-LEN(RTRIM(nItem))))+RTRIM(nItem) AS  nItem,
0.00,VUNTRIB,A.VPROD,'0000'+B.nNF,0.00,((A.QTRIB*A.VUNTRIB)/C.vProd)*100,A.VUNTRIB,0.00,A.QCOM,0.00,
B.SERIE,1,'41',0,A.UCOM,A.VPROD,A.CPROD,NULL,NULL,0.00,0.00,0,NULL,A.NITEM,NULL,'8007',0.00,0.00,0.00,'I',0.00,'0',NULL,0.00,NULL,NULL,
0.00,0.00,NULL
FROM XML_NFE_ITEM A
JOIN XML_NFE_CAPA B ON B.CHNFE=A.CHNFE
JOIN XML_NFE_TOTAL C ON C.CHNFE=A.CHNFE
WHERE A.CHNFE='23160305989781000102550010000004071000020248'


EXEC LX_GERA_IMPOSTOS_SAIDA  'SIGMA','0000407','1',1,1,1

EXEC LX_CTB_INTEGRAR_FATURAMENTO 'SIGMA','0000407','1'

SELECT * FROM LF_REGISTRO_SAIDA
WHERE NF_SAIDA='0000407' AND SERIE_NF='1'


EXECUTE LX_LF_INTEGRA_SAIDA 1, '20160331', '20160331', 
										'600224', 'I'

SELECT A.*  FROM   DBO.FATURAMENTO AS A (NOLOCK) 
           JOIN DBO.CADASTRO_CLI_FOR AS B (NOLOCK) 
             ON A.NOME_CLIFOR = B.NOME_CLIFOR 
           JOIN FILIAIS AS C 
             ON A.FILIAL = C.FILIAL 
           JOIN DBO.SERIES_NF AS D (NOLOCK) 
             ON A.SERIE_NF = D.SERIE_NF 
           JOIN DBO.CTB_ESPECIE_SERIE AS E (NOLOCK) 
             ON D.ESPECIE_SERIE = E.ESPECIE_SERIE 
           INNER JOIN DBO.CTB_LX_MODELO_DOCUMENTO_FISCAL AS MDF (NOLOCK) -- #6#      
                   ON E.NUMERO_MODELO_FISCAL = MDF.NUMERO_MODELO_FISCAL 
    WHERE  A.EMPRESA = 1 --AND TIPO_FATURAMENTO='VENDA DE SERVIÇO         '
           AND A.EMISSAO >= '20160331'
           AND A.EMISSAO <= '20160331'
           AND A.SERIE_NF <> 'E1'
           AND ( ( E.NUMERO_MODELO_FISCAL NOT IN ( '55', '65' ) ) /*#9#*/ 
                  OR ( E.NUMERO_MODELO_FISCAL IN ( '55', '65' ) /*#9#*/ 
                       AND A.STATUS_NFE IN ( 5, 6, 49, 50, 59, 70 ) ) ) 
           AND MDF.INDICA_DOCUMENTO_NAO_FISCAL = 0 /*#46#*/ 


    SELECT RTRIM(VALOR_ATUAL) 
    FROM   DBO.PARAMETROS (NOLOCK) 
    WHERE  PARAMETRO = 'TIPO_PRODUCAO'