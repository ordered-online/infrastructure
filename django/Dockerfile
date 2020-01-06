FROM python:3.7.6-alpine3.11

ARG SERVICE="app"

ENV DONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV SERVICE=${SERVICE}

# install psycopg2 dependencies needed for Alpine Linux
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev libffi-dev

# set the working directory
WORKDIR /usr/src/app

# Copy application into working directory
COPY "./${SERVICE}/${SERVICE}" /usr/src/app/

# install application requirements through pip
RUN python -m pip install -r "/usr/src/app/requirements.txt"

# copy the entrypoint script for the image
COPY django/docker-entrypoint.sh /usr/local/bin/

# ensure the entrypoint is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# set the entrypoint to our custom script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# set entry command to start wsgi server on port 8000
CMD ["/bin/sh", "-c", "/usr/local/bin/gunicorn --log-level warning --chdir /usr/src/app/ --bind 0.0.0.0:8000 ${SERVICE}.wsgi:application" ]

# expose the port 8000
EXPOSE 8000