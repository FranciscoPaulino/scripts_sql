/* Criando a tabela com os meus atributos da planilha */
create table nfe_devolucao(
codigo_item varchar(max),    qtde_dev int
)

/* Comando para importar a planilha na tabela */
INSERT INTO nfe_devolucao (qtde_dev,codigo_item)
SELECT  f13,f15
FROM OPENROWSET ('Microsoft.Ace.OLEDB.12.0'
,'Excel 12.0; Database=c:\temp\qtde_dev2.XLSx; Extended Properties=''EXCEL 12.0;HDR=NO;IMEX=1'
,'SELECT * FROM [qtde_dev2$]')


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

