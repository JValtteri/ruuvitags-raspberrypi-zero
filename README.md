# RuuviTags data collection on Raspberry PI

These tools provide means to collect measurement data from [**RuuviTags**](https://ruuvi.com/), store it
in [**InfluxDB**](https://www.influxdata.com/) and [visualize](https://play.grafana.org/d/000000012/grafana-play-home?orgId=1) the data with [**Grafana**](https://grafana.com/).
 the data.

------

## Setup ruuvi2influx

#### Pull The Docker Image

```docker pull jvaltteri/ruuvi2influx```

*At the time of writing, the ready image is only for* **ARM32v6** *(Rasapberry Pi Zero).*

#### Configuration

See [**Config**](https://github.com/JValtteri/ruuvi2influx/blob/master/README.md#configure) in *JValtteri/ruuvi2influx/README.md* for detais.

#### Run ruuvi2influx

Debian based image
```bash
$ docker run \
    -d \
    --name ruuvi \
    --restart unless-stopped \
    --net=host \
    --cap-add=NET_ADMIN \
    --mount type=bind,source="$(pwd)"/config.yml,target=/app/config.yml,readonly \
    ruuvi2influx:latest
```

------

## Setup InfluxDB

#### PiZero compatible image
```
docker pull mendhak/arm32v6-influxdb
```
*This repo is inactive and out of date. It is recommended to build the container yourself*

#### Building it yourself

```
git clone https://github.com/mendhak/docker-arm32v6-influxdb.git
docker build -t mendhak/arm32v6-influxdb .
```

#### Configuration
See [influxdb/README.md](influxdb/README.md) for detais.

#### Run InfluxDB

```
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
```

------

## Setup Grafana

#### PiZero compatible image

There doesn't seem to be any reasonably up-to-date Grafana version compatible with Raspberry Pi Zero W (ARMv6). It is recommended to use a **Pi 3** or newer for hosting **Grafana**. Official ```grafana/grafana:latest``` image supports **ARMv7** and newer.

#### Official image
```
docker pull grafana/grafana
```

#### Configuration
See [grafana/README.md](grafana/README.md) for detais.

#### Run Grafana

```
sudo docker run \
    -d \
    -p 3000:3000 \
    --network grafana-influxdb \
    --name grafana \
    --restart unless-stopped \
    -e "GF_AUTH_ANONYMOUS_ENABLED=true" \
    -e "GF_AUTH_ANONYMOUS_ORG_NAME=Koti" \
    -v grafana-storage:/var/lib/grafana \
    grafana/grafana
```


------

## Updates

New versions of all of these tools provide security fixes, bug fixes and new
features. Update all to newer versions every once in a while.

README files of each component contain update instructions.
