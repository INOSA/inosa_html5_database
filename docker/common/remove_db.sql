USE master;

DECLARE @kill varchar(8000);
SET @kill = '';
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), spid) + ';'
FROM master..sysprocesses
WHERE dbid = db_id('$(DB_TO_REMOVE)')
EXEC (@kill);

drop database [$(DB_TO_REMOVE)];
