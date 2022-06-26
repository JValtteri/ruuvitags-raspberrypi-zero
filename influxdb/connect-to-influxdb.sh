#!/bin/bash

set -ex

sudo docker run \
     --rm \
     -it \
     --link=influxdb \
     --network grafana-influxdb \
     mendhak/arm32v6-influxdb:latest \
     influx -host influxdb
