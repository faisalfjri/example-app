FROM php:8.1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libwebp-dev \
    libxpm-dev \
    libmcrypt-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    nano

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Enable GD with jpg
RUN docker-php-ext-configure gd \
	--with-jpeg \
	--with-webp \
	--with-xpm \
	--with-freetype

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_pgsql pdo_mysql mbstring exif pcntl bcmath gd

# Install mcrypt
RUN pecl install mcrypt-1.0.5 \
    && docker-php-ext-enable mcrypt;

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
