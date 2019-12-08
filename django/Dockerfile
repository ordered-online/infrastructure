FROM python:3.7.5-alpine3.10

ENV DONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies needed for Alpine Linux
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev libffi-dev

# set the working directory
WORKDIR /usr/src/app

# copy the entrypoint script for the image
COPY docker-entrypoint.sh /usr/local/bin/

# ensure the entrypoint is executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# set the entrypoint to our custom script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# expose the port 8000
EXPOSE 8000