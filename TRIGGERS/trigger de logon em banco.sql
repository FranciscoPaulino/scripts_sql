sp_who2

select loginame,hostname,program_name,cmd 
from master.dbo.sysprocesses
where program_name like '%management%'

truncate table AuditHistory

select * from master.dbo.AuditHistory
where USERNAME='SA'



sp_helptext TR_AuditLogin

Create table AuditHistory (
AuditID int identity,
SPid int,
HOST varchar(250),
Program varchar(250),
UserName varchar(250),
LoginDateTime datetime)

SELECT ORIGINAL_LOGIN()

drop TRIGGER TR_AuditLogin on all server

-- para o servidor de producção
alter TRIGGER TR_AuditLogin ON ALL SERVER
WITH EXECUTE AS SELF
FOR LOGON
AS

IF (PROGRAM_NAME() LIKE '%PHP%')
   RETURN

DECLARE @event_data XML; SET @event_data = eventdata();
DECLARE @PROGRAM VARCHAR(250)
DECLARE @SPID INT
DECLARE @USER VARCHAR(250)
DECLARE @DATA DATETIME
DECLARE @HOST VARCHAR(250)
DECLARE @BLOCKED BIT

SET @SPID = (SELECT distinct CAST(@event_data.query('/EVENT_INSTANCE/SPID/text()') AS VARCHAR(250)))
SET @HOST = (SELECT CAST(@event_data.query('/EVENT_INSTANCE/ClientHost/text()') AS VARCHAR(250)))
SET @PROGRAM = (SELECT distinct [PROGRAM_NAME] FROM SYSPROCESSES WHERE SPID = @SPID)
SET @USER = (SELECT distinct CAST(@event_data.query('/EVENT_INSTANCE/LoginName/text()') AS VARCHAR(100)))
SET @DATA = (SELECT distinct CAST(@event_data.query('/EVENT_INSTANCE/PostTime/text()') AS varchar(50)))


-- Evita gravar várias vezes um mesmo login
DECLARE @Dt_Ultima_Data DATETIME
SELECT @Dt_Ultima_Data = MAX(LoginDateTime)
FROM master.dbo.AuditHistory
WHERE UserName = @USER
AND SPID = @SPID

IF (DATEDIFF(MINUTE, ISNULL(@Dt_Ultima_Data, '1990-01-01'), @DATA) > 1)
BEGIN
	INSERT INTO AuditHistory
	VALUES (
	@SPID,
	@HOST,
	@PROGRAM,
	@USER,
	@DATA
	)
END

SET @BLOCKED = 0

IF ((@PROGRAM LIKE '%Management Studio%') or (@PROGRAM LIKE '%MS SQL Query Analyzer%')) AND 
    (@USER NOT IN('PAULINO','ALDELANIO','ARTHUR','ANDRE','WILTON','ALEXABREU'))
BEGIN
    SET @BLOCKED = 1
END

if ((@host like '%LDR-SRV-001%') or (@host like '%192.168.10.35%') or (@host like '%192.168.0.24%') or (@host like '%local machine%') or (@host like '%201.20.110.190%')) and (@USER LIKE 'sa')
BEGIN
    SET @BLOCKED = 0
END

IF @BLOCKED = 1
BEGIN
	ROLLBACK
END
GO



--- modelo de trigger de servidor
create TRIGGER [AUDIT_LOGINS] ON ALL SERVER  
FOR LOGON AS

create TRIGGER [AUDIT_LOGINS] ON ALL SERVER  
WITH EXECUTE AS SELF
FOR LOGON AS

DECLARE @event_data XML; SET @event_data = eventdata();
DECLARE @PROGRAM VARCHAR(250)
DECLARE @SPID INT
DECLARE @USER VARCHAR(250)
DECLARE @DATA DATETIME
DECLARE @HOST VARCHAR(250)
DECLARE @BLOCKED BIT

SET @SPID = (SELECT CAST(@event_data.query('/EVENT_INSTANCE/SPID/text()') AS VARCHAR(250)))
SET @HOST = (SELECT CAST(@event_data.query('/EVENT_INSTANCE/ClientHost/text()') AS VARCHAR(250)))
SET @PROGRAM = (SELECT [PROGRAM_NAME] FROM SYSPROCESSES WHERE SPID = @SPID)
SET @USER = (SELECT CAST(@event_data.query('/EVENT_INSTANCE/LoginName/text()') AS VARCHAR(100)))
SET @DATA = (SELECT CAST(@event_data.query('/EVENT_INSTANCE/PostTime/text()') AS varchar(50)))

SET @BLOCKED = 0


IF @PROGRAM LIKE '%Management Studio%' AND @USER NOT LIKE 'sa'
BEGIN
    SET @BLOCKED = 1
END

if @host like 'LDR-SRV-001'
BEGIN
    SET @BLOCKED = 0
END

INSERT INTO AuditHistory
VALUES (
@SPID,
@HOST,
@PROGRAM,
@USER,
@DATA
)

IF @BLOCKED = 1
BEGIN
    ROLLBACK
END