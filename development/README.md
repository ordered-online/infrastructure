## Development Guide

The following is a simple guide to quickly bootstrap the api on your local machine.
If you are not familiar with docker, this will help you to start the api for the
ordered.online in development mode on your host machine via a simple web server. 
We will use `nginx` to run a web server and `supervisor` to start all microservices simultaneously.


### Prerequisites
For this purpose both `nginx` and `supervisor` need to be installed on your system.

#### `Ubuntu / Debian`
For any debian-based system (including Ubuntu) just run the following to install both nginx and supervisor

```bash
$ sudo apt install nginx supervisor
```

### Quickstart

Symlink the microservices `code`, `locations`, `orders`, `products` and `verification` into the `/var/www` directory.
You can do so, by executing the following from the root folder of this repository:

```bash
$ sudo ln -s $PWD/codes        /var/www/codes
$ sudo ln -s $PWD/locations    /var/www/locations
$ sudo ln -s $PWD/orders       /var/www/orders
$ sudo ln -s $PWD/products     /var/www/products
$ sudo ln -s $PWD/verification /var/www/verification
```

In either case, make sure the permissions inside  the `/var/www` directory by executing:

```bash
$ sudo chmod -R 755  /var/www
```

Afterwards your `/var/www` directory should look like the similar to the following:

```bash
$ tree /var/www
/var/www
├── codes -> /.../infrastructure/codes
├── html
│   └── index.nginx-debian.html
├── locations -> /.../infrastructure/locations
├── orders -> /.../infrastructure/orders
├── products -> /.../infrastructure/products
└── verification -> /.../infrastructure/verification

6 directories, 1 file
```

_Alternative_
Clone the `code`, `locations`, `orders`, `products` and `verification` into the `/var/www` directory.
You can either clone them directly into the location by executing:

```bash
$ sudo git clone https://github.com/ordered-online/codes.git        /var/www/codes
$ sudo git clone https://github.com/ordered-online/locations.git    /var/www/locations
$ sudo git clone https://github.com/ordered-online/orders.git       /var/www/orders
$ sudo git clone https://github.com/ordered-online/products.git     /var/www/products
$ sudo git clone https://github.com/ordered-online/verification.git /var/www/verification
```

####  Configuration

Both `nginx` and `supervisor` need to be configured. The configuration files are provided in this directory.

Copy the supervisor configuration `ordered-online.conf` into `/etc/supervisor/conf.d`

```bash
$ cp ordered-online.conf /etc/supervisor/conf.d/
```
_Alternative_
Symlink it:
```bash
$ cp $PWD/development/ordered-online.conf /etc/supervisor/conf.d/ordered-online.conf
```

Copy the nginx configuration `ordered.online` into `/etc/nginx/sites-available`

```bash
$ cp ordered.online /etc/nginx/sites-available/
```

The `sites-available` directory of nginx should always contain the configurations of all available web servers. 
In contrast, the `sites-enabled` directory should contain symlinks to the configurations that are currently enabled.
We will create this by executing:

```bash
$ sudo ln -s /etc/nginx/sites-available/ordered.online /etc/nginx/sites-enabled/ordered.online
```

If you would then like to currently disable the ordered.online domain while running nginx for other web server, 
you could simply delete the symlink inside `sites-enabled`, while this would still reserve the configuration inside 
`sites-available` for you the be able to enable it again, by creating the symlink with the command above.

_Alternative_
Symlink it directly into sites-enabled:
```bash
$ sudo ln -s $PWD/development/ordered.online /etc/nginx/sites-enabled/ordered.online
```

####  Start

Before you start the local web server make sure to migrate every microservice. You can do so by running the following command:

```bash
$ find -L /var/www -type f -name "manage.py" -exec python3 {} migrate \; 
```

If you followed all the steps above, you are now able to run the whole api via a local web server by simply running:

```bash
$ sudo supervisord -n -c  /etc/supervisor/supervisord.conf 
```

*NOTE:*

The configuration file `/etc/supervisor/supervisord.conf` should contain the lines

```bash
; supervisor config file

[unix_http_server]
file=/var/run/supervisor.sock   ; (the path to the socket file)
chmod=0700                       ; sockef file mode (default 0700)

[supervisord]
logfile=/var/log/supervisor/supervisord.log ; (main log file;default $CWD/supervisord.log)
pidfile=/var/run/supervisord.pid ; (supervisord pidfile;default supervisord.pid)
childlogdir=/var/log/supervisor            ; ('AUTO' child log dir, default $TEMP)

...

[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run/supervisor.sock ; use a unix:// URL  for a unix socket

...

[include]
files = /etc/supervisor/conf.d/*.conf
```

You can check that it does so by executing:

```bash
$ cat /etc/supervisor/supervisord.conf
```

If supervisor is alread running and you changed something in the configuration file, simply restart all programms by
```bash
$ sudo supervisorctl reread
$ sudo supervisorctl update
$ sudo supervisorctl restart all
```
*Advanced*

You can also start supervisor with the ordered-online application directly by executing:
```bash
$ sudo /usr/bin/supervisord -c /etc/supervisor/conf.d/ordered-online.conf  
```

Note that you may want to add the supervisord, supervisorctl and unix_http_server blocks mentioned above.