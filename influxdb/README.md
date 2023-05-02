# InfluxDB

These instructions are for running InfluxDB docker container as database for
RuuviTags measurement data together with RuuviCollector and Grafana.

## Initial creation

### Generate configuration 

```
sudo docker run --rm mendhak/arm32v6-influxdb influxd config > influxdb.conf
```

### Make the following changes to the configuration file `influxdb.conf`

| Section | Key | Value | Notes |
| :--: | :--: | :--: | :-- |
| `[data]` | `cache-max-memory-size` | `"256m"` | Limits the amount of memory influxdb will allocate to itself |
|`[data]` | `max-concurrent-compactions` | `1` | Use max two cores to perform compactions |
| `[monitor]` | `store-enabled` | `false` | Disable internal monitoring. This causes a lot of performance issues on Raspberry when enabled: <https://github.com/influxdata/influxdb/issues/9475> |

### Run Influxdb

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

### Create database for ruuvi-collector

#### Connect to influxdb with influx client

 ```
 ./connect-to-influxdb.sh
 ```

#### Execute the following command to create the needed ruuvi database with
 eight year retention policy (optional)
 
 ```
 > CREATE DATABASE yourdatabacename
 > SHOW DATABASES
 ```

####

#### For more, see the source repository

https://github.com/mendhak/docker-arm32v6-influxdb

-------

## Update influxdb container

1. Pull new version `./update-image.sh`
2. Backup database: `./backup.sh`
    - Deletes previous old backup from `./backup/old` if exists
    - Moves existing latest backup from `./backup/latest` to `./backup/old`
    - Creates new backup to `./backup/latest`
3. Rename old container for backup: `sudo docker container rename influxdb{,-old}`
4. Stop old container `sudo docker container stop influxdb-old`
5. Start new version: `./start-influxdb.sh`
6. Restore database: `./restore-from-backup.sh`

7. Verify that restored data is visible in Grafana
8. Verify RuuviCollector is able to store new data
9. Remove old container: `sudo docker container rm influxdb-old`
10. Remove unused images: `sudo docker image prune`
11. Optionally remove older backup to save disk space `rm -rf ./backup/old`
