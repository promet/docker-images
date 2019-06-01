#!/usr/bin/env bash
# Replace markers
go-replace \
    -s "<DOCUMENT_INDEX>" -r "$WEB_DOCUMENT_INDEX" \
    -s "<DOCUMENT_ROOT>" -r "$WEB_DOCUMENT_ROOT" \
    -s "<ALIAS_DOMAIN>" -r "$WEB_ALIAS_DOMAIN" \
    -s "<SERVERNAME>" -r "$HOSTNAME" \
    -s "<PHP_SOCKET>" -r "$WEB_PHP_SOCKET" \
    -s "<PHP_TIMEOUT>" -r "$WEB_PHP_TIMEOUT" \
    --path=/opt/docker/etc/httpd/ \
    --path-pattern='*.conf' \
    --ignore-empty

if [[ -z "$WEB_PHP_SOCKET" ]]; then
    ## WEB_PHP_SOCKET is not set, remove PHP files
    rm -f -- /opt/docker/etc/httpd/conf.d/10-php.conf
fi

# Collect environment variables
APACHE_MAIN_PATH=/etc/apache2/
APACHE_DOCKER_VHOST=/etc/apache2/sites-enabled/10-docker.conf

# Enable apache main config
ln -sf -- /opt/docker/etc/httpd/main.conf "$APACHE_DOCKER_VHOST"

# Ensure /var/run/apache2 exists
mkdir -p -- "/var/run/apache2"

mkdir -p -- "/var/lock/apache2"
chmod 0750 -- "/var/lock/apache2"
chown www-data:www-data -- "/var/lock/apache2"

APACHE_CONF_FILES=$(find "$APACHE_MAIN_PATH" -type f -iname '*.conf' -o -iname 'default*' -o -iname '*log')

# Change log to Docker stdout
go-replace --regex --regex-backrefs \
    -s '^[\s]*(CustomLog|ErrorLog|TransferLog) ([^\s]+)(.*)' -r '$1 /docker.stdout $3' \
    -s '^[\s]*(ErrorLog) ([^\s]+)(.*)' -r '$1 /docker.stderr $3' \
    --path="$APACHE_MAIN_PATH" \
    --path-regex='(.*\.conf|default.*|.*log)$'

# Switch MPM to event

a2enmod mpm_event

# Fix rights of ssl files
chown -R root:root /opt/docker/etc/httpd/ssl
find /opt/docker/etc/httpd/ssl -type d -exec chmod 750 {} \;
find /opt/docker/etc/httpd/ssl -type f -exec chmod 640 {} \;
