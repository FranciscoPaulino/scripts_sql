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
	REPLICATE(0, (9-LEN(RTRIM(A.nNF))))+RTRIM(A.nNF) AS NF_ENTRADA,                  
	D.NOME_CLIFOR,
	convert(date,A.dhEmi,103),
	C.NOME_CLIFOR,
	1,
	1,
	F.COD_TRANSACAO,
	F.NATUREZA_ENTRADA,
	'000',
	convert(date,A.dhEmi,103),
	0,
	A.serie,
	'ENTRADAS_NF',
	0,
	F.TIPO_ENTRADAS,
	'R$',
	'R$',
	convert(date,GETDATE(),103),
	C.CLIFOR,
	F.RATEIO_CENTRO_CUSTO,
	NULL,
	0,
	D.NOME_CLIFOR,
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
	D.CLIFOR,
	0,
	A.chNFe,
	A.nProt,
	(A.dhRecbto-.125),
	A.infAdic,
	G.xNome
	FROM XML_NFE_CAPA A
	JOIN XML_NFE_TOTAL B ON B.chNFe=A.chNFe
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,natop FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) C ON C.CGC_CPF=A.emit_CNPJ AND C.NATOP=A.NATOP
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,natop FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) D ON D.CGC_CPF=A.dest_CNPJ AND D.NATOP=A.NATOP
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN PARAMETROS_IMPORT_XML F ON F.natop=a.natOp 
	LEFT JOIN XML_NFE_TRANSPORTADOR G ON G.chNFe=A.chNFe
	where a.chNFe='23151122562645000150550010000000041760506780' AND NOT EXISTS(SELECT * FROM ENTRADAS WHERE CHAVE_NFE=A.CHNFE)

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
	D.NOME_CLIFOR,
	REPLICATE(0, (9-LEN(RTRIM(B.nNF))))+RTRIM(B.nNF) AS NF_ENTRADA,
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
	C.CLIFOR,
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
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.RATEIO_FILIAL=N.CLIFOR) C ON C.CGC_CPF=B.emit_CNPJ AND C.NATOP=B.NATOP
	JOIN (SELECT CLIFOR,CGC_CPF,NOME_CLIFOR,RAZAO_SOCIAL,NATOP FROM CADASTRO_CLI_FOR N JOIN PARAMETROS_IMPORT_XML X ON X.COD_CLIFOR_SACADO=N.CLIFOR) D ON D.CGC_CPF=B.dest_CNPJ AND D.NATOP=B.NATOP
	JOIN (SELECT chNfe, qTrib=SUM(qTrib),vProd=SUM(vProd) FROM XML_NFE_ITEM GROUP BY chNfe) E ON E.chNFe=A.chNFe
	JOIN (SELECT A.*,B.RATEIO_FILIAL,B.NATOP FROM CTB_EXCECAO_IMPOSTO A JOIN PARAMETROS_IMPORT_XML B ON B.NATUREZA_ENTRADA=A.NATUREZA_ENTRADA WHERE A.INATIVO=0) F ON F.RATEIO_FILIAL=C.CLIFOR AND F.NATOP=B.NATOP
	JOIN PARAMETROS_IMPORT_XML I ON I.natop=B.natOp 
	LEFT JOIN IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM J ON J.REFERENCIA=case when charindex('O.S.:',A.xProd) > 0 then substring(A.CPROD,9,12) else A.CPROD end
	where a.chNFe='23151122562645000150550010000000041760506780' AND NOT EXISTS(SELECT * FROM ENTRADAS_ITEM WHERE NOME_CLIFOR=C.NOME_CLIFOR AND NF_ENTRADA=REPLICATE(0, (7-LEN(RTRIM(B.nNF))))+RTRIM(B.nNF) AND SERIE_NF_ENTRADA=B.SERIE AND ITEM_IMPRESSAO=REPLICATE(0, (4-LEN(RTRIM(A.nItem))))+RTRIM(A.nItem))

	--- GERA IMPOSTOS ENTRADA
	EXEC LX_GERA_IMPOSTOS_ENTRADA 'D.R. LINGERIE            ','000000004','1',1,1,1

	--- GERA INTEGRAÇÃO 
	EXEC LX_CTB_Integrar_Entrada 'D.R. LINGERIE            ','000000004','1'

SELECT * FROM ENTRADAS
WHERE NF_ENTRADA='000000004'


SELECT * from PARAMETROS_IMPORT_XML
WHERE NATOP='ENTRADA DE BENEFICIAMENTO'


ALTER TABLE PARAMETROS_IMPORT_XML ALTER COLUMN NATop VARCHAR(80)

ALTER TABLE PARAMETROS_IMPORT_XML 
ADD ID INT IDENTITY(1,1)  PRIMARY KEY
ALTER COLUMN NATop VARCHAR(80) PRIMARY

insert into PARAMETROS_IMPORT_XML (CODIGO_FISCAL_OPERACAO,NATUREZA_ENTRADA,RATEIO_CENTRO_CUSTO,TIPO_ENTRADAS,RATEIO_FILIAL,COD_CLIFOR_SACADO,NATOP,COD_TRANSACAO)
VALUES('1901','230.01','21','BENEFICIAMENTO','000023','600132','ENTRADA DE BENEFICIAMENTO','ENTRADAS_109')

insert into PARAMETROS_IMPORT_XML (CODIGO_FISCAL_OPERACAO,NATUREZA_ENTRADA,RATEIO_CENTRO_CUSTO,TIPO_ENTRADAS,RATEIO_FILIAL,COD_CLIFOR_SACADO,NATOP,COD_TRANSACAO)
SELECT CODIGO_FISCAL_OPERACAO,NATUREZA_ENTRADA,RATEIO_CENTRO_CUSTO,TIPO_ENTRADAS,RATEIO_FILIAL,COD_CLIFOR_SACADO,NATOP,COD_TRANSACAO
FROM PARAMETROS_IMPORT_XML_OLD



select * from IMPORT_XML_NFE_REFERENCIAS_ORIGEM_ITEM