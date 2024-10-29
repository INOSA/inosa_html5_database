#!/usr/bin/env bash
DB_NAME=${1}
/opt/mssql-tools/bin/sqlcmd -C -S localhost -U sa -P $SA_PASSWORD -d $DB_NAME -i /opt/docker/common/update_db_config.sql
DB_DATABASE=$DB_NAME /opt/mssql-tools/bin/sqlcmd -C -S localhost -U sa -P $SA_PASSWORD -i /opt/docker/common/update_access_to_db.sql
