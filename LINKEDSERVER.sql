/* Criando o Linked Server */

EXEC master.dbo.sp_addlinkedserver

@server = N'Lkd65', -- Nome do Linked
@srvproduct=N'Lkd65',  -- Descrição
@provider=N'SQLNCLI10', -- Provider para SQL Server Native Client 10.0
@datasrc=N'192.168.0.65' -- Caminho do banco, ou no caso, IP do Servidor

/* Criando o login de acesso do Linked Server*/

EXEC master.dbo.sp_addlinkedsrvlogin

@rmtsrvname=N'Lkd65', -- Nome criado do Linked
@useself=N'False', -- Se outros usuários usarão
@locallogin=N'sa', -- Usuário do banco local que terá acesso
@rmtuser=N'sa', -- login do banco do outro servidor
@rmtpassword='1234' -- senha do banco do outro servidor

/* Por razões de segurança a senha do login remoto do servidor vinculado é alterada com ######## */

O Linked Server acaba de ser criado. Para verificar se a conexão foi estabelecida clique com o botão direito sobre o Linked Server “TESTE_SVR”, escolha a opção “Teste Connection”, que deverá apresentar a seguinte mensagem:

 “The teste connection to the linked server succeeded”

Leia mais em: http://www.webartigos.com/artigos/como-criar-um-linked-server-com-sql-server-2008-e-sua-utilidade/90714/#ixzz3j5zosrfi



select * from lkd11.wms_homol.dbo.wms_cores