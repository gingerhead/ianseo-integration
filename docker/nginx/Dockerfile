FROM nginx:1.13.12

#For config debugging
#RUN apt-get update && apt-get install nano iputils-ping -qq -y

RUN mkdir -p /var/public/

COPY entrypoint.sh /
COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/prod.conf /etc/nginx/conf.d/default.conf
COPY config/dev.conf /tmp/dev.conf

ENTRYPOINT ["/entrypoint.sh"]

COPY wait-for-upstreams.sh /wait-for-upstreams.sh
