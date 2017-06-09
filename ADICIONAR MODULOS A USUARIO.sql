select * from USERS_MODULOS
where USUARIO='evolution'

INSERT INTO [dbo].[USERS_MODULOS]
           ([USUARIO]
           ,[MODULO]
           ,[ACESSO_MODULOS]
           ,[INCLUIR]
           ,[ALTERAR]
           ,[EXCLUIR]
           ,[PESQUISAR]
           ,[PESQUISA_ESPECIAL]
           ,[IMPRIMIR]
           ,[CRIAR_RELATORIO])
SELECT  DISTINCT    'EVOLUTION'
           ,[MODULO]
           ,[ACESSO_MODULOS]
           ,[INCLUIR]
           ,[ALTERAR]
           ,[EXCLUIR]
           ,[PESQUISAR]
           ,[PESQUISA_ESPECIAL]
           ,[IMPRIMIR]
           ,[CRIAR_RELATORIO]
FROM USERS_MODULOS
where modulo='LCF' 

