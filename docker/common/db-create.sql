IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = '$(DB_DATABASE)')
  BEGIN
    CREATE DATABASE [$(DB_DATABASE)];
  END
