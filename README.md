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

```bash
$ git clone https://github.com/ordered-online/infrastructure --recursive
```

Otherwise simply run

```bash
$ git submodule update --init --recursive
```

Start the application with docker-compose in debug environment via

```
$ docker-compose --project-name ordered-online -f docker-compose.yml up
```

Start the application with docker-compose in production environment via

```
$ docker-compose --project-name ordered-online -f docker-compose.yml -f docker-compose.prod.yml up
```

Use the `--build` flag to rebuild all images or detach after build with `-d`.
Note, that if detached, the logs are accessible via `docker-compose logs -f`.

---

If you are using `macOS` and the installation of Python 3 fails,
because the python ssl extension throws an error,
you have to set CFLAGS and LDFLAGS so that setup.py can find openssl headers.
You can do so by setting the following environment variables

```
export CFLAGS="-I$(brew --prefix openssl)/include $CFLAGS"
export LDFLAGS="-L$(brew --prefix openssl)/lib $LDFLAGS"
```

## Development

Use our docker setup for developing. With that, the submodule directories will get mounted as volumes into the
service containers. To do so, simple use the following command to start the application with docker-compose in development environment:

```
$ docker-compose --project-name ordered-online up
```

Note that with that command, docker will automatically pick up **both** the `docker-compose.yml` (containing base configuration) and
`docker-compose.override.yml` (containing volumes overrides) file.

## Production

Build all images for production using:

```
$ docker-compose -f docker-compose.yml -f docker-compose.prod.yml build
```

Start the application with docker-compose in production environment via

```
$ docker-compose --project-name ordered-online -f docker-compose.yml -f docker-compose.prod.yml up
```
