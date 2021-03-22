FROM ubuntu:20.04

LABEL author="Sam de Vries <mail@samdevelopment.nl>"

# Install locales for terminal and php.
RUN apt-get update \
    && apt-get install -y locales \
    && locale-gen en_US.UTF-8 \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update \
    && apt-get install -y curl gettext-base nginx software-properties-common sqlite3 ssl-cert supervisor unzip zip \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php8.0-fpm php8.0-cli php8.0-mcrypt php8.0-gd php8.0-mysql \
       php8.0-mbstring php8.0-xml php8.0-curl php8.0-sqlite3 php-xdebug \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && mkdir /run/php \
    && apt-get remove -y --purge software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/php/8.0/fpm/php-fpm.conf \
       /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default \
    && echo "daemon off;" >> /etc/nginx/nginx.conf

# Copy config files.
COPY conf/php-fpm.conf /etc/php/8.0/fpm/php-fpm.conf.template
COPY conf/default-site /etc/nginx/sites-available/default.template
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf.template

# Symlink the nginx conf.
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Copy entrypoint script.
COPY entrypoint.sh /bin/entrypoint.sh

# Set the environment variables.
ENV APP_DOMAIN localhost
ENV APP_LOG_LEVEL notice
ENV APP_PUBLIC_DIR public
ENV DOCKER_ENV development
ENV COMPOSER_ALLOW_SUPERUSER 1

EXPOSE 80 443

WORKDIR /opt/app

ENTRYPOINT ["/bin/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
