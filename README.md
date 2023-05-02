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

#### Run the ready image

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
mendhak/arm32v6-influxdb
```

#### Configuration
See [influxdb/README.md](influxdb/README.md) for detais.

#### Run the ready image

```

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

#### Run the ready image

```

```


------

## Updates

New versions of all of these tools provide security fixes, bug fixes and new
features. Update all to newer versions every once in a while.

README files of each component contain update instructions.
