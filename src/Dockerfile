FROM ubuntu:16.04

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
    && apt-get install -y nginx curl zip unzip software-properties-common supervisor sqlite3 gettext-base \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php7.1-fpm php7.1-cli php7.1-mcrypt php7.1-gd php7.1-mysql \
       php7.1-mbstring php7.1-xml php7.1-curl php7.1-sqlite3 \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && mkdir /run/php \
    && apt-get remove -y --purge software-properties-common \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/php/7.1/fpm/php-fpm.conf \
    /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default \
    && echo "daemon off;" >> /etc/nginx/nginx.conf

# Copy config files.
COPY conf/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf.template
COPY conf/default-site /etc/nginx/sites-available/default.template
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf.template

# Symlink the nginx conf.
RUN ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

# Copy entrypoint script.
COPY entrypoint.sh /bin/entrypoint.sh

# Set the environment variables.
ENV APP_LOG_LEVEL notice
ENV APP_DOMAIN localhost

EXPOSE 80

ENTRYPOINT ["/bin/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
