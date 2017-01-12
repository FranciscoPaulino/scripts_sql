select * from SAW_CONSULTA_RECEITA_CNPJ
DELETE  from SAW_CONSULTA_RECEITA_CNPJ

EXEC SP_INSERT_SAW_CONSULTA_RECEITA_CNPJ  
'1',
'1',
'1',
'1',
'1',
'1',
'1',
'1',
'1',
'1',
'1',
'1',
'ce',
'1',
'1',
'1',
'1',
'1',
'1',
'1',
'1',
1,
'1','20140711'


ALTER proc SP_INSERT_SAW_CONSULTA_RECEITA_CNPJ 
@numero_inscricao varchar(30),
@data_abertura varchar(30),
@nome_empresarial varchar(max),
@titulo_estabelecimento varchar(max),
@atividade_principal varchar(max),
@natureza_juridica varchar(max),
@logradouro varchar(max),
@numero varchar(10),
@complemento varchar(max),
@cep varchar(10),
@bairro varchar(max),
@municipio varchar(30),
@uf char(2),
@situacao_cadastral varchar(30),
@data_situacao_cadastral varchar(30),
@motivo_situacao_cadastral varchar(max),
@situacao_especial varchar(max),
@data_situacao_especial varchar(30),
@aprovado_por varchar(max),
@data_emissao varchar(30),
@html varchar(max),
@cod_erro int,
@desc_erro varchar(max),
@data_pesquisa datetime
AS 
INSERT INTO SAW_Consulta_Receita_CNPJ
(numero_inscricao,data_abertura,nome_empresarial,titulo_estabelecimento,atividade_principal
,natureza_juridica,logradouro,numero,complemento,cep,bairro,municipio,uf
,situacao_cadastral,data_situacao_cadastral,motivo_situacao_cadastral
,situacao_especial,data_situacao_especial,aprovado_por,data_emissao,html,cod_erro,desc_erro,data_pesquisa) 
VALUES (@numero_inscricao,@data_abertura,@nome_empresarial,@titulo_estabelecimento,
        @atividade_principal,@natureza_juridica,@logradouro,@numero,@complemento,
        @cep,@bairro,@municipio,@uf,@situacao_cadastral,@data_situacao_cadastral,
        @motivo_situacao_cadastral,@situacao_especial,@data_situacao_especial,@aprovado_por,
        @data_emissao,@html,@cod_erro,@desc_erro,@data_pesquisa)
GO


