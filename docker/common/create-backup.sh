#!/usr/bin/env bash
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i /opt/docker/common/create-backup.sql