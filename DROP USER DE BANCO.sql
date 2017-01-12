select 'EXEC sp_dropuser '''+name+'''' FROM SYSUSERS
WHERE altuid IS NULL
ORDER BY name


EXEC sp_dropuser 'dbo'
EXEC sp_dropuser 'guest'
EXEC sp_dropuser 'INFORMATION_SCHEMA'
EXEC sp_dropuser 'sys'
EXEC sp_dropuser 'WILTON'
EXEC sp_dropuser 'WINTON'
EXEC sp_dropuser 'YANE'
EXEC sp_dropuser 'YANE3'
EXEC sp_dropuser 'YLKA'
EXEC sp_dropuser 'YSABELE'
EXEC sp_dropuser 'ZE CARLOS'
EXEC sp_dropuser 'ZINHA'
