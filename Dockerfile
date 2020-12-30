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

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Copy the PHP-FPM configuration file
COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

EXPOSE $PHP_FPM_PORT