select * from faturamento
where EMISSAO between '20170201' and '20170228' and NOME_CLIFOR like 'D ANJOU INTIMA' and TIPO_FATURAMENTO='ORDENS DE SERVIÇO'
order by NF_SAIDA

select from ENTRADAS
where DATA_DIGITACAO = '20170307'

select * from ENTRADAS_ITEM
where NF_ENTRADA='0031124        '

--where DATA_DIGITACAO = '20170217' and tipo_entradas='BENEFICIAMENTO' and natureza='230.01'

SELECT * from ENTRADAS_ITEM
WHERE NF_ENTRADA like '%0031124%' -- ORIGEM_ITEM IS NULL

select * From DRLINGERIE.DBO.produtos 
where produto='51309-K5'

SELECT * FROM PRODUTOS_BARRA
WHERE PRODUTO='51309-K5'

SELECT * FROM PRODUTOS_REF_FORNECEDOR
WHERE PRODUTO='51309-K5'

SELECT REPLACE('51309L19','K','-K')

SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM
where referencia='51309-K5'

SELECT NF_ENTRADA,* FROM ENTRADAS_ITEM
WHERE REFERENCIA='50.30.0001'

select * from PARAMETROS_IMPORT_XML
insert into PARAMETROS_IMPORT_XML 
(codigo_fiscal_operacao,natureza_entrada,rateio_centro_custo,tipo_entradas,rateio_filial,cod_clifor_sacado,natop)
values('1908','231.02','8011','CONSUMIVEIS','000023','600132','REMESSA POR CONTRATO DE COMODATO')

UPDATE PARAMETROS_IMPORT_XML
SET RATEIO_CENTRO_CUSTO='8011', TIPO_ENTRADAS='CONSUMIVEIS'
WHERE CODIGO_FISCAL_OPERACAO='1908'


SELECT * FROM ENTRADAS




--- visualizar
select *  FROM NFE_XML
select *  FROM XML_NFE_CAPA
WHERE NATOP='REMESSA PARA BENEFICIAMENTO.'
select *  FROM XML_NFE_DUPLICATA
select *  FROM XML_NFE_ITEM
select *  FROM XML_NFE_TOTAL
select *  FROM XML_NFE_TRANSPORTADOR

SELECT * FROM DRLINGERIE.DBO.FATURAMENTO_ITEM
WHERE substring(CODIGO_ITEM,1,7) = '0482199'


--- LIMPA TABELAS XML_NFE_?
delete  FROM NFE_XML
delete  FROM XML_NFE_CAPA
delete  FROM XML_NFE_DUPLICATA
delete  FROM XML_NFE_ITEM
delete  FROM XML_NFE_TOTAL
delete  FROM XML_NFE_TRANSPORTADOR

-- CAPA NFe
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'c:\temp\xml\23170600119633000113550560000435951190974060-procNFe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
AS Arquivo)
 
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
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\23170600119633000113550560000435951190974060-procNFe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
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
where not exists (select * from XML_NFE_ITEM where chNFe=NFe.value('../../../protNFe[1]/infProt[1]/chNFe[1]', 'varchar(44)') and nItem=NFe.value('@nItem', 'int'))
order by nItem


 
 
-- TOTAL NFE
DECLARE @XML XML
SET @XML = (
SELECT CAST(BulkColumn AS XML)
FROM OPENROWSET(BULK N'C:\TEMP\XML\23170600119633000113550560000435951190974060-procNFe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
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
FROM OPENROWSET(BULK N'C:\TEMP\XML\23170600119633000113550560000435951190974060-procNFe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
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
FROM OPENROWSET(BULK N'C:\TEMP\XML\23170600119633000113550560000435951190974060-procNFe.xml', SINGLE_BLOB) -- Informe onde se encontra o arquivo XML
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

 
select * from ENTRADAS_ITEM
where nf_entrada='0027571' -- CHAVE_NFE='23170100119633000113550560000275411015877134'

select * from ENTRADAS_ITEM
where nf_entrada='0027541' -- CHAVE_NFE='23170100119633000113550560000275411015877134'

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
'ENTRADAS_109',
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
JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=A.emit_CNPJ AND C.NATOP=A.NATOP
JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=A.dest_CNPJ AND D.NATOP=A.NATOP
JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
JOIN PARAMETROS_IMPORT_XML F ON F.natop=a.natOp 
LEFT JOIN XML_NFE_TRANSPORTADOR G ON G.chNFe=A.chNFe
where a.chNFe='23170600119633000113550560000435951190974060' 
AND NOT EXISTS(SELECT * FROM ENTRADAS WHERE CHAVE_NFE=A.CHNFE)


SELECT * FROM XML_NFE_CAPA A
JOIN XML_NFE_TOTAL B ON B.chNFe=A.chNFe
JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=A.emit_CNPJ AND C.NATOP=A.NATOP
JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=A.dest_CNPJ AND D.NATOP=A.NATOP
JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
JOIN PARAMETROS_IMPORT_XML F ON F.natop=a.natOp 
LEFT JOIN XML_NFE_TRANSPORTADOR G ON G.chNFe=A.chNFe
where a.chNFe='23170600119633000113550560000435951190974060' 
AND NOT EXISTS(SELECT * FROM ENTRADAS WHERE CHAVE_NFE=A.CHNFE)


select * from PARAMETROS_IMPORT_XML

update PARAMETROS_IMPORT_XML
set rateio_filial='000023', cod_clifor_sacado='600132'
where rateio_centro_custo='8011'


SELECT * FROM XML_NFE_CAPA 
where chNFe='23170600119633000113550560000435951190974060' 


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
case when charindex('O.S.:',A.xProd) > 0 then G.CONTA_CONTABIL else H.CONTA_CONTABIL end,
0,
'1',
0,
0,
case when charindex('O.S.:',A.xProd) > 0 then G.INDICADOR_CFOP else H.INDICADOR_CFOP end,
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
100.0000000000,
A.NITEM,
0,
0,
0,
case when charindex('O.S.:',A.xProd) > 0 then 'P' else 'I' end,
A.VUNTRIB
FROM XML_NFE_ITEM A
JOIN XML_NFE_CAPA B ON B.chNFe=A.chNFe
JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=B.emit_CNPJ AND C.NATOP=B.NATOP
JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=B.dest_CNPJ AND D.NATOP=B.NATOP
JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
JOIN (SELECT A.*,B.COD_CLIFOR_SACADO FROM CTB_EXCECAO_IMPOSTO A JOIN PARAMETROS_IMPORT_XML B ON B.NATUREZA_ENTRADA=A.NATUREZA_ENTRADA WHERE A.INATIVO=0) F ON F.COD_CLIFOR_SACADO=C.CLIFOR
LEFT JOIN PRODUTOS G ON G.PRODUTO = case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end
LEFT JOIN MATERIAIS H ON H.MATERIAL=A.CPROD
JOIN PARAMETROS_IMPORT_XML I ON I.natop=B.natOp 
where a.chNFe='23170600119633000113550560000435951190974060'
AND NOT EXISTS(SELECT * FROM ENTRADAS_ITEM WHERE NF_ENTRADA=B.NNF AND CODIGO_ITEM=A.CPROD)


select * from XML_NFE_ITEM
where chNFe='23170600119633000113550560000435951190974060'

SELECT * FROM ENTRADAS_ITEM



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
	where a.chNFe='23170200119633000113550560000311241844602590'	--AND NOT EXISTS(SELECT * FROM ENTRADAS_ITEM WHERE NF_ENTRADA=B.NNF AND CODIGO_ITEM=A.CPROD)


SELECT * FROM PARAMETROS_IMPORT_XML

LX_IMPORTA_NFE_ENTRADAS

--- tabela linx
select * from NFE_XML

--- gera impostos
EXEC LX_GERA_IMPOSTOS_ENTRADA 'D.R. LINGERIE','0027541','56',1,1,1

--- GERA INTEGRAÇÃO 
EXEC LX_CTB_Integrar_Entrada 'D.R. LINGERIE','0027541','56'


SELECT * FROM CADASTRO_CLI_FOR
WHERE NOME_CLIFOR LIKE '%D.R.%'

SELECT * FROM FILIAIS
WHERE FILIAL LIKE '%%'

SELECT * FROM PARAMETROS_IMPORT_XML
 
-- tabelas auxiliares
INSERT INTO [dbo].[PARAMETROS_IMPORT_XML]
           ([CODIGO_FISCAL_OPERACAO]
           ,[NATUREZA_ENTRADA]
           ,[RATEIO_CENTRO_CUSTO]
           ,[TIPO_ENTRADAS]
           ,[RATEIO_FILIAL]
           ,[COD_CLIFOR_SACADO]
		   ,natop)
VALUES    ( '1901','230.01','21','BENEFICIAMENTO','601407','600132','REMESSA PARA BENEFICIAMENTO.')

-- coluna adicionada para dar suporte a importação de mais uma natureza de entrada
ALTER TABLE PARAMETROS_IMPORT_XML ADD COD_TRANSACAO CHAR(23) NULL


-- TABELA PARAMETROS PARA IMPORT DE XML
create table PARAMETROS_IMPORT_XML (
                [CODIGO_FISCAL_OPERACAO] [char](4) NOT NULL,
                [NATUREZA_ENTRADA] [CHAR](15) NOT NULL,
                [RATEIO_CENTRO_CUSTO] [VARCHAR](15) NOT NULL,
                [TIPO_ENTRADAS] [VARCHAR](25) NOT NULL,
                [RATEIO_FILIAL] [VARCHAR](15) NOT NULL,
                [COD_CLIFOR_SACADO] [CHAR](6) NOT NULL,
CONSTRAINT [XPK_PARAMETROS_IMPORT_XML] PRIMARY KEY CLUSTERED
(
                [NATUREZA_ENTRADA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE PARAMETROS_IMPORT_XML ADD natOp varchar(max) not null


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
				[infAdic] [varchar](max) NULL
CONSTRAINT [XPK_XML_NFE_CAPA] PRIMARY KEY CLUSTERED
(
                [chNFe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
 
GO

ALTER TABLE XML_NFE_CAPA ADD infAdic VARCHAR(MAX) NULL
 
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

DROP TABLE IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM

select * from IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM

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

GO


SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM
WHERE INDICADOR_CFOP IS NULL

--- ORIGEM_ITEM
INSERT INTO IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM (REFERENCIA,ORIGEM_ITEM,CONTA_CONTABIL,INDICADOR_CFOP) 
SELECT PRODUTO,'P',CONTA_CONTABIL,INDICADOR_CFOP FROM PRODUTOS A
WHERE NOT EXISTS(SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM WHERE REFERENCIA=A.PRODUTO) AND A.PRODUTO <> ''
GO
INSERT INTO IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM (REFERENCIA,ORIGEM_ITEM,CONTA_CONTABIL,INDICADOR_CFOP) 
SELECT MATERIAL,'M',CONTA_CONTABIL,INDICADOR_CFOP FROM MATERIAIS A
WHERE NOT EXISTS(SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM WHERE REFERENCIA=A.MATERIAL) AND A.MATERIAL <> ''
GO
INSERT INTO IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM (REFERENCIA,ORIGEM_ITEM,CONTA_CONTABIL,INDICADOR_CFOP) 
SELECT CODIGO_ITEM,'I',CONTA_CONTABIL,INDICADOR_CFOP FROM CADASTRO_ITEM_FISCAL A
WHERE NOT EXISTS(SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM WHERE REFERENCIA=A.CODIGO_ITEM) AND A.CODIGO_ITEM <> ''


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
 
SELECT * FROM ENTRADAS
WHERE NF_ENTRADA='30851'

SELECT * FROM ENTRADAS_IMPOSTO 
WHERE NF_ENTRADA='0030851'
 
------*****************************************************************************************************------
--- IMPORTAÇÃO DE PRODUTOS, MATERIAIS E ITEM FISCAL

-- CTB_LX_INDICADOR_CFOP
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


-- PRODUTOS_SEGMENTO
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


-- PRODUTOS_PERIODOS_PCP
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

-- PRODUTIV_TOLERANCIAS
INSERT INTO [dbo].[PRODUTIV_TOLERANCIAS]
           ([TOLERANCIA]
           ,[INDICE_TOLERANCIA])
SELECT      [TOLERANCIA]
           ,[INDICE_TOLERANCIA]
FROM DRLINGERIE.DBO.[PRODUTIV_TOLERANCIAS] A
WHERE NOT EXISTS(SELECT * FROM PRODUTIV_TOLERANCIAS WHERE TOLERANCIA=A.TOLERANCIA)

-- PRODUTOS_GRUPO
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

--- EXCLUIR INDICE UNICO E ALTERAR O CODIGO DO GRUPO DEPOIS DE IMPORTAR OS DADOS
SELECT * FROM PRODUTOS_GRUPO
ORDER BY CODIGO_GRUPO

UPDATE PRODUTOS_GRUPO
SET CODIGO_GRUPO=68
WHERE GRUPO_PRODUTO='CAMISOLA                 '


-- PRODUTOS_SUBGRUPO
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

SELECT CODIGO_SUBGRUPO,GRUPO_PRODUTO,SUBGRUPO_PRODUTO FROM PRODUTOS_SUBGRUPO
ORDER BY CODIGO_SUBGRUPO,GRUPO_PRODUTO

--- GERAR CODIGO HEXDECIMAL PARA CODIGO SUBGRUPO PRODUTO
UPDATE A
SET A.CODIGO_SUBGRUPO=B.COD
FROM PRODUTOS_SUBGRUPO A
JOIN (SELECT COD=SUBSTRING(DBO.fn_IntToStrHex(CAST('1' AS INT)+ ROW_NUMBER() OVER(ORDER BY CODIGO_SUBGRUPO)),3,2),* FROM PRODUTOS_SUBGRUPO) B ON B.GRUPO_PRODUTO=A.GRUPO_PRODUTO AND B.SUBGRUPO_PRODUTO=A.SUBGRUPO_PRODUTO

UPDATE PRODUTOS_SUBGRUPO
SET CODIGO_SUBGRUPO='FF'
WHERE GRUPO_PRODUTO='VAREJO-SHORT             ' AND SUBGRUPO_PRODUTO='CÓS ALTO                 '

-- PRODUTIV_LINHA_INDUSTRIAL
INSERT INTO [dbo].[PRODUTIV_LINHA_INDUSTRIAL]
           ([LINHA_INDUSTRIAL]
           ,[CAPACIDADE])
SELECT      [LINHA_INDUSTRIAL]
           ,[CAPACIDADE]
FROM DRLINGERIE.DBO.PRODUTIV_LINHA_INDUSTRIAL A
WHERE NOT EXISTS(SELECT * FROM PRODUTIV_LINHA_INDUSTRIAL WHERE LINHA_INDUSTRIAL=A.LINHA_INDUSTRIAL)


-- PRODUTOS_TAB_OPERACOES
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

-- MATERIAIS_TIPO_LAVAGEM
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

-- PRODUTOS_SOLUCAO
INSERT INTO [dbo].[PRODUTOS_SOLUCAO]
           ([COD_PRODUTO_SOLUCAO]
           ,[DESC_PRODUTO_SOLUCAO]
           ,[INATIVO])
SELECT      [COD_PRODUTO_SOLUCAO]
           ,[DESC_PRODUTO_SOLUCAO]
           ,[INATIVO]
FROM DRLINGERIE.DBO.[PRODUTOS_SOLUCAO] A
WHERE NOT EXISTS(SELECT * FROM PRODUTOS_SOLUCAO WHERE COD_PRODUTO_SOLUCAO=A.COD_PRODUTO_SOLUCAO)

-- PRODUTOS_TAMANHOS
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

-- PRODUTOS_TAB_MEDIDAS 
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

-- TABELA_OPERACOES
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


-- PRODUTOS_STATUS
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


-- cest_ncm
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

-- CORES BASICAS
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


--- CLASSIF_FISCAL
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

-- CTB_CONTA_TIPO
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

-- CTB_CENTRO_CUSTO_RATEIO
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

-- CTB_CONTA_PLANO
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
WHERE NOT EXISTS(SELECT * FROM CTB_CONTA_PLANO WHERE CONTA_CONTABIL=A.CONTA_CONTABIL) and not exists(select * from CTB_VISAO where CLASSIFICACAO=a.CONTA_CONTABIL)

-- COLECAO
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

-- produto acabado
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

-- PRODUTOS_CORES
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

-- MATERIAIS_GRUPO
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

SELECT * FROM MATERIAIS_GRUPO
ORDER BY CODIGO_GRUPO

--- GERAR CODIGO HEXDECIMAL PARA CODIGO SUBGRUPO PRODUTO
UPDATE A
SET A.CODIGO_GRUPO=B.COD
SELECT * FROM MATERIAIS_GRUPO A
JOIN (SELECT COD=SUBSTRING(DBO.fn_IntToStrHex(CAST('1' AS INT)+ ROW_NUMBER() OVER(ORDER BY CODIGO_GRUPO)),3,2),* 
FROM MATERIAIS_GRUPO) B ON B.GRUPO=A.GRUPO

-- MATERIAIS_SUBGRUPO
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

-- MATERIAIS
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

-- MATERIAIS_CORES
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


-- CADASTRO_ITENS_FISCAIS
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


exec sp_executesql N'INSERT INTO ENTRADAS (NF_ENTRADA,NOME_CLIFOR,EMISSAO,FILIAL,EMPRESA,AGRUPAMENTO_ITENS,COD_TRANSACAO,NATUREZA,CONDICAO_PGTO,RECEBIMENTO,NF_FATURA,SERIE_NF_ENTRADA,TABELA_FILHA,TRANSF_FILIAL,TIPO_ENTRADAS,TRANSPORTADORA_A_PAGAR,MOEDA,MOEDA_COMPRA,DATA_DIGITACAO,EMBALAGENS,TIPO_VOLUME,RATEIO_FILIAL,RATEIO_CENTRO_CUSTO,DATA_FATURAMENTO_RELATIVO,UTILIZA_DIAS_FIXOS_FORNECEDOR,NOME_CLIFOR_TRIANGULAR,SERIE_NF,NUMERO_ENTRADA,FATURA_NOME_CLIFOR,FATURA_SERIE,FATURA_NUMERO,DIFERENCA_VALOR,QTDE_TOTAL,VALOR_TOTAL,FRETE_A_PAGAR,IMPORTACAO_IMPOSTO,IMPORTACAO_ICMS,IMPORTACAO_IPI,IMPORTACAO_ALFANDEGA,IMPORTACAO_OUTRAS_DESPESAS,IMPORTACAO_FRETE,IMPORTACAO_SEGURO,IMPORTACAO_DESEMBARACO,PESO,PESO_BRUTO,PORC_DESCONTO,PORC_ENCARGO,COMISSAO_VALOR,COMISSAO_VALOR_GERENTE,VALOR_IMPOSTO_AGREGAR,VALOR_SUB_ITENS,CAMBIO_NA_DATA,ESPECIE_SERIE,NOTA_CANCELADA,COD_CLIFOR_SACADO,IMPORTACAO_TX_CAPATAZIA,PROTOCOLO_AUTORIZACAO_NFE,CHAVE_NFE,MOTIVO_CANCELAMENTO_NFE,FIN_EMISSAO_NFE,DATA_AUTORIZACAO_NFE,MARCA_VOLUMES,INDICA_PRESENCA_COMPRADOR) VALUES (@P1 ,@P2 ,@P3 ,@P4 ,@P5 ,@P6 ,@P7 ,@P8 ,@P9 ,@P10 ,@P11 ,@P12 ,@P13 ,@P14 ,@P15 ,@P16 ,@P17 ,@P18 ,@P19 ,@P20 ,@P21 ,@P22 ,@P23 ,@P24 ,@P25 ,@P26 ,@P27 ,@P28 ,@P29 ,@P30 ,@P31 ,@P32 ,@P33 ,@P34 ,@P35 ,@P36 ,@P37 ,@P38 ,@P39 ,@P40 ,@P41 ,@P42 ,@P43 ,@P44 ,@P45 ,@P46 ,@P47 ,@P48 ,@P49 ,@P50 ,@P51 ,@P52 ,@P53 ,@P54 ,@P55 ,@P56 ,@P57 ,@P58 ,@P59 ,@P60 ,@P61 ,@P62 ,@P63 )',N'@P1 varchar(15),@P2 varchar(25),@P3 datetime,@P4 varchar(25),@P5 int,@P6 smallint,@P7 varchar(23),@P8 varchar(15),@P9 varchar(3),@P10 datetime,@P11 bit,@P12 varchar(6),@P13 varchar(18),@P14 bit,@P15 varchar(25),@P16 varchar(25),@P17 varchar(6),@P18 varchar(6),@P19 datetime,@P20 int,@P21 varchar(35),@P22 varchar(15),@P23 varchar(15),@P24 datetime,@P25 bit,@P26 varchar(25),@P27 varchar(6),@P28 int,@P29 varchar(25),@P30 varchar(6),@P31 varchar(15),@P32 bit,@P33 numeric(10,3),@P34 numeric(15,5),@P35 tinyint,@P36 numeric(14,2),@P37 numeric(14,2),@P38 numeric(14,2),@P39 numeric(14,2),@P40 numeric(14,2),@P41 numeric(14,2),@P42 numeric(14,2),@P43 numeric(14,2),@P44 numeric(14,2),@P45 numeric(14,2),@P46 numeric(13,10),@P47 numeric(13,10),@P48 numeric(14,2),@P49 numeric(14,2),@P50 numeric(14,2),@P51 numeric(14,2),@P52 numeric(15,6),@P53 int,@P54 bit,@P55 varchar(6),@P56 numeric(14,2),@P57 varchar(15),@P58 varchar(44),@P59 varchar(255),@P60 tinyint,@P61 datetime,@P62 varchar(60),@P63 tinyint','0027571        ','D.R. LINGERIE            ','2017-02-17 00:00:00','VM CONFECCOES            ',1,1,'ENTRADAS_108           ','230.01         ','000','2017-02-17 00:00:00',0,'56    ','ENTRADAS_NF       ',0,'BENEFICIAMENTO           ','NOSSO CARRO              ','R$    ','R$    ','2017-02-17 00:00:00',12,'CAIXA DE PAPELAO                   ','000023         ','21             ',NULL,0,'D.R. LINGERIE            ','1     ',NULL,NULL,NULL,NULL,0,4704.600,1277.96000,1,0,0,0,0,0,0,0,0,24.00,24.00,0,0,0,0,0,1277.96,1.000000,3,0,'600132',0,'123170000235565','23170100119633000113550560000275411015877134','',0,'2017-01-03 07:32:41','CAIXA DE PAPELAO                                            ',0
exec sp_executesql N'INSERT INTO ENTRADAS_ITEM (NOME_CLIFOR,NF_ENTRADA,SERIE_NF_ENTRADA,ITEM_IMPRESSAO,SUB_ITEM_TAMANHO,DESCRICAO_ITEM,QTDE_ITEM,PRECO_UNITARIO,CODIGO_ITEM,DESCONTO_ITEM,VALOR_ITEM,COD_TABELA_FILHA,TRIBUT_ICMS,TRIBUT_ORIGEM,UNIDADE,CLASSIF_FISCAL,CODIGO_FISCAL_OPERACAO,PESO,CONTA_CONTABIL,QTDE_RETORNAR_BENEFICIAMENTO,FAIXA,COMISSAO_ITEM,COMISSAO_ITEM_GERENTE,INDICADOR_CFOP,QTDE_DEVOLVIDA,PORCENTAGEM_ITEM_RATEIO,ID_EXCECAO_IMPOSTO,REFERENCIA,REFERENCIA_ITEM,REFERENCIA_PEDIDO,TIMESTAMP,VALOR_ENCARGOS,VALOR_DESCONTOS,NAO_SOMA_VALOR,VALOR_ENCARGOS_IMPORTACAO,RATEIO_FILIAL,RATEIO_CENTRO_CUSTO,VALOR_ENCARGOS_ADUANEIROS,PORC_ITEM_RATEIO_FRETE,ITEM_NFE,MPADRAO_SEGURO_ITEM,MPADRAO_FRETE_ITEM,MPADRAO_ENCARGO_ITEM,ORIGEM_ITEM,PRECO_UNITARIO_ORIGINAL) VALUES (@P1 ,@P2 ,@P3 ,@P4 ,@P5 ,@P6 ,@P7 ,@P8 ,@P9 ,@P10 ,@P11 ,@P12 ,@P13 ,@P14 ,@P15 ,@P16 ,@P17 ,@P18 ,@P19 ,@P20 ,@P21 ,@P22 ,@P23 ,@P24 ,@P25 ,@P26 ,@P27 ,@P28 ,@P29 ,@P30 ,@P31 ,@P32 ,@P33 ,@P34 ,@P35 ,@P36 ,@P37 ,@P38 ,@P39 ,@P40 ,@P41 ,@P42 ,@P43 ,@P44 ,@P45 )',N'@P1 varchar(25),@P2 varchar(15),@P3 varchar(6),@P4 varchar(4),@P5 int,@P6 varchar(80),@P7 numeric(9,3),@P8 numeric(15,5),@P9 varchar(50),@P10 numeric(15,5),@P11 numeric(14,2),@P12 varchar(1),@P13 varchar(3),@P14 varchar(3),@P15 varchar(5),@P16 varchar(10),@P17 varchar(4),@P18 numeric(9,5),@P19 varchar(20),@P20 numeric(9,3),@P21 varchar(1),@P22 numeric(8,5),@P23 numeric(8,5),@P24 tinyint,@P25 numeric(9,3),@P26 numeric(13,10),@P27 int,@P28 varchar(50),@P29 varchar(12),@P30 varchar(12),@P31 varchar(25),@P32 numeric(14,2),@P33 numeric(14,2),@P34 bit,@P35 numeric(14,2),@P36 varchar(15),@P37 varchar(15),@P38 numeric(14,2),@P39 numeric(13,10),@P40 smallint,@P41 numeric(14,2),@P42 numeric(14,2),@P43 numeric(14,2),@P44 varchar(1),@P45 numeric(15,5)','D.R. LINGERIE            ','0027571        ','56    ','0001',0,'CARTELA BIQUINI FASHION UNICA                                                   ',0.120,19.32000,'70.12.0221999                                     ',0,2.32,'T','41 ','0  ','MIL  ','49111090  ','1903',0,NULL,0,'1',0,0,12,0,0.1815393283,18,'70.12.0221                                        ','999         ',NULL,'ÆÆÆÆÆÆÆÆÆÆÆÆ36Ø42111     ',0,0,0,0,'000023         ','31             ',0,0.1815393283,1,0,0,0,'M',19.32000
exec sp_executesql N'INSERT INTO ENTRADAS_ITEM (NOME_CLIFOR,NF_ENTRADA,SERIE_NF_ENTRADA,ITEM_IMPRESSAO,SUB_ITEM_TAMANHO,DESCRICAO_ITEM,QTDE_ITEM,PRECO_UNITARIO,CODIGO_ITEM,DESCONTO_ITEM,VALOR_ITEM,COD_TABELA_FILHA,TRIBUT_ICMS,TRIBUT_ORIGEM,UNIDADE,CLASSIF_FISCAL,CODIGO_FISCAL_OPERACAO,PESO,CONTA_CONTABIL,QTDE_RETORNAR_BENEFICIAMENTO,FAIXA,COMISSAO_ITEM,COMISSAO_ITEM_GERENTE,INDICADOR_CFOP,QTDE_DEVOLVIDA,PORCENTAGEM_ITEM_RATEIO,ID_EXCECAO_IMPOSTO,REFERENCIA,REFERENCIA_ITEM,REFERENCIA_PEDIDO,TIMESTAMP,VALOR_ENCARGOS,VALOR_DESCONTOS,NAO_SOMA_VALOR,VALOR_ENCARGOS_IMPORTACAO,RATEIO_FILIAL,RATEIO_CENTRO_CUSTO,VALOR_ENCARGOS_ADUANEIROS,PORC_ITEM_RATEIO_FRETE,ITEM_NFE,MPADRAO_SEGURO_ITEM,MPADRAO_FRETE_ITEM,MPADRAO_ENCARGO_ITEM,ORIGEM_ITEM,PRECO_UNITARIO_ORIGINAL) VALUES (@P1 ,@P2 ,@P3 ,@P4 ,@P5 ,@P6 ,@P7 ,@P8 ,@P9 ,@P10 ,@P11 ,@P12 ,@P13 ,@P14 ,@P15 ,@P16 ,@P17 ,@P18 ,@P19 ,@P20 ,@P21 ,@P22 ,@P23 ,@P24 ,@P25 ,@P26 ,@P27 ,@P28 ,@P29 ,@P30 ,@P31 ,@P32 ,@P33 ,@P34 ,@P35 ,@P36 ,@P37 ,@P38 ,@P39 ,@P40 ,@P41 ,@P42 ,@P43 ,@P44 ,@P45 )',N'@P1 varchar(25),@P2 varchar(15),@P3 varchar(6),@P4 varchar(4),@P5 int,@P6 varchar(80),@P7 numeric(9,3),@P8 numeric(15,5),@P9 varchar(50),@P10 numeric(15,5),@P11 numeric(14,2),@P12 varchar(1),@P13 varchar(3),@P14 varchar(3),@P15 varchar(5),@P16 varchar(10),@P17 varchar(4),@P18 numeric(9,5),@P19 varchar(20),@P20 numeric(9,3),@P21 varchar(1),@P22 numeric(8,5),@P23 numeric(8,5),@P24 tinyint,@P25 numeric(9,3),@P26 numeric(13,10),@P27 int,@P28 varchar(50),@P29 varchar(12),@P30 varchar(12),@P31 varchar(25),@P32 numeric(14,2),@P33 numeric(14,2),@P34 bit,@P35 numeric(14,2),@P36 varchar(15),@P37 varchar(15),@P38 numeric(14,2),@P39 numeric(13,10),@P40 smallint,@P41 numeric(14,2),@P42 numeric(14,2),@P43 numeric(14,2),@P44 varchar(1),@P45 numeric(15,5)','D.R. LINGERIE            ','0027571        ','56    ','0006',0,'BIQUINI TRIO FASHION, ESTAMPA CORUJINHA AD/CORUJINHA-NT-CP                      ',900.000,1.27000,'51509-K76001                                      ',0,1143.00,'R','41 ','5  ','PC   ','61082200  ','1903',0,NULL,0,'1',0,0,10,0,89.4394190741,18,'51509-K76                                         ','001         ',NULL,'ÆÆÆÆÆÆÆÆÆÆÆÆÆ3Ø29111     ',0,0,0,0,'000023         ','31             ',0,89.4394190741,6,0,0,0,'M',1.27000
exec sp_executesql N'INSERT INTO ENTRADAS_IMPOSTO (NOME_CLIFOR,NF_ENTRADA,SERIE_NF_ENTRADA,ITEM_IMPRESSAO,SUB_ITEM_TAMANHO,AGREGA_APOS_DESCONTO,TAXA_IMPOSTO,VALOR_IMPOSTO,BASE_IMPOSTO,TAXA_IMPOSTO_ESPELHO,VALOR_IMPOSTO_ESPELHO,BASE_IMPOSTO_ESPELHO,AGREGA_APOS_ENCARGO,ID_IMPOSTO,INCIDENCIA,TAXA_IMPOSTO_CALC,VALOR_IMPOSTO_CALC,BASE_IMPOSTO_CALC) VALUES (@P1 ,@P2 ,@P3 ,@P4 ,@P5 ,@P6 ,@P7 ,@P8 ,@P9 ,@P10 ,@P11 ,@P12 ,@P13 ,@P14 ,@P15 ,@P16 ,@P17 ,@P18 )',N'@P1 varchar(25),@P2 varchar(15),@P3 varchar(6),@P4 varchar(4),@P5 int,@P6 bit,@P7 numeric(8,5),@P8 numeric(14,2),@P9 numeric(14,2),@P10 numeric(8,5),@P11 numeric(14,2),@P12 numeric(14,2),@P13 bit,@P14 tinyint,@P15 tinyint,@P16 numeric(8,5),@P17 numeric(14,2),@P18 numeric(14,2)','D.R. LINGERIE            ','0027571        ','56    ','0001',0,0,0,0,0,0,0,0,0,2,1,0,0,0
exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
  EXEC LX_CTB_Integrar_Entrada @P1, @P2, @P3',N'@P1 varchar(13),@P2 varchar(7),@P3 varchar(2)','D.R. LINGERIE','0027571','56'


exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
  DELETE FROM ENTRADAS_OBSERVACAO WHERE NF_ENTRADA = @P1 AND SERIE_NF_ENTRADA = @P2 AND NOME_CLIFOR = @P3',N'@P1 varchar(7),@P2 varchar(2),@P3 varchar(13)','0027571','56','D.R. LINGERIE'

select * from ENTRADAS_OBSERVACAO

exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
   UPDATE ESTOQUE_RET_MAT SET NF_ENTRADA = @P1, SERIE_NF_ENTRADA = @P2, NOME_CLIFOR = @P3  WHERE ESTOQUE_RET_MAT.REQ_MATERIAL = @P4  AND ESTOQUE_RET_MAT.FILIAL = @P5 ',N'@P1 varchar(7),@P2 varchar(2),@P3 varchar(13),@P4 varchar(1),@P5 varchar(1)','0027571','56','D.R. LINGERIE','',''


SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM
WHERE REFERENCIA='TECIDOS'

--- código da procedure 

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
	F.COD_TRANSACAO,
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
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,natOp FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=A.emit_CNPJ AND C.natOp=A.natOp
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,natOp FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=A.dest_CNPJ AND D.natOp=A.natOp
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN PARAMETROS_IMPORT_XML F ON F.natop=a.natOp 
	LEFT JOIN XML_NFE_TRANSPORTADOR G ON G.chNFe=A.chNFe
	where a.chNFe='23170600119633000113550560000435951190974060'--@CHAVE_NFE 
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
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,natOp FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=B.emit_CNPJ AND C.natOp=B.natOp
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,natOp FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=B.dest_CNPJ AND D.natOp=B.natOp
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN (SELECT A.*,B.COD_CLIFOR_SACADO FROM CTB_EXCECAO_IMPOSTO A JOIN PARAMETROS_IMPORT_XML B ON B.NATUREZA_ENTRADA=A.NATUREZA_ENTRADA WHERE A.INATIVO=0) F ON F.COD_CLIFOR_SACADO=C.CLIFOR
	JOIN PARAMETROS_IMPORT_XML I ON I.natop=B.natOp 
	LEFT JOIN IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM J ON J.REFERENCIA=case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end
	where a.chNFe='23170600119633000113550560000435951190974060'--@CHAVE_NFE 
	AND NOT EXISTS(SELECT * FROM ENTRADAS_ITEM WHERE NOME_CLIFOR=C.NOME_CLIFOR AND NF_ENTRADA=REPLICATE(0, (7-LEN(RTRIM(B.nNF))))+RTRIM(B.nNF) AND SERIE_NF_ENTRADA=B.SERIE AND ITEM_IMPRESSAO=REPLICATE(0, (4-LEN(RTRIM(A.nItem))))+RTRIM(A.nItem))

	--- GERA IMPOSTOS ENTRADA
	EXEC LX_GERA_IMPOSTOS_ENTRADA 'D.R. LINGERIE','0043595','56',1,1,1

	--- GERA INTEGRAÇÃO 
	EXEC LX_CTB_Integrar_Entrada 'D.R. LINGERIE','0043595','56'


select * from PARAMETROS_IMPORT_XML

UPDATE PARAMETROS_IMPORT_XML
SET COD_TRANSACAO='ENTRADAS_109'
WHERE NATUREZA_ENTRADA<>'230.01'

SELECT * FROM IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM
WHERE REFERENCIA='90.05.2128'

----------------------------------------------------------------------------------------------------------------
use wm
select * from PARAMETROS_IMPORT_XML
--delete from PARAMETROS_IMPORT_XML 
--where codigo_fiscal_operacao='1908'
ALTER TABLE PARAMETROS_IMPORT_XML ADD COD_TRANSACAO CHAR(23) NULL

select * from xml_nfe_capa
where nnf='43460'


select * from PARAMETROS_IMPORT_XML

update PARAMETROS_IMPORT_XML
set cod_transacao='ENTRADAS_108'
where codigo_fiscal_operacao='1901'

insert into PARAMETROS_IMPORT_XML 
(codigo_fiscal_operacao,natureza_entrada,rateio_centro_custo,tipo_entradas,rateio_filial,cod_clifor_sacado,natop,cod_transacao)
values('1915','231.03','21','BENEFICIAMENTO','000030','600132','REMESSA P/CONSERTO OU REPARO','ENTRADAS_108')

insert into PARAMETROS_IMPORT_XML 
(codigo_fiscal_operacao,natureza_entrada,rateio_centro_custo,tipo_entradas,rateio_filial,cod_clifor_sacado,natop,cod_transacao)
values('1915','231.03','21','BENEFICIAMENTO','600748','600132','REMESSA P/CONSERTO OU REPARO','ENTRADAS_108')

insert into PARAMETROS_IMPORT_XML 
(codigo_fiscal_operacao,natureza_entrada,rateio_centro_custo,tipo_entradas,rateio_filial,cod_clifor_sacado,natop,cod_transacao)
values('1915','231.03','21','BENEFICIAMENTO','000033','600132','REMESSA P/CONSERTO OU REPARO','ENTRADAS_108')

insert into PARAMETROS_IMPORT_XML 
(codigo_fiscal_operacao,natureza_entrada,rateio_centro_custo,tipo_entradas,rateio_filial,cod_clifor_sacado,natop,cod_transacao)
values('1915','231.03','21','BENEFICIAMENTO','600224','600132','REMESSA P/CONSERTO OU REPARO','ENTRADAS_108')


insert into PARAMETROS_IMPORT_XML 
(codigo_fiscal_operacao,natureza_entrada,rateio_centro_custo,tipo_entradas,rateio_filial,cod_clifor_sacado,natop,cod_transacao)
values('1912','231.04','21','PRODUTO ACABADO','000030','600132','REMESSA EM DEMONSTRACAO','ENTRADAS_108')

insert into PARAMETROS_IMPORT_XML 
(codigo_fiscal_operacao,natureza_entrada,rateio_centro_custo,tipo_entradas,rateio_filial,cod_clifor_sacado,natop,cod_transacao)
values('1912','231.04','21','PRODUTO ACABADO','600748','600132','REMESSA EM DEMONSTRACAO','ENTRADAS_108')

insert into PARAMETROS_IMPORT_XML 
(codigo_fiscal_operacao,natureza_entrada,rateio_centro_custo,tipo_entradas,rateio_filial,cod_clifor_sacado,natop,cod_transacao)
values('1912','231.04','21','PRODUTO ACABADO','000033','600132','REMESSA EM DEMONSTRACAO','ENTRADAS_108')

insert into PARAMETROS_IMPORT_XML 
(codigo_fiscal_operacao,natureza_entrada,rateio_centro_custo,tipo_entradas,rateio_filial,cod_clifor_sacado,natop,cod_transacao)
values('1912','231.04','21','PRODUTO ACABADO','600224','600132','REMESSA EM DEMONSTRACAO','ENTRADAS_108')


select from entradas
where natureza='231.04'


SELECT * FROM DRLINGERIE.DBO.FATURAMENTO_ITEM
WHERE NF_SAIDA='0043460' AND SERIE_NF='56'

SELECT * FROM XML_NFE_CAPA
WHERE NNF='43759'





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
	F.COD_TRANSACAO,
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
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,natop FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=A.emit_CNPJ AND C.NATOP=A.NATOP
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,natop FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=A.dest_CNPJ AND D.NATOP=A.NATOP
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN PARAMETROS_IMPORT_XML F ON F.natop=a.natOp 
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
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) C ON C.CGC_CPF=B.emit_CNPJ AND C.NATOP=B.NATOP
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) D ON D.CGC_CPF=B.dest_CNPJ AND D.NATOP=B.NATOP
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN (SELECT A.*,B.COD_CLIFOR_SACADO FROM CTB_EXCECAO_IMPOSTO A JOIN PARAMETROS_IMPORT_XML B ON B.NATUREZA_ENTRADA=A.NATUREZA_ENTRADA WHERE A.INATIVO=0) F ON F.COD_CLIFOR_SACADO=C.CLIFOR
	JOIN PARAMETROS_IMPORT_XML I ON I.natop=B.natOp 
	LEFT JOIN IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM J ON J.REFERENCIA=case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end
	where a.chNFe=@CHAVE_NFE AND NOT EXISTS(SELECT * FROM ENTRADAS_ITEM WHERE NOME_CLIFOR=C.NOME_CLIFOR AND NF_ENTRADA=REPLICATE(0, (7-LEN(RTRIM(B.nNF))))+RTRIM(B.nNF) AND SERIE_NF_ENTRADA=B.SERIE AND ITEM_IMPRESSAO=REPLICATE(0, (4-LEN(RTRIM(A.nItem))))+RTRIM(A.nItem))

	--- GERA IMPOSTOS ENTRADA
	EXEC LX_GERA_IMPOSTOS_ENTRADA @NOME_CLIFOR,@NF_ENTRADA,@SERIE_NF_ENTRADA,1,1,1

	--- GERA INTEGRAÇÃO 
	EXEC LX_CTB_Integrar_Entrada @NOME_CLIFOR,@NF_ENTRADA,@SERIE_NF_ENTRADA

END 

