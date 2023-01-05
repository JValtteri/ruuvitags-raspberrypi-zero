#!/bin/bash

set -xe

sudo docker run \
    -d \
    -p 3000:3000 \
    --network grafana-influxdb \
    --name grafana \
    --restart unless-stopped \
    -e "GF_AUTH_ANONYMOUS_ENABLED=true" \
    -e "GF_AUTH_ANONYMOUS_ORG_NAME=Koti" \
    --mount type=bind,source="$(pwd)/grafana-storage",target=/var/lib/grafana \
    grafana/grafana
