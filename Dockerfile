FROM vcarreira/php5

MAINTAINER "Vitor Carreira" <vitor.carreira@gmail.com>

WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    nginx \
    php5-fpm \
    supervisor

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx
RUN mkdir -p /var/run/php-fpm
RUN mkdir -p /var/log/supervisor

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-supervisor.conf /etc/supervisor/conf.d/nginx.conf
COPY www.conf /etc/php5/fpm/pool.d/www.conf

VOLUME ["/var/www", "/etc/nginx/sites-enabled"]

EXPOSE 80 9000

CMD ["/usr/bin/supervisord"]
