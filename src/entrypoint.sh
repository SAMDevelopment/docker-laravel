#!/usr/bin/env bash

substitutions="\${APP_LOG_LEVEL} \${APP_DOMAIN}"

if [ ! -f /etc/php/7.1/fpm/php-fpm.conf ]; then
    envsubst "${substitutions}" < /etc/php/7.1/fpm/php-fpm.conf.template > /etc/php/7.1/fpm/php-fpm.conf
fi

if [ ! -f /etc/nginx/sites-available/api.myparcel.com ]; then
    envsubst "${substitutions}" < /etc/nginx/sites-available/default.template > /etc/nginx/sites-available/default
fi

if [ ! -f /etc/supervisor/conf.d/supervisord.conf ]; then
    envsubst "${substitutions}" < /etc/supervisor/conf.d/supervisord.conf.template > /etc/supervisor/conf.d/supervisord.conf
fi

$@
