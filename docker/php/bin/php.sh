#!/usr/bin/env bash
# Replace markers
# Install php (cli/fpm)
## Note:
## We are installing imagemagick, not gmagick
apt-get install -y \
	gcc make autoconf libc-dev pkg-config libmcrypt-dev \
	php-pear \
    php<PHP_VERSION>-bcmath \
    php<PHP_VERSION>-bz2 \
    php<PHP_VERSION>-calendar \
    php<PHP_VERSION>-cli \
    php<PHP_VERSION>-ctype \
    php<PHP_VERSION>-curl \
	php<PHP_VERSION>-dev \
	php<PHP_VERSION>-dom \
    php<PHP_VERSION>-ds \
    php<PHP_VERSION>-exif \
    php<PHP_VERSION>-fileinfo \
    php<PHP_VERSION>-fpm \
    php<PHP_VERSION>-ftp \
    php<PHP_VERSION>-gd \
    php<PHP_VERSION>-geoip \
    php<PHP_VERSION>-gettext \
    php<PHP_VERSION>-gmp \
	php<PHP_VERSION>-gnupg \
    php<PHP_VERSION>-http \
    php<PHP_VERSION>-iconv \
    php<PHP_VERSION>-igbinary \
    php<PHP_VERSION>-imagick \
    php<PHP_VERSION>-imap \
    php<PHP_VERSION>-intl \
    php<PHP_VERSION>-json \
    php<PHP_VERSION>-ldap \
    php<PHP_VERSION>-mbstring \
    php<PHP_VERSION>-memcache \
    php<PHP_VERSION>-memcached \
    php<PHP_VERSION>-mysql \
    php<PHP_VERSION>-oauth \
    php<PHP_VERSION>-opcache \
    php<PHP_VERSION>-pdo \
    php<PHP_VERSION>-pdo-mysql \
    php<PHP_VERSION>-phar \
    php<PHP_VERSION>-posix \
    php<PHP_VERSION>-radius \
    php<PHP_VERSION>-shmop \
    php<PHP_VERSION>-simplexml \
    php<PHP_VERSION>-soap \
    php<PHP_VERSION>-sockets \
    php<PHP_VERSION>-solr \
    php<PHP_VERSION>-ssh2 \
    php<PHP_VERSION>-sysvmsg \
    php<PHP_VERSION>-sysvsem \
    php<PHP_VERSION>-sysvshm \
    php<PHP_VERSION>-tidy \
    php<PHP_VERSION>-tokenizer \
    php<PHP_VERSION>-uploadprogress \
    php<PHP_VERSION>-uuid \
    php<PHP_VERSION>-wddx \
    php<PHP_VERSION>-xdebug \
    php<PHP_VERSION>-xml \
    php<PHP_VERSION>-xmlreader \
    php<PHP_VERSION>-xmlrpc \
    php<PHP_VERSION>-xmlwriter \
    php<PHP_VERSION>-xsl \
    php<PHP_VERSION>-yaml \
    php<PHP_VERSION>-zip
if [[ "$WEB_PHP_VERSION" == "7.1" ]]; then
	apt-get install -y \
    php7.1-mcrypt
elif [[ "$WEB_PHP_VERSION" == "7.2" ]]; then
	pecl install mcrypt-1.0.1
	bash -c "echo extension=mcrypt.so > /etc/php/7.2/fpm/conf.d/mcrypt.ini"
elif [[ "$WEB_PHP_VERSION" == "7.3" ]]; then
	pecl install mcrypt-1.0.2
	bash -c "echo extension=mcrypt.so > /etc/php/7.3/fpm/conf.d/mcrypt.ini"
fi

sed -i -e 's/listen = \/run\/php\/php<PHP_VERSION>-fpm.sock/listen = php:9000/g' /etc/php/<PHP_VERSION>/fpm/pool.d/www.conf
sed -i -e 's/;daemonize = yes/daemonize = no/g' /etc/php/<PHP_VERSION>/fpm/php-fpm.conf
