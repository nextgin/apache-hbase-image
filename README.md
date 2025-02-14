# Apache HBase `ARM64`/`AMD64`

Apache HBase Docker image with support for both ARM64 and AMD64 architectures.

## Build image

```shell
$ docker build -t my-hbase .
```

## Run locally

### Prerequisites

Add the following entry to your `/etc/hosts` file:

```text
# ...
127.0.0.1 hbase.internal
```

### Start instance

```shell
$ docker run --name=hbase-docker \
 -h hbase.internal \
 -p 8080:8080 \
 -p 9090:9090 \
 -p 9095:9095 \
 -p 2181:2181 \
 -p 16010:16010 \
 -p 16000:16000 \
 -p 16020:16020 \
 -v hbase_data:/data/hbase \
 -v hbase_logs:/data/logs \
 -v zk_data:/data/zookeeper \
 --rm \
 my-hbase
```

### Port Mappings

- `8080`: HBase Rest API
- `9090`: Thrift API
- `9095`: Thrift Web UI
- `2181`: ZooKeeper
- `16000`: Master node API
- `16010`: Master node UI
- `16020`: Region node API
- `16030`: Region node UI

### Volumes

The container uses three Docker volumes to persist data and logs:

- `/data/hbase`: HBase data directory
- `/data/logs`: HBase log files
- `/data/zookeeper`: ZooKeeper files

> - The container sets `hbase.internal` as the hostname, which is required for proper HBase
    operation.
> - The `--rm flag` automatically removes the container when it stops.

### Environment variables

- `HBASE_VERSION`: defaults to `2.5.10`. You can modify this to your desired version.

## Connect to HBase shell

```shell
$ docker exec -it hbase-docker /bin/sh
$ /opt/hbase/bin/hbase shell
```