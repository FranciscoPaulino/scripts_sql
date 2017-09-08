use desenv

CREATE TABLE dbo.Traces (
    [TextData] VARCHAR(MAX) NULL,
    [NTUserName] VARCHAR(128) NULL,
    [HostName] VARCHAR(128) NULL,
    [ApplicationName] VARCHAR(128) NULL,
    [LoginName] VARCHAR(128) NULL,
    [SPID] INT NULL,
    [Duration] NUMERIC(15, 2) NULL,
    [StartTime] DATETIME NULL,
    [EndTime] DATETIME NULL,
    [Reads] INT,
    [Writes] INT,
    [CPU] INT,
    [ServerName] VARCHAR(128) NULL,
    [DataBaseName] VARCHAR(128),
    [RowCounts] INT,
    [SessionLoginName] VARCHAR(128)
)

-- Para realizar as querys de busca pela data que a query rodou.    
CREATE CLUSTERED INDEX [SK01_Traces] ON [Traces]([StartTime]) WITH(FILLFACTOR = 95)





CREATE PROCEDURE [dbo].[stpCreate_Trace]
AS
BEGIN
    DECLARE @rc INT, @TraceID INT, @maxfilesize BIGINT, @on BIT, @intfilter INT, @bigintfilter BIGINT
    SELECT @on = 1, @maxfilesize = 50
    
    -- Cria��o do trace
    EXEC @rc = [dbo].[sp_trace_create] @TraceID OUTPUT, 0, N'C:\Trace\Querys_Demoradas', @maxfilesize, NULL
    
    IF (@rc != 0) GOTO error
    
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 1,  @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 6,  @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 8,  @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 10, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 11, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 12, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 13, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 14, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 15, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 16, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 17, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 18, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 26, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 35, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 40, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 48, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 10, 64, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 1,  @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 6,  @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 8,  @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 10, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 11, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 12, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 13, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 14, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 15, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 16, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 17, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 18, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 26, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 35, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 40, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 48, @on
    EXEC [dbo].[sp_trace_setevent] @TraceID, 12, 64, @on
    
    SET @bigintfilter = 3000000 -- 3 segundos
    
    EXEC [dbo].[sp_trace_setfilter] @TraceID, 13, 0, 4, @bigintfilter
    
    -- Set the trace status to start
    EXEC [dbo].[sp_trace_setstatus] @TraceID, 1
    
    GOTO finish
    
    error:
		SELECT ErrorCode = @rc
    finish:
END


EXEC [dbo].[stpCreate_Trace]


SELECT *
FROM :: fn_trace_getinfo(default)
WHERE CAST([value] AS VARCHAR(50)) = 'C:\Trace\Querys_Demoradas.trc'


WAITFOR DELAY '00:00:04'

GO
CREATE PROCEDURE [dbo].[stpTeste_Trace1]
AS
BEGIN
    WAITFOR DELAY '00:00:04'
END

GO
EXEC [dbo].[stpTeste_Trace1]

-- Conferindo todos os dados que foram armazenados no trace.
SELECT	[Textdata], [NTUserName], [HostName], [ApplicationName], [LoginName], [SPID], CAST([Duration] / 1000/ 1000.00 AS NUMERIC(15, 2)) [Duration],
		[Starttime], [EndTime], [Reads],[writes], [CPU], [Servername], [DatabaseName], [rowcounts], [SessionLoginName]
FROM :: fn_trace_gettable('C:\Trace\Querys_Demoradas.trc', default)
WHERE [Duration] IS NOT NULL
ORDER BY [Starttime]




---No meu ambiente, identifico as procedures que mais retornam no trace e realizo um agrupamento, 
---como feito abaixo, para facilitar minha visualiza��o di�ria. Para um exemplo, vou criar mais 
---uma procedure de teste e execut�-las algumas vezes.

CREATE PROCEDURE [dbo].[stpTeste_Trace2]
AS
BEGIN
    WAITFOR DELAY '00:00:04'
END
GO
EXEC [dbo].[stpTeste_Trace1] -- Procedure ja criada
GO
EXEC [dbo].[stpTeste_Trace1]
GO
EXEC [dbo].[stpTeste_Trace2]
GO
EXEC [dbo].[stpTeste_Trace2]
GO
EXEC [dbo].[stpTeste_Trace2]
GO
EXEC [dbo].[stpTeste_Trace2]
GO

--- Depois de executadas, rodarei o Job para importar o arquivo de trace para a tabela de log.
EXEC [msdb].DBO.[sp_start_job] @job_name = 'DBA � Trace Querys Demoradas'


--- Com a query abaixo, podemos visualizar os dados armazenados no trace agrupados por procedure.
DECLARE @Dt_Inicial DATETIME, @Dt_Final DATETIME

SELECT	@Dt_Inicial = CAST(FLOOR(CAST(GETDATE() AS FLOAT)) AS DATETIME), 
		@Dt_Final = CAST(FLOOR(CAST(GETDATE()+1 AS FLOAT)) AS DATETIME)

SELECT	[TextData],
		COUNT(*) [QTD], 
		SUM([Duration]) [Total], 
		AVG([Duration]) [Media], 
		MIN([Duration]) [Menor], 
		MAX([Duration]) [Maior],
		SUM([Reads]) [Reads], 
		SUM([writes]) [Writes], 
		SUM([cpu]) [CPU]
FROM [dbo].[Traces] WITH(NOLOCK)
WHERE [Starttime] >= @Dt_Inicial AND [Starttime] < @Dt_Final -- Periodo a ser analizado
GROUP BY [TextData]
ORDER BY [Total] DESC

SELECT * FROM [dbo].[Traces] WITH(NOLOCK)
