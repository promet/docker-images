FROM prometsource/base

ENV WEB_DOCUMENT_ROOT=/var/www/html \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.vm \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET="php:9000"

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN set -x \
    # Install php environment
 && apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install \
	software-properties-common \
 && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
 && apt-get -y update \
 && apt-get -y install \
    # Install tools
    imagemagick \
    graphicsmagick \
    ghostscript \
    jpegoptim \
    libjpeg-turbo-progs \
    pngcrush \
    optipng \
    apngopt \
    pngnq \
    pngquant \
    mysql-client \
    aptitude \
    supervisor \
    # Install php (cli/fpm)
    php7.3-fpm \
    php7.3-cli \
    php7.3-curl \
    php7.3-dom \
    php7.3-json \
    php7.3-intl \
    php7.3-curl \
    php7.3-gnupg \
    php7.3-http \
    php7.3-iconv \
    php7.3-mysql \
    #php7.3-mcrypt \
    php7.3-gd \
    #php7.3-sqlite3 \
    php7.3-imap \
    #php7.3-pgsql \
    php7.3-ldap \
    php7.3-opcache \
    php7.3-soap \
    php7.3-zip \
    php7.3-mbstring \
    php7.3-memcache \
    php7.3-memcached \
    php7.3-oauth \
    php7.3-pdo-mysql \
    php7.3-phar \
    php7.3-bcmath \
    php7.3-xmlrpc \
    php7.3-xsl \
    php7.3-bz2 \
    php7.3-shmop \
    php7.3-sockets \
    php7.3-solr \
    php7.3-ssh2 \
    php7.3-sysvmsg \
    php7.3-sysvsem \
    php7.3-sysvshm \
    php7.3-tokenizer \
    php7.3-wddx \
    php7.3-xdebug \
    php7.3-yaml \
    php7.3-imagick \
    php7.3-igbinary \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
 && apt autoremove -y \
 && mkdir /run/php \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
 && sed -i -e 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.3/fpm/pool.d/www.conf \
 && sed -i -e 's/;daemonize = yes/daemonize = no/g' /etc/php/7.3/fpm/php-fpm.conf

EXPOSE 9000

CMD ["/usr/bin/supervisord"]