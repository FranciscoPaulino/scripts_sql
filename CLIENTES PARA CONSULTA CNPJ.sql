SELECT B.CGC_CPF,A.CLIENTE_ATACADO,COUNT(A.PEDIDO) FROM VENDAS A WITH (NOLOCK)
JOIN CADASTRO_CLI_FOR B WITH (NOLOCK) ON B.NOME_CLIFOR=A.CLIENTE_ATACADO
WHERE A.TOT_QTDE_ENTREGAR>0 AND B.PJ_PF=1 AND B.UF<>'EX'
AND A.TABELA_FILHA='VENDAS_PRODUTO' 
AND A.PERIODO_PCP LIKE '2015%'
AND B.CGC_CPF NOT IN 
(
SELECT CNPJ=SUBSTRING(REPLACE(REPLACE(REPLACE(numero_inscricao,'.',''),'/',''),'-',''),1,14) FROM SAW_Consulta_Receita_CNPJ WITH (NOLOCK) WHERE numero_inscricao <> '' 
)
GROUP BY B.CGC_CPF,A.CLIENTE_ATACADO
HAVING COUNT(A.PEDIDO) = 1
ORDER BY B.CGC_CPF


SELECT cnpj=SUBSTRING(replace(replace(replace(numero_inscricao,'.',''),'/',''),'-',''),1,14),* FROM SAW_Consulta_Receita_CNPJ 
order by data_emissao


SELECT * FROM SAW_Consulta_Receita_CNPJ
order by data_pesquisa desc


UPDATE SAW_Consulta_Receita_CNPJ
SET numero_inscricao='11.548.835/0001-05'

delete from SAW_Consulta_Receita_CNPJ
where desc_erro <> ''

SELECT * from SAW_Consulta_Receita_CNPJ
where desc_erro <> ''


---- Cruzamento de informações cadastro_cli_for x consuta receita federal
SELECT cnpj=SUBSTRING(replace(replace(replace(numero_inscricao,'.',''),'/',''),'-',''),1,14),
cep=SUBSTRING(replace(replace(B.cep,'.',''),'-',''),1,10),
A.CEP,
B.titulo_estabelecimento,
A.NOME_CLIFOR,
B.nome_empresarial,
A.RAZAO_SOCIAL, 
B.logradouro,
A.ENDERECO,
B.numero,
A.NUMERO,
B.complemento,
A.COMPLEMENTO,
B.bairro,
A.BAIRRO,
B.municipio,
A.CIDADE,
B.uf,
A.UF
FROM CADASTRO_CLI_FOR A
JOIN ( SELECT cnpj=SUBSTRING(replace(replace(replace(numero_inscricao,'.',''),'/',''),'-',''),1,14),* FROM SAW_Consulta_Receita_CNPJ WHERE numero_inscricao IS NOT NULL) 
B ON B.CNPJ=A.CGC_CPF
WHERE B.nome_empresarial<>A.RAZAO_SOCIAL
--OR SUBSTRING(replace(replace(B.cep,'.',''),'-',''),1,10) <> A.CEP
--OR B.logradouro <> A.ENDERECO
--OR B.numero <> A.NUMERO
--OR B.complemento <> A.COMPLEMENTO
--OR B.bairro <> A.BAIRRO
--OR B.municipio <> A.CIDADE
--OR B.uf <> A.UF
order by cnpj



--- CONSULTA DE RAZÃO SOCIAL 
SELECT A.RAZAO_SOCIAL,B.nome_empresarial
FROM CADASTRO_CLI_FOR A
JOIN ( SELECT cnpj=SUBSTRING(replace(replace(replace(numero_inscricao,'.',''),'/',''),'-',''),1,14),* FROM SAW_Consulta_Receita_CNPJ WHERE numero_inscricao IS NOT NULL) 
B ON B.CNPJ=A.CGC_CPF


--- ATUALIZAÇÃO DE RAZÃO SOCIAL LINX COM RFB
UPDATE CADASTRO_CLI_FOR
SET CADASTRO_CLI_FOR.RAZAO_SOCIAL=B.NOME_EMPRESARIAL
FROM CADASTRO_CLI_FOR A
JOIN ( SELECT cnpj=SUBSTRING(replace(replace(replace(numero_inscricao,'.',''),'/',''),'-',''),1,14),* FROM SAW_Consulta_Receita_CNPJ WHERE numero_inscricao IS NOT NULL) 
B ON B.CNPJ=A.CGC_CPF

