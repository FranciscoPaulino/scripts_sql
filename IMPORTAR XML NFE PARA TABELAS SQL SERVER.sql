-- CAPA NFe
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\23161100119633000113550550000748531618035000.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
SELECT
       NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AS chNFe
,      NFe.value('nNF[1]', 'int') AS nNF
,      NFe.value('../emit[1]/CNPJ[1]','varchar(20)') AS CNPJ
,      NFe.value('../emit[1]/enderEmit[1]/xLgr[1]','varchar(max)') AS xLgr
,      NFe.value('../emit[1]/enderEmit[1]/nro[1]','varchar(50)') AS nro
,      NFe.value('../emit[1]/enderEmit[1]/xBairro[1]','varchar(max)') AS xBairro
FROM @XML.nodes('//infNFe/ide') AS NFes(NFe) -- Caminho que ira iniciar a varredura


-- ITENS NFE
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\23161100119633000113550550000748531618035000.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
SELECT
       NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AS chNFe
,      NFe.value('@nItem', 'int') AS nItem
,      NFe.value('prod[1]/cProd[1]','varchar(max)') AS cProd
,      NFe.value('prod[1]/cEAN[1]','varchar(max)') AS cEAN
,      NFe.value('prod[1]/xProd[1]','varchar(max)') AS xProd
,      NFe.value('prod[1]/NCM[1]','varchar(max)') AS NCM
,      NFe.value('prod[1]/CFOP[1]','varchar(max)') AS CFOP
,      NFe.value('prod[1]/uCom[1]','varchar(max)') AS uCom
,      NFe.value('prod[1]/qCom[1]','varchar(max)') AS qCom
,      NFe.value('prod[1]/vUnCom[1]','varchar(max)') AS vUnCom
,      NFe.value('prod[1]/vProd[1]','varchar(max)') AS vProd
,      NFe.value('prod[1]/cEANTrib[1]','varchar(max)') AS cEANTrib
,      NFe.value('prod[1]/uTrib[1]','varchar(max)') AS uTrib
,      NFe.value('prod[1]/qTrib[1]','varchar(max)') AS qTrib
,      NFe.value('prod[1]/vUnTrib[1]','varchar(max)') AS vUnTrib
,      NFe.value('prod[1]/indTot[1]','varchar(max)') AS indTot
       -- ICMS 
,      NFe.value('imposto[1]/ICMS[1]/ICMS00[1]/orig[1]','varchar(max)') AS ICMS_orig
,      NFe.value('imposto[1]/ICMS[1]/ICMS00[1]/CST[1]','varchar(max)') AS ICMS_CST
,      NFe.value('imposto[1]/ICMS[1]/ICMS00[1]/modBC[1]','varchar(max)') AS ICMS_modBC
,      NFe.value('imposto[1]/ICMS[1]/ICMS00[1]/vBC[1]','varchar(max)') AS ICMS_vBC
,      NFe.value('imposto[1]/ICMS[1]/ICMS00[1]/pICMS[1]','varchar(max)') AS ICMS_pICMS
,      NFe.value('imposto[1]/ICMS[1]/ICMS00[1]/vICMS[1]','varchar(max)') AS ICMS_vICMS
       -- IPI
,      NFe.value('imposto[1]/IPI[1]/cEnq[1]','varchar(max)') AS IPI_cEnq
,      NFe.value('imposto[1]/IPI[1]/IPITrib[1]/CST[1]','varchar(max)') AS IPI_CST
,      NFe.value('imposto[1]/IPI[1]/IPITrib[1]/vBC[1]','varchar(max)') AS IPI_vBC
,      NFe.value('imposto[1]/IPI[1]/IPITrib[1]/pIPI[1]','varchar(max)') AS IPI_pIPI
,      NFe.value('imposto[1]/IPI[1]/IPITrib[1]/vIPI[1]','varchar(max)') AS IPI_vIPI
       -- PIS
,      NFe.value('imposto[1]/PIS[1]/PISAliq[1]/CST[1]','varchar(max)') AS PIS_CST
,      NFe.value('imposto[1]/PIS[1]/PISAliq[1]/vBC[1]','varchar(max)') AS PIS_vBC
,      NFe.value('imposto[1]/PIS[1]/PISAliq[1]/pPIS[1]','varchar(max)') AS PIS_pPIS
,      NFe.value('imposto[1]/PIS[1]/PISAliq[1]/vPIS[1]','varchar(max)') AS PIS_vPIS
       -- COFINS
,      NFe.value('imposto[1]/COFINS[1]/COFINSAliq[1]/CST[1]','varchar(max)') AS COFINS_CST
,      NFe.value('imposto[1]/COFINS[1]/COFINSAliq[1]/vBC[1]','varchar(max)') AS COFINS_vBC
,      NFe.value('imposto[1]/COFINS[1]/COFINSAliq[1]/pCOFINS[1]','varchar(max)') AS COFINS_pCOFINS
,      NFe.value('imposto[1]/COFINS[1]/COFINSAliq[1]/vCOFINS[1]','varchar(max)') AS COFINS_vCOFINS

FROM @XML.nodes('//infNFe/det') AS NFes(NFe) -- Caminho que ira iniciar a varredura
order by nItem


-- TOTAL NFE
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\23161100119633000113550550000748531618035000.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
SELECT
       NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AS chNFe
,      NFe.value('ICMSTot[1]/vBC[1]','varchar(max)') AS vBC
,      NFe.value('ICMSTot[1]/vICMS[1]','varchar(max)') AS vICMS
,      NFe.value('ICMSTot[1]/vICMSDeson[1]','varchar(max)') AS vICMSDeson
,      NFe.value('ICMSTot[1]/vBCST[1]','varchar(max)') AS vBCST
,      NFe.value('ICMSTot[1]/vST[1]','varchar(max)') AS vST
,      NFe.value('ICMSTot[1]/vProd[1]','varchar(max)') AS vProd
,      NFe.value('ICMSTot[1]/vFrete[1]','varchar(max)') AS vFrete
,      NFe.value('ICMSTot[1]/vSeg[1]','varchar(max)') AS vSeg
,      NFe.value('ICMSTot[1]/vDesc[1]','varchar(max)') AS vDesc
,      NFe.value('ICMSTot[1]/vII[1]','varchar(max)') AS vII
,      NFe.value('ICMSTot[1]/vIPI[1]','varchar(max)') AS vIPI
,      NFe.value('ICMSTot[1]/vPIS[1]','varchar(max)') AS vPIS
,      NFe.value('ICMSTot[1]/vCOFINS[1]','varchar(max)') AS vCOFINS
,      NFe.value('ICMSTot[1]/vOutro[1]','varchar(max)') AS vOutro
,      NFe.value('ICMSTot[1]/vNF[1]','varchar(max)') AS vNF
,      NFe.value('../cobr[1]/fat[1]/nFat[1]','varchar(max)') AS nFat
,      NFe.value('../cobr[1]/fat[1]/vOrig[1]','varchar(max)') AS vOrig
,      NFe.value('../cobr[1]/fat[1]/vLiq[1]','varchar(max)') AS vLiq
FROM @XML.nodes('//infNFe/total') AS NFes(NFe) -- Caminho que ira iniciar a varredura


-- Transportadora NFE
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\23161100119633000113550550000748531618035000.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
SELECT
       NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AS chNFe
,      NFe.value('modFrete[1]','varchar(max)') AS modFrete
,      NFe.value('transporta[1]/CNPJ[1]','varchar(max)') AS CNPJ
,      NFe.value('transporta[1]/xNome[1]','varchar(max)') AS xNome
,      NFe.value('transporta[1]/IE[1]','varchar(max)') AS IE
,      NFe.value('transporta[1]/xEnder[1]','varchar(max)') AS xEnder
,      NFe.value('transporta[1]/xMun[1]','varchar(max)') AS xMun
,      NFe.value('transporta[1]/UF[1]','varchar(max)') AS UF
,      NFe.value('vol[1]/qVol[1]','varchar(max)') AS qVol
,      NFe.value('vol[1]/esp[1]','varchar(max)') AS esp
,      NFe.value('vol[1]/pesoL[1]','varchar(max)') AS pesoL
,      NFe.value('vol[1]/pesoB[1]','varchar(max)') AS pesoB
FROM @XML.nodes('//infNFe/transp') AS NFes(NFe) -- Caminho que ira iniciar a varredura



-- Duplicatas NFE
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\23161100119633000113550550000748531618035000.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)

;WITH XMLNAMESPACES(DEFAULT 'http://www.portalfiscal.inf.br/nfe') -- Este ponto deve ser informado o NAMESPACE (xmlns), senão informar esta linha ele não retorna.
SELECT
       NFe.value('../../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') AS chNFe
,      NFe.value('nDup[1]','varchar(max)') AS nDup
,      NFe.value('dVenc[1]','varchar(max)') AS dVenc
,      NFe.value('vDup[1]','varchar(max)') AS vDup
FROM @XML.nodes('//infNFe/cobr/dup') AS NFes(NFe) -- Caminho que ira iniciar a varredura

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
