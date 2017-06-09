/* Criando o Linked Server */

EXEC master.dbo.sp_addlinkedserver

@server = N'Lkd65', -- Nome do Linked
@srvproduct=N'Lkd65',  -- Descri��o
@provider=N'SQLNCLI10', -- Provider para SQL Server Native Client 10.0
@datasrc=N'192.168.0.65' -- Caminho do banco, ou no caso, IP do Servidor

/* Criando o login de acesso do Linked Server*/

EXEC master.dbo.sp_addlinkedsrvlogin

@rmtsrvname=N'Lkd65', -- Nome criado do Linked
@useself=N'False', -- Se outros usu�rios usar�o
@locallogin=N'sa', -- Usu�rio do banco local que ter� acesso
@rmtuser=N'sa', -- login do banco do outro servidor
@rmtpassword='1234' -- senha do banco do outro servidor

/* Por raz�es de seguran�a a senha do login remoto do servidor vinculado � alterada com ######## */

O Linked Server acaba de ser criado. Para verificar se a conex�o foi estabelecida clique com o bot�o direito sobre o Linked Server �TESTE_SVR�, escolha a op��o �Teste Connection�, que dever� apresentar a seguinte mensagem:

 �The teste connection to the linked server succeeded�

Leia mais em: http://www.webartigos.com/artigos/como-criar-um-linked-server-com-sql-server-2008-e-sua-utilidade/90714/#ixzz3j5zosrfi



select * from lkd11.wms_homol.dbo.wms_cores