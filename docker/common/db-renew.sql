IF EXISTS(SELECT loginname FROM syslogins WHERE loginname = '$(DB_USERNAME)')
  BEGIN
    USE [$(DB_DATABASE)];
    DROP LOGIN [$(DB_USERNAME)];
    DROP USER [$(DB_USERNAME)];
    USE [master];
  END

IF EXISTS (SELECT NAME FROM sys.databases WHERE name = '$(DB_DATABASE)')
    DROP DATABASE [$(DB_DATABASE)];
