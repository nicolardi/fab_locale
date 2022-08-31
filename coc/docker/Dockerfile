
FROM php:7.4-apache-buster
ENV APACHE_DOCUMENT_ROOT /var/www/html/coc/public
RUN mkdir befa
RUN apt-get clean
RUN apt-get  update  && \
    apt-get install -y libxml2-dev
RUN docker-php-ext-install soap mysqli 
RUN apt install -y git
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"
RUN sed -i 's!memory_limit\ =\ 128M!memory_limit\ =\ 3G!g' "$PHP_INI_DIR/php.ini"
RUN sed -i 's!upload_max_filesize\ =\ 2M!upload_max_filesize\ =\ 2G!g' "$PHP_INI_DIR/php.ini"
RUN sed -i 's!post_max_size\ =\ 8M!post_max_size = 3G!g' "$PHP_INI_DIR/php.ini"

RUN sed -i 's!error_reporting\ =\ E_ALL!error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED \& ~E_WARNING!' "$PHP_INI_DIR/php.ini"
RUN echo "xdebug.mode = debug,develop"  >> "$PHP_INI_DIR/php.ini"
RUN echo "xdebug.start_with_request = On"  >> "$PHP_INI_DIR/php.ini"
LABEL NAME="WEBSERVER"
LABEL VERSION="1.0.0"
