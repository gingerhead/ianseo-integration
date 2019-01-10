#!/usr/bin/env bash

set -a
INSTALL_IANSEO="false"

docker-compose down -v
docker-compose up
