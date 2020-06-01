# Build environment
FROM alpine

WORKDIR /app

RUN apk update && apk add ruby build-base ruby-dev libffi-dev zlib-dev graphviz
RUN gem install bundler
COPY Gemfile /app
COPY Gemfile.lock /app

RUN bundle update --bundler
RUN bundle install

COPY . /app
RUN JEKYLL_ENV=production jekyll build

# Run environment
FROM alpine
MAINTAINER Lucas Teske <lucas@teske.net.br>

RUN apk --update --no-cache add \
        bash \
        nginx \
        openrc \
        tzdata \
        inotify-tools \
        libxml2-dev \
    && rm -rf /var/cache/apk/*

RUN sed -i 's/user  nginx;/user  nginx;\ndaemon off;/' /etc/nginx/nginx.conf && \
    sed -i 's/error_log .*;/error_log  \/dev\/stderr warn;/g' /etc/nginx/nginx.conf && \
    sed -i 's/access_log .*;/access_log  \/dev\/stdout main;/g' /etc/nginx/nginx.conf && \
    sed -i 's/#gzip  on;/gzip  on;/g' /etc/nginx/nginx.conf

RUN mkdir -p /var/www && mkdir -p /var/tmp

COPY --from=0 /app/_site/ /var/www/

RUN chown -R nginx.nginx /var/www/ && \
    chmod 777 -R /var/tmp/ && \
    mkdir -p /var/logs/nginx/ && \
    chown -R nginx.nginx /var/logs/nginx/ && \
    mkdir -p /run/nginx/ && \
    chown -R nginx.nginx /run/nginx/ && \
    echo "daemon off;" >> /etc/nginx/nginx.conf

WORKDIR /opt
COPY site.conf /etc/nginx/conf.d/default.conf
COPY run.sh .
RUN chmod 777 /opt/run.sh

CMD /opt/run.sh
