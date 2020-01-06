FROM postgres:12.1-alpine

ARG ENV_DIR="./environment"

COPY ${ENV_DIR} /var/lib/postgres/environment

COPY postgres/docker-entrypoint-initdb.d/ /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/create-databases.sh