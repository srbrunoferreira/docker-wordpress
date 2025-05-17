# docker-php-fpm-apache-phpmyadmin-mariadb

Docker environment with WordPress, PHP-FPM, Apache, phpMyAdmin and MariaDB

Use it to develop your plugin or to have a LAMP stack to test some code.

You'll have:

Wordpress at https://wordpress.local
phpMyAdmin at https://wordpress.local:3022

## Setup

To run this, you just need to:

1. Copy the `.env.example` to a `.env` file.
2. Adjust the env variables.
3. Run `./start.sh`

### About start.sh

It'll do some things:

1. Will edit your system `/etc/hosts` so you'll be able to use https://wordpress.local for your WordPress
2. Will generate certificates with the Docker image [alpine/mkcert](https://hub.docker.com/r/alpine/mkcert)
3. Will insert the generated cert to your system "cert store".

That's it.

## About the folders

- `/wordpress` - stores settings for the WP service.
- `/phpmyadmin` - stores settings for the phpmyadmin service.

- `/wp-logs` - stores the Apache logs from the WP service.
- `/wp-plugins` - it's where you put your plugins. Also, any plugins installed from WordPress will be present here.
- `/wp-themes` - it's where you put your themes. Themes intalled from WordPress will be present here too.

## Reference
* `./.docker/wordpress/php/php.ini`: https://github.com/php/php-src/blob/master/php.ini-development

## Docker images used
- https://hub.docker.com/_/wordpress
- https://hub.docker.com/_/mariadb
- https://hub.docker.com/_/phpmyadmin
- https://hub.docker.com/r/alpine/mkcert
