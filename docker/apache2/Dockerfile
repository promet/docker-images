FROM prometsource/base

ENV WEB_DOCUMENT_ROOT=/var/www/html \
    WEB_DOCUMENT_INDEX=index.php \
    WEB_ALIAS_DOMAIN=*.vm \
    WEB_PHP_TIMEOUT=600 \
    WEB_PHP_SOCKET="php:9000"

COPY conf/ /opt/docker/

RUN set -x \
 && apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install apache2 \
 && a2enmod actions proxy proxy_fcgi ssl rewrite headers expires \
 && sed -ri ' \
    s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \
    s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \
    ' /etc/apache2/apache2.conf \
 && rm -f /etc/apache2/sites-enabled/* \
 && ln -sf /opt/docker/etc/httpd/main.conf /etc/apache2/sites-enabled/10-docker.conf \
 ## Add other packages here, but the following two lines need to run last after adding packages
 ## to reduce the size of the container.
 && rm -rf /var/lib/apt/lists/* \
 && apt autoremove -y \
 && ./opt/docker/provision/bootstrap.d/10-apache.sh

EXPOSE 80 443

ENTRYPOINT ["/opt/docker/bin/service.d/httpd.sh"]
