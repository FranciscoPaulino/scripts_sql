SELECT *
FROM sys.dm_exec_sessions
where login_name = 'fiorucci'

USE master

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_killIdleConections]') and objectproperty(id,N'isprocedure') = 1)
drop procedure [dbo].[sp_killIdleConections]
go

SP_HELPTEXT sp_killIdleConections

EXEC sp_killIdleConections

--- procedure para matar processo inativo por mais de 3 minutos
create procedure [dbo].[sp_killIdleConections] as

begin    
 declare @KillIdleProcesses as varchar(max);    
 set @KillIdleProcesses = ''    
 select @KillIdleProcesses = @KillIdleProcesses + 'kill ' + convert(nvarchar(8), spid) + '; '    
 from master.dbo.sysprocesses    
 where last_batch < dateadd(minute, -15, getdate())    
 and dbid > 5    
 and status='sleeping'    
 and open_tran = 0    
 and loginame in ('fiorucci','elite','juliete','itaitinga','afrodite','athena')     
 exec (@KillIdleProcesses)    
end  


select * from master.dbo.sysprocesses
where last_batch < dateadd(minute, -3, getdate())
and dbid > 5
and STATUS='SLEEPING'
and open_tran = 0
and loginame = 'fiorucci' -- caso seja necessário não derrubar o usuário abcd

select dateadd(minute, -3, getdate())

sp_who2

kill 108

sp_helptext sp_killIdleConections