ARG DEFAULT_PHP_VERSION=7.4

FROM php:${DEFAULT_PHP_VERSION}-fpm-alpine
MAINTAINER tech@ascetic.io

# PHP-FPM defaults
ENV PHP_FPM_USER="www-data"
ENV PHP_FPM_GROUP="www-data"
ENV PHP_FPM_PORT="9000"
ENV PHP_FPM_PM="dynamic"
ENV PHP_FPM_MAX_CHILDREN="5"
ENV PHP_FPM_START_SERVERS="2"
ENV PHP_FPM_MIN_SPARE_SERVERS="1"
ENV PHP_FPM_MAX_SPARE_SERVERS="2"
ENV PHP_FPM_MAX_REQUESTS="1000"

## Install system dependencies and php dependencies
RUN apk update && \
    # Add dev dependencies required to build packages (later we can remove it)
    apk add --no-cache --virtual .build-deps git autoconf gcc g++ make \
    # ZIP
    bzip2-dev zlib-dev \
    # XML
    libxml2-dev ldb-dev \
    # INTL
    icu-dev \
    # SSL
    openssl-dev && \
    # Add dependencies required for PECL extensions /// re2c (required by mailparse)
    apk add --no-cache acl openssl icu-libs libintl libzip-dev && \
    # Install and Enable PHP packages
    docker-php-ext-configure bcmath --enable-bcmath && \
    docker-php-ext-configure intl --enable-intl && \
    docker-php-ext-configure bz2 && \
    docker-php-ext-configure zip && \
    docker-php-ext-configure mysqli --with-mysqli=mysqlnd && \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd && \
    docker-php-ext-install bcmath zip bz2 pdo_mysql mysqli intl && \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && \
    ## Cleanup
    apk del .build-deps && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

# Copy the PHP-FPM configuration file
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

EXPOSE $PHP_FPM_PORT