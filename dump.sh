#!/usr/bin/env bash

docker-compose exec mysql sh -c 'exec mysqldump --hex-blob ianseo -u"ianseo" -p"ianseo"' > ianseo_$(date +%s).sql
