FROM php:7.4-apache-bullseye
WORKDIR /root
RUN apt-get update && apt-get -fy install wget git zlib1g-dev libpng-dev mariadb-client gnupg unzip
RUN echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' > /etc/apt/sources.list.d/newrelic.list
RUN wget -O- https://download.newrelic.com/548C16BF.gpg | apt-key add -
ENV NEWRELIC_VERSION=10.1.0.313
RUN apt-get update && apt-get -fy install newrelic-php5=$NEWRELIC_VERSION newrelic-php5-common=$NEWRELIC_VERSION newrelic-daemon=$NEWRELIC_VERSION
RUN ln -s /usr/lib/newrelic-php5/agent/x64/newrelic-20190902.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/newrelic.so
RUN docker-php-ext-configure pdo_mysql && \
    docker-php-ext-install pdo_mysql gd && \
    docker-php-ext-enable newrelic
RUN wget https://ftp.drupal.org/files/projects/drupal-7.91.tar.gz
WORKDIR /var/www/html
RUN tar --strip-components=1 -xzf /root/drupal-7.91.tar.gz
COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN composer require drush/drush:8.*
RUN mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
# License key is from a throwaway free account
RUN echo 'newrelic.license = "4bb2e8ff486a4a2bca5f18137c479f0741eeNRAL"' >> /usr/local/etc/php/php.ini 
RUN cp -a sites/default/default.settings.php sites/default/settings.php
COPY test.php /var/www/html/test.php
COPY test2.php /var/www/html/test2.php
COPY test.xml /var/www/html/test.xml
COPY info.php /var/www/html/info.php
#RUN echo 'export USE_ZEND_ALLOC=0' >> /etc/apache2/envvars
RUN echo 'CoreDumpDirectory /tmp' >> /etc/apache2/apache2.conf
