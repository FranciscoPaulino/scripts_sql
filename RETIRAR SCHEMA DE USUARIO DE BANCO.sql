EXEC sp_dropuser 'paulino'

SELECT name FROM  sys.schemas WHERE principal_id = USER_ID('paulino')

-- mudar todos os schema encontardos para o usuario e mudar para DBO
ALTER AUTHORIZATION ON SCHEMA::DBAs TO dbo 

DROP USER PAULINO