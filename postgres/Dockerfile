FROM postgres:12.0-alpine

COPY /docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/create-databases.sh