# docker-php-fpm

php-fpm 7.4 version container configurable through environment variables:

```
ENV PHP_FPM_USER="www-data"
ENV PHP_FPM_GROUP="www-data"
ENV PHP_FPM_PORT="9000"
ENV PHP_FPM_PM="dynamic"
ENV PHP_FPM_MAX_CHILDREN="5"
ENV PHP_FPM_START_SERVERS="2"
ENV PHP_FPM_MIN_SPARE_SERVERS="1"
ENV PHP_FPM_MAX_SPARE_SERVERS="2"
ENV PHP_FPM_MAX_REQUESTS="1000"
```