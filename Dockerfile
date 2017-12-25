FROM ubuntu:xenial

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update -y \
  && apt-get install -y wget python python-argparse python-bcrypt python-openssl logrotate net-tools iproute2 iputils-ping \
  && wget "https://www.aerospike.com/download/server/latest/artifact/ubuntu16" -O aerospike-server.tgz \
  && mkdir aerospike \
  && tar xzf aerospike-server.tgz --strip-components=1 -C aerospike \
  && dpkg -i aerospike/aerospike-server-*.deb \
  && dpkg -i aerospike/aerospike-tools-*.deb \
  && mkdir -p /var/log/aerospike/ \
  && mkdir -p /var/run/aerospike/ \
  && rm -rf aerospike-server.tgz aerospike /var/lib/apt/lists/* \
  && dpkg -r wget ca-certificates \
  && dpkg --purge wget ca-certificates \
  && apt-get purge -y

COPY ./aerospike.conf /etc/aerospike/aerospike.conf
COPY ./entrypoint.sh /entrypoint.sh
RUN  chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["asd"]