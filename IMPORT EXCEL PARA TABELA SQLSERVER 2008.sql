/* Criando a tabela com os meus atributos da planilha */
create table nfe_devolucao(
codigo_item varchar(max),    qtde_dev int
)

/* Comando para importar a planilha na tabela */
update B
SET B.INATIVA=F7
FROM OPENROWSET ('Microsoft.Ace.OLEDB.12.0'
,'Excel 12.0; Database=c:\temp\contas.xls; Extended Properties=''EXCEL 12.0;HDR=NO;IMEX=1'
,'SELECT * FROM [contas$]') AS A
JOIN CTB_CONTA_PLANO B ON B.CONTA_CONTABIL=A.F1 COLLATE SQL_Latin1_General_CP1_CI_AS


SELECT  f1 as conta_contabil,f2 as codigo_resumido,f3 as rateio_centro_custo,f4 as desc_conta,
f5 as desc_detalhada,f6 as desc_conta_reduzida, f7 as inativa
FROM OPENROWSET ('Microsoft.Ace.OLEDB.12.0'
,'Excel 12.0; Database=c:\temp\contas.xls; Extended Properties=''EXCEL 12.0;HDR=NO;IMEX=1'
,'SELECT * FROM [contas$]') AS A
JOIN CTB_CONTA_PLANO B ON B.CONTA_CONTABIL=A.F1 COLLATE SQL_Latin1_General_CP1_CI_AS

-- pedido C&A
-- CODIGO C&A 511476
SELECT  *
FROM OPENROWSET ('Microsoft.Ace.OLEDB.12.0'
,'Excel 12.0; Database=c:\temp\ceapedido.xlsx; Extended Properties=''EXCEL 12.0;HDR=NO;IMEX=1'
,'SELECT * FROM [cea$]') AS A



/* Criando a tabela com os meus atributos da planilha */
create table nfe_itens(
codigo_item varchar(max),    qtde_item int
)

/* Comando para importar a planilha na tabela */
INSERT INTO nfe_itens (qtde_item,codigo_item)
SELECT  f7,f9
FROM OPENROWSET ('Microsoft.Ace.OLEDB.12.0'
,'Excel 12.0; Database=c:\temp\qtde_itens2.XLSx; Extended Properties=''EXCEL 12.0;HDR=NO;IMEX=1'
,'SELECT * FROM [qtde_itens2$]')


select * from nfe_devolucao a
left join nfe_itens b on b.codigo_item=a.codigo_item and b.qtde_item=a.qtde_dev
where b.codigo_item is null


--- import de arquivo .csv
select * --into CLIENTES_AC 
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\temp','select * from funcionarios_ac_abr_2017_linx.csv') as a
left join (select distinct local_log,cep8_log from cadcep) b on b.cep8_log=a.cep COLLATE SQL_Latin1_General_CP1_CI_AS --and b.nome_log=a.endereco COLLATE SQL_Latin1_General_CP1_CI_AS
--left join LCF_LX_MUNICIPIO c on c.DESC_MUNICIPIO=b.local_log
--left join LCF_LX_UF d on d.ID_UF=c.ID_UF


--- import de arquivo .csv
select * --COLLATE SQL_Latin1_General_CP1_CI_AS
from OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database=C:\temp','select * from NeoGrid_marisa.txt') as a 
--where neogrid#com is not null


declare @p4 varchar(8000)
set @p4='407859'
exec sp_executesql N'
/* VISUALLINX ExecuteNonQuery()  */
  EXEC LX_SEQUENCIAL @TABELA_COLUNA = ''clientes_atacado.clifor'', @EMPRESA = @P1, @SEQUENCIA = @P2 OUTPUT, @UPDATE_SEQUENCIAL = 1, @NEWVALUE = ''''',N'@P1 int,@P2 varchar(8000) OUTPUT',1,@p4 output
select @p4


select * from cadcep
where cep8_log='61932580'


select * from LCF_LX_MUNICIPIO
