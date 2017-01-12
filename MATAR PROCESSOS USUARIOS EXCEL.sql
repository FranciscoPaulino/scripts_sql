declare @output varchar(max);
set @output = ''

select @output = @output + 'kill ' + cast(spid as varchar(max)) + ';' from (select distinct spid,PROGRAM_NAME from sys.sysprocesses 
where program_name like '%Microsoft Office%' ) as sysprocesses

select @output

exec(@output)