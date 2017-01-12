LX_CADE_COLUNA SK_ITEM

LX_CADE_COLUNA id_genero_item

-----------------------------------------------------------------------------------

SELECT left(codigo_item,10) as codigo, * FROM entradas_item
where referencia is null

update entradas_item set REFERENCIA = left(codigo_item,10)
where referencia is null

SELECT * FROM faturamento_item
where referencia is null

update faturamento_item set REFERENCIA = CODIGO_ITEM
where referencia is null

----------------------------------------------------------------------

select TIPO_ITEM_SPED,* from CADASTRO_ITEM_FISCAL where tipo_item_sped is null

select TIPO_ITEM_SPED,* from PRODUTOS where tipo_item_sped is null

select TIPO_ITEM_SPED, * from materiais where tipo_item_sped is null

------------------------------------------------------------------------
--primeiro vc tem que alterar a tabela lcf_nota_saida_item, 
--mudando a coluna sk_item para que ela permita campo null....


alter table lcf_nota_saida_item ALTER COLUMN sk_item int null

INSERT INTO LCF_LX_ITEM_GENERO
           (DESC_GENERO
           ,COD_GENERO_SPED)
     VALUES
          ('MATÉRIAS ALBUMINÓIDES; PRODUTOS À BASE DE AMIDOS OU DE FÉCULAS MODIFICADOS; COLAS; ENZIMAS',
          '34')
          
GO


select * from lcf_nota_saida
where id_nota = '32627'

select * from lcf_nota_entrada_item
where desc_item_nf = 'EXAUSTOR 30 CM 220V'
where id_nota = '32627' and preco_unitario = '47.98000'


select * from faturamento_item
where (nf_saida = '000027' or nf_saida = '000028') and preco_unitario = '230.00000'

select * from faturamento
where nf_saida = '000027'

--aí você importa o sped....
--ele vai importar o campo null.
------------------------------------------------------------------------
select distinct(NF_ENTRADA),a.*  
from LCF_NOTA_entrada_ITEM as a 
inner join  LCF_NOTA_ENTRADA as b
on a.ID_NOTA=b.ID_NOTA
where SK_ITEM is null


select distinct(NF_SAIDA),a.*  
from LCF_NOTA_SAIDA_ITEM as a 
inner join  LCF_NOTA_SAIDA as b
on a.ID_NOTA=b.ID_NOTA
where SK_ITEM is null

update a set sk_item = '1748'
from LCF_NOTA_SAIDA_ITEM as a 
inner join  LCF_NOTA_SAIDA as b
on a.ID_NOTA=b.ID_NOTA
where SK_ITEM is null

select distinct(NF_ENTRADA),a.*  
from lcf_nota_entrada_item as a 
inner join  lcf_nota_entrada as b
on a.ID_NOTA=b.ID_NOTA
--where SK_ITEM is null
where desc_item_nf = 'EXAUSTOR 30 CM 220V'


-------------------------------------------------------------------------

--humm.... se ele fizer ordem de serviço, pode serv o seguinte tbm... eu não sei porque em alguns clientes ao fazer a ordem de serviço, o cmapo refrencia e o campo codigo_item, assumem o formato numero da ordem + código do produto.... sendo que não deveria...
--o campo codigo_item deveria ser o numero da ordem + o produto, ma so código do item deveria ser apenas o código do produto;;;;;;
--senão o sistema não encontra  o item, mesmo ele estando cadastrado no linx...
--se ocorre isso é só dar um update no campo referencia, deixando o campo apenas com o código do item;;;

---------------------------------

select * from CLASSIF_FISCAL
where COD_GENERO_SPED is null

update CLASSIF_FISCAL set COD_GENERO_SPED = LEFT(classif_fiscal,2)
where COD_GENERO_SPED is null


