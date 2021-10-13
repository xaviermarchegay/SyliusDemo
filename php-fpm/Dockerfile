FROM php:8.0-fpm

MAINTAINER Xavier MARCHEGAY <xmarchegay@clever-age.com>

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    mariadb-client \
    pv \
    sudo \
    build-essential \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libjpeg-dev \
    libjpeg-turbo-progs \
    libonig-dev \
    libpng-dev \
    libssl-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libxslt-dev \
    libicu-dev \
    libzip-dev \
    libwebp-dev \
    zlib1g-dev \
    libsodium-dev \
    xvfb \
    libfontconfig \
    fontconfig \
    libx11-6 \
    libxcb1 \
    libxext6 \
    libxrender1 \
    xfonts-base \
    xfonts-75dpi

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp

RUN docker-php-ext-configure hash --with-mhash

RUN docker-php-ext-install bcmath \
    exif \
    fileinfo \
    iconv \
    intl \
    gd \
    mbstring \
    opcache \
    pcntl \
    pdo \
    pdo_mysql \
    simplexml \
    xml \
    zip \
    sodium

RUN pecl install redis && docker-php-ext-enable redis

## PDF
# https://github.com/wkhtmltopdf/wkhtmltopdf/releases
RUN curl -fsLo wkhtmltox.deb https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb && \
    dpkg -i wkhtmltox.deb && \
    rm -f wkhtmltox.deb && \
    wkhtmltopdf -V

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Opcache
COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Permissions
RUN usermod -u 1000 www-data

# Create partage/composer dir
RUN mkdir -p /var/www/partage /var/www/.composer
RUN chown -R www-data:www-data /var/www/.composer

# Cachetool
RUN curl -s -o /tmp/cachetool.phar https://gordalina.github.io/cachetool/downloads/cachetool.phar

# Workdir
WORKDIR /var/www/html
