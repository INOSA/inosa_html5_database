#!/usr/bin/env bash
#define params
renew='false'

/opt/mssql/bin/sqlservr > /tmp/sql.log &

while ! grep -m1 'The tempdb database has 8 data file(s).' < /tmp/sql.log; do
	sleep 1
done

# parse arguments
while [ $# -gt 0 ]; do
    case "$1" in
        # additional options
        -r|--renew)
            renew='true'
        ;;
        # bad argument
        *)
            echo -e "\e[31mError: $1 is invalid argument.\e[0m"
            echo ""
            exit 1
    esac
    shift
done

# pull before build
if [ "${renew}" == "true" ]; then
    echo -e "\e[33m========================================\e[0m"
    echo -e "\e[33m= Resetting database and user settings =\e[0m"
    echo -e "\e[33m========================================\e[0m"
    /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i /opt/docker/common/db-renew.sql
fi

# create db and user
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i /opt/docker/common/db-create.sql
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -i /opt/docker/common/db-login.sql

## confirm that db and user exists
echo -e "\e[32mDatabase schema:\e[0m"
/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD -S localhost -Q "SELECT loginname, dbname FROM syslogins"

if [[ ! -f "/var/already-started" ]]; then
if ls /start-scripts | grep -q .sql; then
  for f in /start-scripts/*.sql
  do
    echo "processing: $f"
    /opt/mssql-tools/bin/sqlcmd -S localhost -U $DB_USERNAME -P $DB_PASSWORD -i $f
  done
  touch /var/already-started
else
  echo "you can put sql scripts in /start-scripts"
fi
fi

echo "DATABASE IS READY"

wait
