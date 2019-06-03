#!/usr/bin/env bash
# Replace markers
# Install php (cli/fpm)
## Note:
## We are installing imagemagick, not gmagick
DEBIAN_FRONTEND=noninteractive apt-get install -y \
	php<PHP_VERSION>-cli \
    php<PHP_VERSION>-fpm \
    php<PHP_VERSION>-dev \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    php<PHP_VERSION>-bcmath \
    php<PHP_VERSION>-bz2 \
    php<PHP_VERSION>-curl \
	php<PHP_VERSION>-dom \
    php<PHP_VERSION>-ds \
    php<PHP_VERSION>-gd \
    php<PHP_VERSION>-geoip \
    php<PHP_VERSION>-gmp \
	php<PHP_VERSION>-gnupg \
    php<PHP_VERSION>-http \
    php<PHP_VERSION>-igbinary \
    php<PHP_VERSION>-imagick \
    php<PHP_VERSION>-imap \
    php<PHP_VERSION>-intl \
    php<PHP_VERSION>-ldap \
    php<PHP_VERSION>-mbstring \
    php<PHP_VERSION>-memcache \
    php<PHP_VERSION>-memcached \
    php<PHP_VERSION>-mysql \
    php<PHP_VERSION>-oauth \
    php<PHP_VERSION>-radius \
    php<PHP_VERSION>-soap \
    php<PHP_VERSION>-tidy \
    php<PHP_VERSION>-uuid \
    php<PHP_VERSION>-xmlrpc \
    php<PHP_VERSION>-xsl \
    php<PHP_VERSION>-yaml \
    php<PHP_VERSION>-zip \
&& if [[ "$WEB_PHP_VERSION" == "7.1" ]]; then
	DEBIAN_FRONTEND=noninteractive apt-get install -y \
    php7.1-ssh2 \
    php7.1-mcrypt \
    php7.1-xdebug
elif [[ "$WEB_PHP_VERSION" == "7.2" ]]; then
    DEBIAN_FRONTEND=noninteractive apt-get install -y php-pear \
        php<PHP_VERSION>-json \
        php<PHP_VERSION>-opcache \
        php<PHP_VERSION>-calendar \
        php<PHP_VERSION>-ctype \
        php<PHP_VERSION>-exif \
        php<PHP_VERSION>-fileinfo \
        php<PHP_VERSION>-ftp \
        php<PHP_VERSION>-gettext \
        php<PHP_VERSION>-iconv \
        php<PHP_VERSION>-pdo \
        php<PHP_VERSION>-pdo-mysql \
        php<PHP_VERSION>-phar \
        php<PHP_VERSION>-posix \
        php<PHP_VERSION>-shmop \
        php<PHP_VERSION>-simplexml \
        php<PHP_VERSION>-sockets \
        php<PHP_VERSION>-sysvmsg \
        php<PHP_VERSION>-sysvshm \
        php<PHP_VERSION>-sysvsem \
        php<PHP_VERSION>-ssh2 \
        php<PHP_VERSION>-tokenizer \
        php<PHP_VERSION>-wddx \
        php<PHP_VERSION>-xml \
        php<PHP_VERSION>-xmlreader \
        php<PHP_VERSION>-xmlwriter \
    && pecl install xdebug-2.7.0 \
	&& pecl install mcrypt-1.0.1 \
    && { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=0'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /etc/php/<PHP_VERSION>/fpm/conf.d/20-opcache.ini \
    && bash -c "echo extension=mcrypt.so > /etc/php/7.2/fpm/conf.d/mcrypt.ini"
elif [[ "$WEB_PHP_VERSION" == "7.3" ]]; then
    DEBIAN_FRONTEND=noninteractive apt-get install -y php-pear \
        php<PHP_VERSION>-json \
        php<PHP_VERSION>-opcache \
        php<PHP_VERSION>-calendar \
        php<PHP_VERSION>-ctype \
        php<PHP_VERSION>-exif \
        php<PHP_VERSION>-fileinfo \
        php<PHP_VERSION>-ftp \
        php<PHP_VERSION>-gettext \
        php<PHP_VERSION>-iconv \
        php<PHP_VERSION>-pdo \
        php<PHP_VERSION>-pdo-mysql \
        php<PHP_VERSION>-phar \
        php<PHP_VERSION>-posix \
        php<PHP_VERSION>-shmop \
        php<PHP_VERSION>-simplexml \
        php<PHP_VERSION>-sockets \
        php<PHP_VERSION>-solr \
        php<PHP_VERSION>-sysvmsg \
        php<PHP_VERSION>-sysvshm \
        php<PHP_VERSION>-sysvsem \
        php<PHP_VERSION>-ssh2 \
        php<PHP_VERSION>-tokenizer \
        php<PHP_VERSION>-uploadprogress \
        php<PHP_VERSION>-wddx \
        php<PHP_VERSION>-xml \
        php<PHP_VERSION>-xmlreader \
        php<PHP_VERSION>-xmlwriter \
    && pecl install xdebug-2.7.0 \
	&& pecl install mcrypt-1.0.2 \
    && bash -c "echo extension=mcrypt.so > /etc/php/7.3/fpm/conf.d/40-mcrypt.ini" \
    && { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=0'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /etc/php/<PHP_VERSION>/fpm/conf.d/20-opcache.ini
fi

sed -i -e 's/listen = \/run\/php\/php<PHP_VERSION>-fpm.sock/listen = <PHP_SOCKET>/g' /etc/php/<PHP_VERSION>/fpm/pool.d/www.conf
sed -i -e 's/;daemonize = yes/daemonize = no/g' /etc/php/<PHP_VERSION>/fpm/php-fpm.conf

{ \
    echo '; Mailhog php.ini settings for Expresso PHP.';
    echo 'sendmail_path = "/opt/go/bin/mhsendmail --smtp-addr=mailhog:1025"';
} > /etc/php/<PHP_VERSION>/fpm/conf.d/20-mailhog.ini

{ \
    echo '[xdebug]'; \
    echo 'zend_extension=xdebug.so'; \
    echo 'xdebug.profiler_enable=0'; \
    echo 'xdebug.default_enable=1'; \
    echo 'xdebug.remote_enable=1'; \
    echo 'xdebug.remote_handler=dbgp'; \
    echo '; port 9000 is used by php-fpm'; \
    echo 'xdebug.remote_port=9000'; \
    echo 'xdebug.remote_autostart=0'; \
    echo 'xdebug.remote_connect_back=0'; \
    echo 'xdebug.idekey="PHPSTORM"'; \
    echo 'xdebug.remote_host=10.254.254.254'; \
} > /etc/php/<PHP_VERSION>/fpm/conf.d/20-xdebug.ini
