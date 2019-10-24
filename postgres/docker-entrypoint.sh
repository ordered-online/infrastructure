#!/bin/sh
set -e
set -u

while ! nc -z localhost:5432; do
        sleep 0.1
done

if [ -n "$POSTGRES_DATABASES" ]; then
	echo "Multiple database creation requested: $POSTGRES_DATABASES"
	for database in $(echo $POSTGRES_DATABASES | tr ',' ' '); do
    echo "  Creating user and database '$database'"
    psql -v ON_ERROR_STOP=1 --username "$database" <<-EOSQL
	    CREATE USER $database;
	    CREATE DATABASE $database;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $database;
EOSQL
	done
	echo "Multiple databases created"
fi

exec "$@"
