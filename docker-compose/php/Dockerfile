FROM php:8.2-fpm as php_crm
WORKDIR "/var/www"

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update;\
    apt-get -y --no-install-recommends install\
    	libfreetype-dev \
		libjpeg62-turbo-dev \
		libpng-dev \
        zlib1g-dev \
        libicu-dev \
        libzip-dev \
        locales-all\
        g++ \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install exif \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli

ENV LANG en_US.UTF-8
ENV LC_ALL en.utf8