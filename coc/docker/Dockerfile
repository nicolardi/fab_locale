
FROM php:7.4-apache-buster
ENV APACHE_DOCUMENT_ROOT /var/www/html/coc/public
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load 
RUN mkdir coc
RUN apt-get clean
RUN apt-get  update  && apt-get install -y libxml2-dev sudo nano zlib1g-dev libpng-dev
RUN apt-get install -y libz-dev libmemcached-dev && \
apt-get install -y memcached libmemcached-tools && \
pecl install memcached && \
docker-php-ext-enable memcached 
RUN docker-php-ext-install soap mysqli pdo_mysql bcmath 
RUN apt-get install -y libgd3 libgd-dev 
RUN apt-get install -y -qq git \
        libjpeg62-turbo-dev \
        apt-transport-https \
        libfreetype6-dev \
        libmcrypt-dev \
        libpng-dev \
        libssl-dev \
        zip unzip
RUN docker-php-ext-configure gd --with-freetype --with-jpeg 
RUN docker-php-ext-install -j$(nproc) gd
RUN pecl install xdebug 
RUN docker-php-ext-enable xdebug
RUN apt install -y git 
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
RUN mkdir /run/memcached
RUN echo "-s /run/memcached/coc-memcached.sock" >> "/etc/memcached.conf"
RUN sed -i 's!\-p 11211!# \-p 11211!g' "/etc/memcached.conf"
RUN sed -i 's!\-l 127.0.0.1!# \-l 127.0.0.1!g' "/etc/memcached.conf"
RUN sed -i 's!\/var/run!/run!g' "/etc/memcached.conf"
RUN chmod 777 /run/memcached
RUN echo "xdebug.mode = debug,develop"  >> "$PHP_INI_DIR/php.ini"
RUN echo "xdebug.start_with_request = On"  >> "$PHP_INI_DIR/php.ini"
RUN apt install -y git 
RUN echo "memcached.serializer=php" >> "$PHP_INI_DIR/conf.d/docker-php-ext-memcached.ini"
RUN sed -i "s!AddHandler type-map var!#AddHandler type-map var!g" /etc/apache2/mods-available/mime.conf
RUN apt-get update \
 && apt-get install -y build-essential libtool autoconf uuid-dev pkg-config git libsodium-dev wget bzip2 \

 && wget https://archive.org/download/zeromq_4.1.4/zeromq-4.1.4.tar.gz \
 && tar -xvzf zeromq-4.1.4.tar.gz \
 && cd zeromq-4.1.4 \
 && ./configure \
 && make \
 &&  make install \
 &&  ldconfig \
 && cd .. \
 && rm -fr zeromq-4.1.4.tar.gz zeromq-4.1.4/ \

 && git clone https://github.com/mkoppanen/php-zmq.git \
 && cd php-zmq \
 && phpize && ./configure \
 && make \
 && make install \
 && cd .. \
 && rm -fr php-zmq \

 && echo "extension=zmq.so" > /usr/local/etc/php/conf.d/docker-php-ext-zmq.ini 
RUN a2enmod ssl
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf
COPY docker-php-ext-xdebug.ini "$PHP_INI_DIR/conf.d"
COPY ssl/* /etc/ssl
COPY systemd/system /etc/systemd/system
COPY run.sh /run.sh
LABEL NAME="WEBSERVER"
LABEL VERSION="1.0.0"
EXPOSE 80 443
CMD bash -c "bash /run.sh && apache2-foreground"
