#!/usr/bin/env bash

substitutions="\${APP_DOMAIN} \${APP_LOG_LEVEL} \${APP_PUBLIC_DIR}"

if [ ! -f /etc/php/7.1/fpm/php-fpm.conf ]; then
    envsubst "${substitutions}" < /etc/php/7.1/fpm/php-fpm.conf.template > /etc/php/7.1/fpm/php-fpm.conf
fi

if [ ! -f /etc/nginx/sites-available/api.myparcel.com ]; then
    envsubst "${substitutions}" < /etc/nginx/sites-available/default.template > /etc/nginx/sites-available/default
fi

if [ ! -f /etc/supervisor/conf.d/supervisord.conf ]; then
    envsubst "${substitutions}" < /etc/supervisor/conf.d/supervisord.conf.template > /etc/supervisor/conf.d/supervisord.conf
fi

if [ ! "${APP_ENV}" == "production" ] && [ ! "${APP_ENV}" == "prod" ]; then
    # Enable xdebug
    ln -sf /etc/php/7.1/mods-available/xdebug.ini /etc/php/7.1/fpm/conf.d/20-xdebug.ini
else
    # Disable xdebug
    if [ -e /etc/php/7.1/fpm/conf.d/20-xdebug.ini ]; then
        rm -f /etc/php/7.1/fpm/conf.d/20-xdebug.ini
    fi
fi

sed -i "s/xdebug\.remote_host\=.*/xdebug\.remote_host\=${APP_DOMAIN}/g" /etc/php/7.1/mods-available/xdebug.ini

$@
