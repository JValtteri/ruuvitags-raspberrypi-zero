#!/bin/bash

docker run \
    -d \
    --name ruuvi \
    --network grafana-influxdb \
    --restart unless-stopped \
    --net=host \
    --cap-add=NET_ADMIN \
    --mount type=bind,source="$(pwd)"/config.yml,target=/app/config.yml,readonly \
    ruuvitag-logger-py:deb-v0.2
