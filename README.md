# ordered online infrastructure

## Technology Stack

- Python 3
- Django
- Gunicorn
- Daphne
- Redis
- Postgres
- Docker
- NGINX

## Quickstart

Clone this repo recursively

```
$ git clone https://github.com/ordered-online/infrastructure --recursive
```

Make sure, that Python 3 is installed. Install all requirements with the following command:
On macOS, please run:

```
export CFLAGS="-I$(brew --prefix openssl)/include $CFLAGS"
export LDFLAGS="-L$(brew --prefix openssl)/lib $LDFLAGS"
```
(This is necessary to build the `psycopg2` library.)

Make sure, that existing docker services are stopped.
```
$ docker-compose down -v
```
Run the server. Make sure, that docker has started.
```
$ docker-compose -f docker-compose.yml up -d --build
```
View the logs with:
```
$ docker-compose logs -f
```
