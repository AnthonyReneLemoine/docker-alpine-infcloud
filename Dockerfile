FROM alpine:latest

RUN apk update && apk add nginx apache2-utils py-pip curl libarchive-tools bash

RUN adduser -D -u 1000 -g 'www' www && \
    mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
COPY nginx.conf /etc/nginx/nginx.conf

RUN pip install --upgrade pip && \
    pip install radicale

RUN mkdir -p /etc/radicale && \
    touch /etc/radicale/users
COPY config /etc/radicale/config
COPY rights /etc/radicale/rights
COPY rad-admin /usr/local/bin/rad-admin
RUN chmod +x /usr/local/bin/rad-admin

RUN curl -Ls https://www.inf-it.com/InfCloud_0.13.1.zip | bsdtar -xf- --strip 1 -C /www
COPY config.js /www/config.js
RUN chown -R www:www /www && \
    chmod +x /www/cache_update.sh

EXPOSE 80 5232
VOLUME ["/etc/radicale/collections"]

## copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

## start Radicale & Nginx
CMD ["/start.sh"]

