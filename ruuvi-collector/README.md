# RuuviCollector

These instructions are for running ruuvi2influx inside docker container to collect measurements from RuuviTags and storing them in InfluxDB.
Docker image used: [jvaltteri/ruuvi2influx](https://hub.docker.com/r/jvaltteri/ruuvi2influx)

----

## Overview

Intended for **Raspberry Pi Zero** (ARM32v6). Images are first pushed as **ARM32v6**. Other versions may be pushed later.
If a suitable version is not available for download, you can build one yourself.

Based on [debian:bullseye-slim image](https://hub.docker.com/_/debian?tab=tags&page=1&name=bullseye-slim) image. 

## Config

For a more [detailed description](https://github.com/JValtteri/ruuvi2influx#config), refer to the source repositrory.

### Mandatory keys in configuration

| Key    | Default  | Explanation            |
| ----------------- | - | ------------------ |
| `"sample_interval"`  | 2 | Time between pings |
| `"event_queue"`     | 15000 | How meny pings are buffered if network is interrupted. |
| `"db_name"`         | "db" | The InfluxDB name |
| `"db_user"`         | "user" | Username to log in to the InfluxDB |
| `"db_password"`     |   | the InfluxDB password |
| `"db_host"`         | "localhost" | the address to the InfluxDB. ```!! omit 'https:\\' !!``` |
| `"db_port"`         | 8086 | Port used to connect to the InfluxDB |

### Example ***config.yml***
```yaml
######################################
# RuuviTag-logger Configuration file #
######################################

# SAMPLE INTERVAL
sample_interval: 60 # seconds
# Listening is constant. If you are building a databace, 
# you may use this to limit the data resolution to a 
# reasonable rate.
# To turn off filtering and internal processing, set 
# sample_interval to 0.

# EVENT QUEUE
event_queue: 15000

# INFLUX DB
db: True                                        # Enable or disable database
db_name: ruuvitags
db_user: sensor
db_password: password
db_host: 127.0.0.1
db_port: 8086

column_width: 14  # Column width on screen (14 default)

# List and name your tags
tags:
  "CC:CA:7E:52:CC:34": Backyard
  "FB:E1:B7:04:95:EE": Upstairs
  "E8:E0:C6:0B:B8:C5": Downstairs
```

place `config.yaml` in the directory where you are starting your container

## Run

Run the convenience script: `./start-collector.sh`

Script contains the recommended start command:
```
$ docker run \
    -d \
    --name ruuvi \
    --restart unless-stopped \
    --net=host \
    --cap-add=NET_ADMIN \
    --mount type=bind,source="$(pwd)"/config.yml,target=/app/config.yml,readonly \
    ruuvi2influx:latest
```

## Source
Source repository and documentation on [GitHub](https://github.com/JValtteri/ruuvi2influx)

## Build It Your Self

If a compatible, or up-to-date image isn't available, you can build one locally with these commands:
```
$ git clone https://github.com/JValtteri/ruuvi2influx.git
$ docker build -f Debian.dockerfile --tag ruuvi2influx .
```
