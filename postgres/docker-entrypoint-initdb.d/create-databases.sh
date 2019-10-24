#!/usr/bin/env bash

for file in /var/lib/postgres/environment/*
do

    [[ $file =~ /var/lib/postgres/environment/db.env ]] && continue

	SQL_DATABASE=$(grep SQL_DATABASE $file | cut -d '=' -f2 )
    SQL_USER=$(grep SQL_USER $file | cut -d '=' -f2 )
    SQL_PASSWORD=$(grep SQL_PASSWORD $file | cut -d '=' -f2 )

	# echo $file
	# echo $SQL_DATABASE
	# echo $SQL_USER
	# echo $SQL_PASSWORD

	psql -v ON_ERROR_STOP=1 <<- EOSQL
	    CREATE USER "$SQL_USER" SUPERUSER PASSWORD '$SQL_PASSWORD';
	    CREATE DATABASE $SQL_DATABASE;
	    GRANT ALL PRIVILEGES ON DATABASE $SQL_DATABASE TO $SQL_USER;
	EOSQL

done

echo "Created All Databases"