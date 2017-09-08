sp_who
sp_who2


select session_id, 
	status, 
	command,
	blocking_session_id,
	wait_type, 
	wait_time,
	last_wait_type,
	wait_resource,
	st.text
from sys.dm_exec_requests
cross apply sys.dm_exec_sql_text(sql_handle) as st
where session_id >= 50
and session_id <> @@spid;


select * from sys.dm_os_waiting_tasks
where session_id >= 50
and session_id <> @@spid;


select st.text,
pl.query_plan,
qs.*
from sys.dm_exec_query_stats qs
cross apply sys.dm_exec_sql_text(qs.sql_handle) as st
cross apply sys.dm_exec_query_plan(qs.plan_handle) as pl;



SELECT TOP 5 total_worker_time/execution_count AS [Avg CPU Time],  
Plan_handle, query_plan   
FROM sys.dm_exec_query_stats AS qs  
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle)  
ORDER BY total_worker_time/execution_count DESC;  
GO 



select * 
from sys.dm_os_wait_stats
order by wait_time_ms desc;


select * 
from sys.dm_os_wait_stats
WHERE [wait_type] NOT IN (
        N'CLR_SEMAPHORE',    N'LAZYWRITER_SLEEP',
        N'RESOURCE_QUEUE',   N'SQLTRACE_BUFFER_FLUSH',
        N'SLEEP_TASK',       N'SLEEP_SYSTEMTASK',
        N'WAITFOR',          N'HADR_FILESTREAM_IOMGR_IOCOMPLETION',
        N'CHECKPOINT_QUEUE', N'REQUEST_FOR_DEADLOCK_SEARCH',
        N'XE_TIMER_EVENT',   N'XE_DISPATCHER_JOIN',
        N'LOGMGR_QUEUE',     N'FT_IFTS_SCHEDULER_IDLE_WAIT',
        N'BROKER_TASK_STOP', N'CLR_MANUAL_EVENT',
        N'CLR_AUTO_EVENT',   N'DISPATCHER_QUEUE_SEMAPHORE',
        N'TRACEWRITE',       N'XE_DISPATCHER_WAIT',
        N'BROKER_TO_FLUSH',  N'BROKER_EVENTHANDLER',
        N'FT_IFTSHC_MUTEX',  N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP',
        N'DIRTY_PAGE_POLL',  N'SP_SERVER_DIAGNOSTICS_SLEEP')
order by wait_time_ms desc;


select db_name(io.database_id) as database_name,
	mf.physical_name as file_name,
	io.* 
from sys.dm_io_virtual_file_stats(NULL, NULL) io
join sys.master_files mf on mf.database_id = io.database_id 
	and mf.file_id = io.file_id
order by (io.num_of_bytes_read + io.num_of_bytes_written) desc;


select st.text,
pl.query_plan,
qs.*
from sys.dm_exec_query_stats qs
cross apply sys.dm_exec_sql_text(qs.sql_handle) as st
cross apply sys.dm_exec_query_plan(qs.plan_handle) as pl;

select st.text,
pl.query_plan,
qs.*
from sys.dm_exec_query_stats qs
cross apply sys.dm_exec_sql_text(qs.sql_handle) as st
cross apply sys.dm_exec_query_plan(qs.plan_handle) as pl
--where st.text like '%PRODUTOS_FALTAS%'
order by execution_count desc;

DBCC FREEPROCCACHE (0x0300130077BD152F5BAE7E0084A500000000000000000000);  
GO  


SELECT 
    substring(text,qs.statement_start_offset/2
        ,(CASE    
            WHEN qs.statement_end_offset = -1 THEN len(convert(nvarchar(max), text)) * 2 
            ELSE qs.statement_end_offset 
        END - qs.statement_start_offset)/2) 
    ,qs.plan_generation_num as recompiles
    ,qs.execution_count as execution_count
    ,qs.total_elapsed_time - qs.total_worker_time as total_wait_time
    ,qs.total_worker_time as cpu_time
    ,qs.total_logical_reads as reads
    ,qs.total_logical_writes as writes
FROM sys.dm_exec_query_stats qs
    CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
    LEFT JOIN sys.dm_exec_requests r 
        ON qs.sql_handle = r.sql_handle
ORDER BY 3 DESC






SELECT es.session_id
    ,es.program_name
    ,es.login_name
    ,es.nt_user_name
    ,es.login_time
    ,es.host_name
    ,es.cpu_time
    ,es.total_scheduled_time
    ,es.total_elapsed_time
    ,es.memory_usage
    ,es.logical_reads
    ,es.reads
    ,es.writes
    ,st.text	
FROM sys.dm_exec_sessions es
    LEFT JOIN sys.dm_exec_connections ec 
        ON es.session_id = ec.session_id
    LEFT JOIN sys.dm_exec_requests er
        ON es.session_id = er.session_id
    OUTER APPLY sys.dm_exec_sql_text (er.sql_handle) st
WHERE es.session_id > 50    -- < 50 system sessions
ORDER BY es.cpu_time DESC


/*Listing 1.18*/
SELECT  [cp].[refcounts] ,
        [cp].[usecounts] ,
        [cp].[objtype] ,
        [st].[dbid] ,
        [st].[objectid] ,
        [st].[text] ,
        [qp].[query_plan]
FROM    sys.dm_exec_cached_plans cp
        CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st
        CROSS APPLY sys.dm_exec_query_plan(cp.plan_handle) qp;

