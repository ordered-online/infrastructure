#!/bin/sh
set -e

APP_DIR=$( dirname "$(find . -type f -name "requirements.txt")" )

echo "${APP_DIR}"

python -m pip install -r "${APP_DIR}/requirements.txt"

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
        sleep 0.1
    done

    echo "Postgres started"
fi

python "${APP_DIR}/manage.py" flush --no-input
python "${APP_DIR}/manage.py" migrate

exec "$@"
