#!/bin/bash

set -ex

sudo docker run \
    -d \
    -p 127.0.0.1:8086:8086 \
    --network grafana-influxdb \
    --name influxdb \
    --restart unless-stopped \
    -v "$(pwd)"/influxdbdata:/root/.influxdb/data/
    -v "$(pwd)"/backup:/tmp/backups/ \
    -v "$(pwd)"/influxdb.conf:/etc/influxdb/influxdb.conf:ro \
    mendhak/arm32v6-influxdb:latest -config /etc/influxdb/influxdb.conf
