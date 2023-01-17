# docker-php-fpm-apache-phpmyadmin-mariadb
Docker environment with WordPress, PHP-FPM, Apache, phpMyAdmin and MariaDB

Use it to develop your plugin.

Feel free to use as you wish.

Feel free to contribute improving the code.

# How to install
1. Clone the repository on your local machine or WSL.

2. (optional, but recommended) Generate self-signed SSL certificates
   1. In your host machine, install [mkcert](https://github.com/FiloSottile/mkcert).

    2. In your host machine run: `mkcert wordpress.local 127.0.0.1 ::1`

   2. Run the command `mkcert -install` in the same dir you executed the command above in order to enable the certs in your host machine browsers.
      1. Filename for the key must be wordpress.local.key.pem.
      2. Filename for the cert must be wordpress.local.pem.
      3. Otherwise, you'll need to change the 000-default.conf.

  3. Move the generated `.pem` to the path `/.docker/wordpress/apache/certs`

  4. Run `docker compose up -d`

  5. Open [wordpress.local](https://wordpress.local/) in your browser.

  6. Open [localhost:8080](http://localhost:8080) to access phpMyAdmin in your browser.


# Reference
* `./.docker/wordpress/php/php.ini`: https://github.com/php/php-src/blob/master/php.ini-development

# Docker images used
- https://hub.docker.com/_/wordpress
- https://hub.docker.com/_/mariadb
- https://hub.docker.com/_/phpmyadmin
