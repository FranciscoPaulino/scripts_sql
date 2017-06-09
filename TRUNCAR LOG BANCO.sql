 USE master
 GO
 SELECT database_id [ID],  name [Banco], compatibility_level [Versao],
 recovery_model_desc [Model] FROM sys.databases
 GO
 ALTER DATABASE ponto_fortes SET RECOVERY SIMPLE
 GO
 use ponto_fortes
 GO
 sp_helpfile
 GO
 DBCC SHRINKFILE (Ponto_Fortes, 1)
 GO

 BACKUP LOG [Ponto_Fortes] WITH TRUNCATE_ONLY 
 DBCC SHRINKFILE (banco_log,10000)