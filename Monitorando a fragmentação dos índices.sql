CREATE TABLE [dbo].[Hitorico_Fragmentacao_Indice](
[Id_Hitorico_Fragmentacao_Indice] [int] IDENTITY(1,1) NOT NULL,
[Dt_Referencia] [datetime] NULL,
[Nm_Servidor] [varchar](50) NULL,
[Nm_Database] [varchar](50) NULL,
[Nm_Tabela] [varchar](50) NULL,
[Nm_Indice] [varchar](70) NULL,
[Avg_Fragmentation_In_Percent] [numeric](5, 2) NULL,
[Page_Count] [int] NULL,
[Fill_Factor] [tinyint] NULL)



INSERT INTO Hitorico_Fragmentacao_Indice(Dt_Referencia,Nm_Servidor,Nm_Database,Nm_Tabela,Nm_Indice,Avg_Fragmentation_In_Percent,Page_Count,Fill_Factor)
SELECT getdate(), @@servername,db_name(db_id()), object_name(B.Object_id), B.Name, A.avg_fragmentation_in_percent, A.page_Count, B.fill_factor
FROM sys.dm_db_index_physical_stats(db_id(),null,null,null,null) A
join sys.indexes B on a.object_id = B.Object_id and A.index_id = B.index_id
where avg_fragmentation_in_percent > 10
ORDER BY object_name(B.Object_id), B.index_id



declare @Dt_Referencia datetime
set @Dt_Referencia = cast(floor(cast( getdate() as float)) as datetime)

SELECT Nm_Servidor, Nm_Database, Nm_Tabela, Nm_Indice, Avg_Fragmentation_In_Percent, Page_Count, Fill_Factor
FROM Hitorico_Fragmentacao_Indice (nolock)
WHERE Avg_Fragmentation_In_Percent > 5
AND page_count > 1000   -- Eliminar índices pequenos
AND Dt_Referencia >= @Dt_Referencia




DBCC INDEXDEFRAG (desenv, 'PRODUCAO_RECURSOS_FASE', XPKPRODUCAO_RECURSOS_FASE);

/*Perform a 'USE <database name>' to select the database in which to run the script.*/
-- Declare variables
SET NOCOUNT ON;
DECLARE @tablename varchar(255);
DECLARE @execstr   varchar(400);
DECLARE @objectid  int;
DECLARE @indexid   int;
DECLARE @frag      decimal;
DECLARE @maxfrag   decimal;

-- Decide on the maximum fragmentation to allow for.
SELECT @maxfrag = 30.0;

-- Declare a cursor.
DECLARE tables CURSOR FOR
   SELECT TABLE_SCHEMA + '.' + TABLE_NAME
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_TYPE = 'BASE TABLE';

-- Create the table.
CREATE TABLE #fraglist (
   ObjectName char(255),
   ObjectId int,
   IndexName char(255),
   IndexId int,
   Lvl int,
   CountPages int,
   CountRows int,
   MinRecSize int,
   MaxRecSize int,
   AvgRecSize int,
   ForRecCount int,
   Extents int,
   ExtentSwitches int,
   AvgFreeBytes int,
   AvgPageDensity int,
   ScanDensity decimal,
   BestCount int,
   ActualCount int,
   LogicalFrag decimal,
   ExtentFrag decimal);

-- Open the cursor.
OPEN tables;

-- Loop through all the tables in the database.
FETCH NEXT
   FROM tables
   INTO @tablename;

WHILE @@FETCH_STATUS = 0
BEGIN
-- Do the showcontig of all indexes of the table
   INSERT INTO #fraglist 
   EXEC ('DBCC SHOWCONTIG (''' + @tablename + ''') 
      WITH FAST, TABLERESULTS, ALL_INDEXES, NO_INFOMSGS');
   FETCH NEXT
      FROM tables
      INTO @tablename;
END;

-- Close and deallocate the cursor.
CLOSE tables;
DEALLOCATE tables;

-- Declare the cursor for the list of indexes to be defragged.
DECLARE indexes CURSOR FOR
   SELECT ObjectName, ObjectId, IndexId, LogicalFrag
   FROM #fraglist
   WHERE LogicalFrag >= @maxfrag
      AND INDEXPROPERTY (ObjectId, IndexName, 'IndexDepth') > 0;

-- Open the cursor.
OPEN indexes;

-- Loop through the indexes.
FETCH NEXT
   FROM indexes
   INTO @tablename, @objectid, @indexid, @frag;

WHILE @@FETCH_STATUS = 0
BEGIN
   PRINT 'Executing DBCC INDEXDEFRAG (0, ' + RTRIM(@tablename) + ',
      ' + RTRIM(@indexid) + ') - fragmentation currently '
       + RTRIM(CONVERT(varchar(15),@frag)) + '%';
   SELECT @execstr = 'DBCC INDEXDEFRAG (0, ' + RTRIM(@objectid) + ',
       ' + RTRIM(@indexid) + ')';
   EXEC (@execstr);

   FETCH NEXT
      FROM indexes
      INTO @tablename, @objectid, @indexid, @frag;
END;

-- Close and deallocate the cursor.
CLOSE indexes;
DEALLOCATE indexes;

-- Delete the temporary table.
DROP TABLE #fraglist;
GO
