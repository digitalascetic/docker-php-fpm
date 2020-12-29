# docker-php-fpm

*Based on php-{version}-fpm-alpine images*

php-fpm 7.4 (default) version container configurable through environment variables:

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


### Build
```
# You can change the DEFAULT_PHP_VERSION argument
docker build --build-arg DEFAULT_PHP_VERSION=7.4 -t ascetic/php-fpm .
```

### RUN
```
docker run -i -d --name php -p 9000:9000 --network {SAME_NETWORK_AS_WEB_SERVER}  -t ascetic/php-fpm
```