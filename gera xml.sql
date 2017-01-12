--------------------------- e x e m p l o s ---------------------------

SELECT TOP (3)
      FirstName
    , LastName
FROM
    Person.Contact
FOR XML PATH('Contacts'), ROOT('Person')

--- RESULTADO
--<Person>
--  <Contacts>
--    <FirstName>Gustavo</FirstName>
--    <LastName>Achong</LastName>
--  </Contacts>
--  <Contacts>
--    <FirstName>Catherine</FirstName>
--    <LastName>Abel</LastName>
--  </Contacts>
--  <Contacts>
--    <FirstName>Kim</FirstName>
--    <LastName>Abercrombie</LastName>
--  </Contacts>
--</Person>

SELECT TOP (3)
      FirstName AS [@FirstName]
    , LastName AS [@LastName]
FROM
    Person.Contact
FOR XML PATH('Contacts'), ROOT('Person')

--<Person>
--  <Contacts FirstName="Gustavo" LastName="Achong" />
--  <Contacts FirstName="Catherine" LastName="Abel" />
--  <Contacts FirstName="Kim" LastName="Abercrombie" />
--</Person>


SELECT TOP (3)
      LastName AS [Name/@LastName] -- Atributo
    , FirstName AS [Name/text()] -- Texto
    , EmailAddress AS [Contact/Email/text()] -- Texto
    , Phone AS [Contact/Phone] -- Texto, sem 'text()'
    , ModifiedDate AS [comment()] -- Comentário
FROM
    Person.Contact
FOR XML PATH('Contacts'), ROOT('Person')

--<Person>
--  <Contacts>
--    <Name LastName="Achong">Gustavo</Name>
--    <Contact>
--      <Email>gustavo0@adventure-works.com</Email>
--      <Phone>398-555-0132</Phone>
--    </Contact>
--    <!--2005-05-16T16:33:33.060-->
--  </Contacts>
--  <Contacts>
--    <Name LastName="Abel">Catherine</Name>
--    <Contact>
--      <Email>catherine0@adventure-works.com</Email>
--      <Phone>747-555-0171</Phone>
--    </Contact>
--    <!--2005-05-16T16:33:33.077-->
--  </Contacts>
--  <Contacts>
--    <Name LastName="Abercrombie">Kim</Name>
--    <Contact>
--      <Email>kim2@adventure-works.com</Email>
--      <Phone>334-555-0137</Phone>
--    </Contact>
--    <!--2005-05-16T16:33:33.077-->
--  </Contacts>
--</Person>



-- Gerando um path vazio, exigindo do SQL Server a criação de dois nós separados
SELECT TOP (3)
      FirstName AS [TD]
    , NULL AS [text()]
    , LastName AS [TD]
FROM
    Person.Contact
FOR XML PATH('TR'), ROOT('TABLE')
 
-- Gerando o XML por conversão de dados
SELECT TOP (3)
      CAST('<TD>' + FirstName + '</TD><TD>' + LastName + '</TD>' AS XML)
FROM
    Person.Contact
FOR XML PATH('TR'), ROOT('TABLE')
 
-- Gerando o XML por subconsulta
SELECT TOP (3)
      (SELECT FirstName AS [text()] FOR XML PATH('TD'), TYPE)
    , (SELECT LastName AS [text()] FOR XML PATH('TD'), TYPE)
FROM
    Person.Contact
FOR XML PATH('TR'), ROOT('TABLE')

--<TABLE>
--  <TR>
--    <TD>Gustavo</TD>
--    <TD>Achong</TD>
--  </TR>
--  <TR>
--    <TD>Catherine</TD>
--    <TD>Abel</TD>
--  </TR>
--  <TR>
--    <TD>Kim</TD>
--    <TD>Abercrombie</TD>
--  </TR>
--</TABLE>




---- exemplo carga de dados em formato xml para tabela em t-sql
---  Arquivo Prestadores.xml
--<?xml version="1.0" encoding="utf-8"?>
--<Prestadores>
--  <Prestador>
--    <CPF>111.111.111-11</CPF>
--    <NomeProfissional>JOÃO DA SILVA</NomeProfissional>
--    <Empresa>SILVA CONSULTORIA EM INFORMÁTICA LTDA</Empresa>
--    <CNPJ>11.111.111/1111-11</CNPJ>
--    <Cidade>São Paulo</Cidade>
--    <Estado>SP</Estado>
--    <InscricaoEstadual>1111-1</InscricaoEstadual>
--  </Prestador>
--  <Prestador>
--    <CPF>222.222.222-22</CPF>
--    <NomeProfissional>JOAQUIM DE OLIVEIRA</NomeProfissional>
--    <Empresa>SERVIÇOS DE TECNOLOGIA OLIVEIRA ME</Empresa>
--    <CNPJ>22.222.222/2222-22</CNPJ>
--    <Cidade>Belo Horizonte</Cidade>
--    <Estado>MG</Estado>
--    <InscricaoEstadual></InscricaoEstadual>
--  </Prestador>
--  <Prestador>
--    <CPF>333.333.333-33</CPF>
--    <NomeProfissional>MARIA MARTINS</NomeProfissional>
--    <Empresa>MARTINS TECNOLOGIA LTDA</Empresa>
--    <CNPJ>33.333.333/3333-33</CNPJ>
--    <Cidade>Rio de Janeiro</Cidade>
--    <Estado>RJ</Estado>
--    <InscricaoEstadual>33333</InscricaoEstadual>
--  </Prestador>
--  <Prestador>
--    <CPF>444.444.444-44</CPF>
--    <NomeProfissional>JOANA SANTOS</NomeProfissional>
--    <Empresa>CONSULTORIA SANTOS LTDA</Empresa>
--    <CNPJ>44.444.444/4444-44</CNPJ>
--    <Cidade>São Paulo</Cidade>
--    <Estado>SP</Estado>
--    <InscricaoEstadual></InscricaoEstadual>
--  </Prestador>
--</Prestadores>


-- Script para criação da tabela TB_PRESTADOR

USE [Testes]
GO

CREATE TABLE [dbo].[TB_PRESTADOR](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CPF] [char](14) NOT NULL,
	[NmProfissional] [varchar](50) NOT NULL,
	[NmEmpresa] [varchar](50) NOT NULL,
	[CNPJ] [char](18) NOT NULL,
	[NmCidade] [varchar](40) NOT NULL,
	[CdEstado] [char](2) NOT NULL,
	[CdInscricaoEstadual] [varchar](20) NULL,
 CONSTRAINT [PK_TB_PRESTADOR] PRIMARY KEY ([Id]),
 CONSTRAINT [UK_TB_PRESTADOR] UNIQUE ([CNPJ])
)
GO




--- Script para carregamento do arquivo Classe ArquivoPrestadores
USE [Testes]
GO

-- Criação de tabela temporária

IF OBJECT_ID('tempdb..#CARGA_PRESTADORES') IS NOT NULL
BEGIN
    DROP TABLE #CARGA_PRESTADORES
END

CREATE TABLE #CARGA_PRESTADORES (
    [CPF] [char](14),
    [NmProfissional] [varchar](50),
    [NmEmpresa] [varchar](50),
    [CNPJ] [char](18),
    [NmCidade] [varchar](40),
    [CdEstado] [char](2),
    [CdInscricaoEstadual] [varchar](20)
)


-- Carregando os dados a partir do arquivo XML

INSERT INTO #CARGA_PRESTADORES
           (CPF
           ,NmProfissional
           ,NmEmpresa
           ,CNPJ
           ,NmCidade
           ,CdEstado
           ,CdInscricaoEstadual)
SELECT
    X.Prestador.query('CPF').value('.', 'CHAR(14)'),
    X.Prestador.query('NomeProfissional').value('.', 'VARCHAR(50)'),
    X.Prestador.query('Empresa').value('.', 'VARCHAR(50)'),
    X.Prestador.query('CNPJ').value('.', 'CHAR(18)'),
    X.Prestador.query('Cidade').value('.', 'VARCHAR(40)'),
    X.Prestador.query('Estado').value('.', 'CHAR(2)'),
    X.Prestador.query('InscricaoEstadual').value('.', 'VARCHAR(20)')
FROM
( 	
    SELECT CAST(X AS XML)
    FROM OPENROWSET(
        BULK 'C:\TesteXMLSqlServer\Prestadores.xml',
        SINGLE_BLOB) AS T(X)
) AS T(X)
CROSS APPLY X.nodes('Prestadores/Prestador') AS X(Prestador);


-- Incluindo as informações na tabela TB_PRESTADOR

DECLARE @CPF CHAR(14)
DECLARE @NmProfissional VARCHAR(50)
DECLARE @NmEmpresa VARCHAR(50)
DECLARE @CNPJ CHAR(18)
DECLARE @NmCidade VARCHAR(40)
DECLARE @CdEstado CHAR(2)
DECLARE @CdInscricaoEstadual VARCHAR(20)

DECLARE crPrestadores CURSOR FOR
SELECT CPF
      ,NmProfissional
      ,NmEmpresa
      ,CNPJ
      ,NmCidade
      ,CdEstado
      ,CdInscricaoEstadual
FROM #CARGA_PRESTADORES
ORDER BY CPF

OPEN crPrestadores

FETCH NEXT FROM crPrestadores INTO
    @CPF, @NmProfissional, @NmEmpresa,
    @CNPJ, @NmCidade, @CdEstado,  @CdInscricaoEstadual

BEGIN TRANSACTION -- Inicia uma nova transação

WHILE @@FETCH_STATUS = 0
BEGIN
    IF (LTRIM(RTRIM(@CdInscricaoEstadual)) = '')
	    SET @CdInscricaoEstadual = NULL
    
	IF (NOT EXISTS(SELECT 1 FROM dbo.TB_PRESTADOR WHERE CPF = @CPF))
    BEGIN
        INSERT INTO dbo.TB_PRESTADOR
                   (CPF
                   ,NmProfissional
                   ,NmEmpresa
                   ,CNPJ
                   ,NmCidade
                   ,CdEstado
                   ,CdInscricaoEstadual)
             VALUES
                   (@CPF
                   ,@NmProfissional
                   ,@NmEmpresa
                   ,@CNPJ
                   ,@NmCidade
                   ,@CdEstado
                   ,@CdInscricaoEstadual)
    END
    ELSE
    BEGIN
        UPDATE dbo.TB_PRESTADOR
           SET CPF = @CPF
              ,NmProfissional = @NmProfissional
              ,NmEmpresa = @NmEmpresa
              ,CNPJ = @CNPJ
              ,NmCidade = @NmCidade
              ,CdEstado = @CdEstado
              ,CdInscricaoEstadual = @CdInscricaoEstadual
        WHERE CPF = @CPF
    END

    FETCH NEXT FROM crPrestadores INTO
        @CPF, @NmProfissional, @NmEmpresa,
        @CNPJ, @NmCidade, @CdEstado,  @CdInscricaoEstadual
END

CLOSE crPrestadores

DEALLOCATE crPrestadores


-- Verifica a ocorrência de erros e, em caso negativo, confirma
-- a transação iniciada anteriormente

IF (@@ERROR = 0)
BEGIN
    COMMIT TRANSACTION
END
ELSE
BEGIN
    ROLLBACK TRANSACTION
END



------------------------ EXEMPLO XML GNRE ------------------------------

<?xml version="1.0" encoding="UTF-8" standalone="yes" ?> 
   <TLote_GNRE xmlns="http://www.gnre.pe.gov.br"> 
     <guias>
		<TDadosGNRE>
		  <c01_UfFavorecida>...</c01_UfFavorecida> 
		  <c02_receita>...</c02_receita> 
		  <c25_detalhamentoReceita>...</c25_detalhamentoReceita>
		  <c26_produto>...</c26_produto>
		  <c27_tipoIdentificacaoEmitente>...</c27_tipoIdentificacaoEmitente> 
		  <c03_idContribuinteEmitente> 
			<CPF>...</CPF> 
			<CNPJ>...</CNPJ>
		  </c03_idContribuinteEmitente>
		  <c28_tipoDocOrigem>...</c28_tipoDocOrigem> 
		  <c04_docOrigem>...</c04_docOrigem> 
		  <c06_valorPrincipal>...</c06_valorPrincipal> 
		  <c10_valorTotal>...</c10_valorTotal> 
		  <c14_dataVencimento>...</c14_dataVencimento> 
		  <c15_convenio>...</c15_convenio> 
		  <c16_razaoSocialEmitente>...</c16_razaoSocialEmitente>
		  <c17_inscricaoEstadualEmitente>...</c17_inscricaoEstadualEmitente>
		  <c18_enderecoEmitente>...</c18_enderecoEmitente> 
		  <c19_municipioEmitente>...</c19_municipioEmitente> 
		  <c20_ufEnderecoEmitente>...</c20_ufEnderecoEmitente> 
		  <c21_cepEmitente>...</c21_cepEmitente> 
		  <c22_telefoneEmitente>...</c22_telefoneEmitente> 
		  <c34_tipoIdentificacaoDestinatario>...</c34_tipoIdentificacaoDestinatario> 
		  <c35_idContribuinteDestinatario>
			<CPF>...</CPF> 
			<CNPJ>...</CNPJ> 
		  </c35_idContribuinteDestinatario>
		  <c36_inscricaoEstadualDestinatario>...</c36_inscricaoEstadualDestinatario> 
		  <c37_razaoSocialDestinatario>...</c37_razaoSocialDestinatario> 
		  <c38_municipioDestinatario>...</c38_municipioDestinatario> 
		  <c33_dataPagamento>...</c33_dataPagamento>
		  <c05_referencia>
			<periodo>...</periodo>
			<mes>...</mes> 
			<ano>...</ano> 
			<parcela>...</parcela>
		  </c05_referencia>
		  <c39_camposExtras>
			<campoExtra>
			  <codigo>...</codigo>
			  <tipo>...</tipo>
			  <valor>...</valor>
			</campoExtra>
			<campoExtra>
			  <codigo>...</codigo>
			  <tipo>...</tipo>
			  <valor>...</valor>
			</campoExtra>
			<campoExtra>
			  <codigo>...</codigo>
			  <tipo>...</tipo>
			  <valor>...</valor>
			</campoExtra>
		  </c39_camposExtras>
		  <c42_identificadorGuia>...</c42_identificadorGuia>
		</TDadosGNRE>
    </guias> 
</TLote_GNRE>

--- faturamento gnre
WITH XMLNAMESPACES ('uri' as ns1)
SELECT TOP (3)
      uf as [c01_UfFavorecida], -- Atributo
	  '100102' as [c02_receita], -- Atributo
	  '1' as [c25_detalhamentoReceita], -- Atributo
	  'Produto' as [c26_produto], -- Atributo
	  '1' as [c27_tipoIdentificacaoEmitente], -- Atributo
      RTRIM('00119633000113') as [c03_idContribuinteEmitente/CNPJ/text()], -- Atributo
	  '10' as [c28_tipoDocOrigem], -- Atributo
	  '635255' as [c04_docOrigem], -- Atributo 
	  f.valor_total as [c06_valorPrincipal], -- Atributo
	  f.valor_total as [c10_valorTotal], -- Atributo
	  '2016-03-04' as [c14_dataVencimento], -- Atributo
	  '99999' as [c15_convenio], -- Atributo
	  'DR LING INDUSTRIA E COMERCIO S/A' as [c16_razaoSocialEmitente], -- Atributo
	  '99999999' as [c17_inscricaoEstadualEmitente], -- Atributo
	  'AV. DR. MENDEL STEINBRUCH, 10520' as [c18_enderecoEmitente], -- Atributo
	  '2307650' as [c19_municipioEmitente], -- Atributo
	  'CE' as [c20_ufEnderecoEmitente], -- Atributo 
	  '61000000' as [c21_cepEmitente], 
	  '85 32999100' as [c22_telefoneEmitente], -- Atributo
	  '1' as [c34_tipoIdentificacaoDestinatario], -- Atributo
	  RTRIM(cgc_cpf) as [c35_idContribuinteDestinatario/CNPJ/text()], -- Atributo --<CPF>...</CPF> --<CNPJ>...</CNPJ> -- </c35_idContribuinteDestinatario>
	  RTRIM(rg_ie) as [c36_inscricaoEstadualDestinatario], -- Atributo 
	  RTRIM(razao_social) as [c37_razaoSocialDestinatario], -- Atributo
	  RTRIM(m.COD_MUNICIPIO_IBGE) as [c38_municipioDestinatario], -- Atributo
	  '2016-03-07' as [c33_dataPagamento], -- Atributo
	  '01'   as [c05_referencia/periodo/text()], -- Atributo 
      '03'   as [c05_referencia/mes/text()], -- Atributo 
      '2016' as [c05_referencia/ano/text()], -- Atributo 
      '01'   as [c05_referencia/parcela/text()], -- Atributo 
	  RTRIM(ddd1)         as [c39_camposExtras/codigo/text()], -- Atributo 
	  'T'                 as [c39_camposExtras/tipo/text()], -- Atributo 
	  RTRIM(ff.chave_nfe) as [c39_camposExtras/valor/text()], -- Atributo 
	  '01' as [c42_identificadorGuia]
FROM
    w_Faturamento_imprimir f
    join lcf_lx_municipio m on m.desc_municipio = f.cidade
    join faturamento ff on ff.nf_saida=f.nf_saida and ff.serie_nf=f.serie_nf  
--FOR XML PATH('TDadosGNRE'), ROOT('guias'), root(TLote_GNRE versao="1.00" xmlns="http://www.gnre.pe.gov.br")
FOR XML PATH('TDadosGNRE'), ROOT('guias'), RAW--, ELEMENTS XSINIL
