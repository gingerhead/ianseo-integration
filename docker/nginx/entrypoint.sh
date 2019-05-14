#!/bin/bash
if [[ $NGINX_DEV == "true" ]]; then
    echo "nginx use DEV CONFIG"
    cp /tmp/dev.conf /etc/nginx/conf.d/default.conf
fi

if [[ $NGINX_HTTPS == 'true' ]]; then
    echo "nginx use HTTPS PROD CONFIG"
    cp /tmp/prod-https.conf /etc/nginx/conf.d/default.conf
fi

exec "$@"
