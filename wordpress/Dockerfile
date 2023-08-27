FROM wordpress:php8.1-apache

COPY php/php.ini $PHP_INI_DIR/

# Create directory for Apache logs.
RUN mkdir -p /var/www/html/.apache

# Create directory for SSl certs.
RUN mkdir -p /var/www/html/.certs

RUN a2enmod headers ssl

# Move VHost conf
COPY apache/000-default.conf /etc/apache2/sites-available/

# MoveSSL certs
COPY apache/certs/* /var/www/html/.certs

RUN service apache2 restart
