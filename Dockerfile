FROM eclipse-temurin:8-jre-noble

LABEL maintainer=ooutama.com

ENV HBASE_VERSION=2.5.10

RUN mkdir -p /opt  \
    && cd /opt \
    && wget https://dlcdn.apache.org/hbase/stable/hbase-${HBASE_VERSION}-bin.tar.gz \
    && tar xvzf hbase-${HBASE_VERSION}-bin.tar.gz \
    && mv hbase-${HBASE_VERSION} /opt/hbase \
    && rm -rf hbase-${HBASE_VERSION}-bin.tar.gz \
    && rm -rf docs *.md *.txt *.cmd LEGAL \
    && ln -sf /opt/hbase/bin/* /usr/bin

ENV HBASE_SERVER=/opt/hbase/bin/hbase

COPY config/* /opt/hbase/conf/

COPY ./hbase-server /opt/hbase-server

VOLUME /data

# REST API
EXPOSE 8080

# Thrift API
EXPOSE 9090

# Thrift Web UI
EXPOSE 9095

# HBase's zookeeper - used to find servers
EXPOSE 2181

# HBase Master web UI at :16010/master-status;  ZK at :16010/zk.jsp
EXPOSE 16010

CMD ["/opt/hbase-server"]