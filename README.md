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

Start the application with docker-compose via 
```
$ docker-compose --project-name ordered-online -f docker-compose.yml up -d --build
```

---

If you are using `macOS` and the installation of Python 3 fails, 
because the python ssl extension throws an error,
you have to set CFLAGS and LDFLAGS so that setup.py can find openssl headers. 
You can do so by setting the following environment variables
```
export CFLAGS="-I$(brew --prefix openssl)/include $CFLAGS"
export LDFLAGS="-L$(brew --prefix openssl)/lib $LDFLAGS"
```

---

To run the docker compose setup, execute
```
$ docker-compose --project-name ordered-online -f docker-compose.yml up
```

---

Use the flag `-d` to run in detached mode so docker will run in the background.
```
$ docker-compose --project-name ordered-online -f docker-compose.yml up -d
```
This way it will not block the current shell.

---

Use the flag `--build` to rebuild all images specified via the docker-compose.yml
```
$ docker-compose --project-name ordered-online -f docker-compose.yml up --build
```
--- 
View the logs with:
```
$ docker-compose logs -f
```
