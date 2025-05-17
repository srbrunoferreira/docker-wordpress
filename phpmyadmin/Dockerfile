FROM phpmyadmin:5.2.2-apache

RUN set -eux; \
    SECRET=$(openssl rand -base64 24); \
    echo "<?php" > /etc/phpmyadmin/config.secret.inc.php; \
    echo "\$cfg['blowfish_secret'] = '${SECRET}';" >> /etc/phpmyadmin/config.secret.inc.php;

CMD bash -c "\
  a2enmod ssl && \
  if [ -f /etc/apache2/sites-enabled/default-ssl.conf ] && [ ! -L /etc/apache2/sites-enabled/default-ssl.conf ]; then \
    echo 'Fixing default-ssl.conf: removing regular file'; \
    rm /etc/apache2/sites-enabled/default-ssl.conf; \
  fi && \
  a2ensite default-ssl && \
  sed -i 's|SSLCertificateFile.*|SSLCertificateFile /etc/apache2/ssl/wordpress.local.pem|' /etc/apache2/sites-enabled/default-ssl.conf && \
  sed -i 's|SSLCertificateKeyFile.*|SSLCertificateKeyFile /etc/apache2/ssl/wordpress.local.key.pem|' /etc/apache2/sites-enabled/default-ssl.conf && \
  apache2-foreground"
