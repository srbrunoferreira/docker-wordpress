# docker-php-fpm-apache-phpmyadmin-mariadb
Docker environment with WordPress, PHP-FPM, Apache, phpMyAdmin and MariaDB

Use it to develop your plugin.

Feel free to use as you wish.

Feel free to contribute improving the code.

# How to install
1. Clone the repository on your local machine or WSL.

2. (optional, but recommended) Generate self-signed SSL certificates with `mkcert`.
   1. In your host machine, install [mkcert](https://github.com/FiloSottile/mkcert).
      1. If you use WSL, you must [install mkcert with choco](https://github.com/FiloSottile/mkcert#windows) on Windows and **run every command of mkcert from the Windows terminal**. Otherwise, the browser won't recognize the certs.

   2. Run: `mkcert -cert-file wordpress.local.pem, -key-file wordpress.local.key.pem wordpress.local localhost 127.0.0.1 ::1`
      1. Filename for the key must be wordpress.local.key.pem.
      2. Filename for the cert must be wordpress.local.pem.
      3. Otherwise, you'll need to change the 000-default.conf.

3. Run `mkcert -install` in the same dir you executed the command above in order to enable the certs in your host machine browsers.

4. Move the generated `.pem` to the path `/.docker/wordpress/apache/certs`

5. Run `docker compose up --build -d`

6. Lastly, you'll need to add `127.0.0.1 wordpress.local` to your operating system's hosts file. See [this tutorial](https://www.hostinger.com/tutorials/how-to-edit-hosts-file) to learn how to access them for Linux and Windows.
   1. In Windows, add the two following lines. For Linux, just the first one:

      ```
      127.0.0.1 wordpress.local
      ::1 wordpress.local
      ```

7. Open [wordpress.local](https://wordpress.local/) in your browser.

8. Open [localhost:8080](http://localhost:8080) to access phpMyAdmin in your browser.


# Reference
* `./.docker/wordpress/php/php.ini`: https://github.com/php/php-src/blob/master/php.ini-development

# Docker images used
- https://hub.docker.com/_/wordpress
- https://hub.docker.com/_/mariadb
- https://hub.docker.com/_/phpmyadmin
