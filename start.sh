#!/usr/bin/env bash

set -a
INSTALL_IANSEO="true"
NGINX_DEV="false"
docker-compose pull
docker-compose up -d
