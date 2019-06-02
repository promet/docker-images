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

# Init vars
if [[ -z "$SERVICE_APACHE_OPTS" ]]; then SERVICE_APACHE_OPTS=""; fi

source /opt/local/bin/config.sh

includeScriptDir "/opt/docker/bin/service.d/httpd.d"

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2*.pid

source /etc/apache2/envvars
exec apache2 -DFOREGROUND -DAPACHE_LOCK_DIR $SERVICE_APACHE_OPTS
