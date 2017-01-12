select * from Traces

CREATE TABLE dbo.Traces(   
    TextData VARCHAR(MAX) NULL,
    NTUserName VARCHAR(128) NULL,
    HostName VARCHAR(128) NULL,
    ApplicationName VARCHAR(128) NULL,
    LoginName VARCHAR(128) NULL,
    SPID INT NULL,
    Duration NUMERIC(15, 2) NULL,
    StartTime DATETIME NULL,
    EndTime DATETIME NULL,
    Reads INT,
    Writes INT,
    CPU INT,
    ServerName VARCHAR(128) NULL,
    DataBaseName VARCHAR(128),
    RowCounts INT,
    SessionLoginName VARCHAR(128))
   
-- Para realizar as querys de busca pela data que a query rodou.   
CREATE CLUSTERED INDEX SK01_Traces on Traces(StartTime) with(FILLFACTOR=95)


CREATE PROCEDURE [dbo].[stpCreate_Trace]
AS
BEGIN
    declare @rc int, @TraceID int, @maxfilesize bigint, @on bit, @intfilter int, @bigintfilter bigint
    select @on = 1, @maxfilesize = 50
    -- Criação do trace
    exec @rc = sp_trace_create @TraceID output, 0, N'C:\Trace\Querys_Demoradas', @maxfilesize, NULL
    if (@rc != 0) goto error
    exec sp_trace_setevent @TraceID, 10, 1, @on 
    exec sp_trace_setevent @TraceID, 10, 6, @on 
    exec sp_trace_setevent @TraceID, 10, 8, @on 
    exec sp_trace_setevent @TraceID, 10, 10, @on
    exec sp_trace_setevent @TraceID, 10, 11, @on
    exec sp_trace_setevent @TraceID, 10, 12, @on
    exec sp_trace_setevent @TraceID, 10, 13, @on
    exec sp_trace_setevent @TraceID, 10, 14, @on
    exec sp_trace_setevent @TraceID, 10, 15, @on
    exec sp_trace_setevent @TraceID, 10, 16, @on
    exec sp_trace_setevent @TraceID, 10, 17, @on
    exec sp_trace_setevent @TraceID, 10, 18, @on
    exec sp_trace_setevent @TraceID, 10, 26, @on
    exec sp_trace_setevent @TraceID, 10, 35, @on
    exec sp_trace_setevent @TraceID, 10, 40, @on
    exec sp_trace_setevent @TraceID, 10, 48, @on
    exec sp_trace_setevent @TraceID, 10, 64, @on
    exec sp_trace_setevent @TraceID, 12, 1,  @on
    exec sp_trace_setevent @TraceID, 12, 6,  @on
    exec sp_trace_setevent @TraceID, 12, 8,  @on
    exec sp_trace_setevent @TraceID, 12, 10, @on
    exec sp_trace_setevent @TraceID, 12, 11, @on
    exec sp_trace_setevent @TraceID, 12, 12, @on
    exec sp_trace_setevent @TraceID, 12, 13, @on
    exec sp_trace_setevent @TraceID, 12, 14, @on
    exec sp_trace_setevent @TraceID, 12, 15, @on
    exec sp_trace_setevent @TraceID, 12, 16, @on
    exec sp_trace_setevent @TraceID, 12, 17, @on
    exec sp_trace_setevent @TraceID, 12, 18, @on
    exec sp_trace_setevent @TraceID, 12, 26, @on
    exec sp_trace_setevent @TraceID, 12, 35, @on
    exec sp_trace_setevent @TraceID, 12, 40, @on
    exec sp_trace_setevent @TraceID, 12, 48, @on
    exec sp_trace_setevent @TraceID, 12, 64, @on
    set @bigintfilter = 3000000 -- 3 segundos
    exec sp_trace_setfilter @TraceID, 13, 0, 4, @bigintfilter
    -- Set the trace status to start
    exec sp_trace_setstatus @TraceID, 1
    goto finish
    error:
    select ErrorCode=@rc
    finish:
END

exec dbo.stpCreate_Trace

SELECT *
FROM :: fn_trace_getinfo(default)
where cast(value as varchar(50)) = 'C:\Trace\Querys_Demoradas.trc'

-- Depois de criado, vamos rodar algumas querys para testar o nosso trace.
waitfor delay '00:00:04'
GO
create procedure stpTeste_Trace1
AS
BEGIN
    waitfor delay '00:00:04'
END
GO
exec stpTeste_Trace1


-- Conferindo todos os dados que foram armazenados no trace.
Select Textdata, NTUserName, HostName, ApplicationName, LoginName, SPID, cast(Duration /1000/1000.00 as numeric(15,2)) Duration, Starttime,
    EndTime, Reads,writes, CPU, Servername, DatabaseName, rowcounts, SessionLoginName
FROM :: fn_trace_gettable('C:\Trace\Querys_Demoradas.trc', default)
where Duration is not null
order by Duration desc --Starttime


--- Para um exemplo, vou criar mais uma procedure de teste e executá-las algumas vezes.

CREATE PROCEDURE stpTeste_Trace2
AS
BEGIN
    waitfor delay '00:00:04'
END
GO
exec stpTeste_Trace1 -- Procedure ja criada
GO
exec stpTeste_Trace1
GO
exec stpTeste_Trace2
GO
exec stpTeste_Trace2
GO
exec stpTeste_Trace2
GO
exec stpTeste_Trace2
GO

--- Depois de executadas, rodarei o Job para importar o arquivo de trace para a tabela de log.
EXEC msdb..sp_start_job @job_name = 'DBA - Trace Querys Demoradas'

--- Com a query abaixo, podemos visualizar os dados armazenados no trace agrupados por procedure.

declare @Dt_Inicial datetime, @Dt_Final datetime
select @Dt_Inicial = cast(floor(cast(getdate() as float)) as datetime), @Dt_Final = cast(floor(cast(getdate()+1 as float)) as datetime)
select case    when TextData like '%stpTeste_Trace1%' then 'stpTeste_Trace1'   
        when TextData like '%stpTeste_Trace2%' then 'stpTeste_Trace2'
    else 'Outros' end Nm_Objeto,
    count(*) QTD, sum(Duration) Total, avg(Duration) Media, min(Duration) Menor, Max(Duration) Maior,
    sum(Reads) Reads, sum(writes) Writes, sum(cpu) CPU
from Traces (nolock)
where Starttime >= @Dt_Inicial and Starttime < @Dt_Final -- Periodo a ser analizado
group by case    when TextData like '%stpTeste_Trace1%' then 'stpTeste_Trace1'   
        when TextData like '%stpTeste_Trace2%' then 'stpTeste_Trace2'
    else 'Outros' end
order by Total desc
