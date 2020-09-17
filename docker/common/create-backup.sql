DECLARE @FileName varchar(200)
SELECT @FileName='/var/opt/mssql/backups/inosa_db_' + REPLACE(convert(nvarchar(20),GetDate(),120),':','-') + '.bak'
BACKUP DATABASE [inosa] TO DISK=@FileName