DB_NAME=${1}

DB_TO_REMOVE=$DB_NAME /opt/mssql-tools/bin/sqlcmd -C -S localhost -U sa -P $SA_PASSWORD -i /opt/docker/common/remove_db.sql
