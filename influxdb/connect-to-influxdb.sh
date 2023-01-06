#!/bin/bash

set -ex

sudo docker run \
     --rm \
     -it \
     --link=influxdb \
     --network grafana-influxdb \
     --name influxdb
     mendhak/arm32v6-influxdb:latest \
     influx -host influxdb

$ docker --mount type=bind,source="$(pwd)"/config.yml,target=/app/config.yml,readonly ruuvitag-logger-py:debian
