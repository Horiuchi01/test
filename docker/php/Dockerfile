FROM php:8.1-fpm

COPY php.ini /usr/local/etc/php/

# apt
RUN apt-get update

# timezone
RUN apt-get install -y tzdata

# pdo
RUN apt-get install -y zlib1g-dev libzip-dev default-mysql-client \
    && docker-php-ext-install zip pdo_mysql

# mbstring
RUN apt-get install -y libonig-dev

# exif
RUN docker-php-ext-install exif

# GD
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# BCMATH
RUN docker-php-ext-install bcmath

# git
RUN apt-get install -y git

# phpredis
RUN git clone https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis
RUN docker-php-ext-install redis

# composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV PATH $PATH:/composer/vendor/bin

# node
RUN apt-get install -y wget git unzip libpq-dev \
    &&  curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs

# vim
RUN apt-get install -y vim

# install cron
RUN apt-get install -y cron
# copy config file into container
COPY crontab /var/spool/crontab/root
# load config file
RUN crontab /var/spool/crontab/root
# to avoid failed at tail -f when before very first cron running
RUN touch /var/log/cron.log

# install supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY laravel-worker.conf /etc/supervisor/conf.d/laravel-worker.conf

# workdir
WORKDIR /var/www

# vite 用のポートリスン宣言（実行時に "-p 5173:5173" 等で実際にポートを開けてくださいの意味）
EXPOSE 5173
