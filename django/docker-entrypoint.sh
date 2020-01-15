#!/bin/sh
set -e

if ! [ -z "$SQL_HOST" ] && [ -z "$SQL_PORT" ]; then

    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
        sleep 1.0
    done

    echo "Postgres started"
fi

python /usr/src/app/manage.py migrate

if [ -d "/usr/src/app/data/" ]; then
    echo "Found data directory. Installing fixtures..."
    python /usr/src/app/manage.py loaddata $(find /usr/src/app/data/ -name "*.json")
fi

exec "$@"
