FROM alpine:3.5

ENV GRAPHITEHOST graphite.example.com
ENV GRAPHITEPORT 2003
ENV STATSDPORT 8125

RUN apk update && apk add nodejs

RUN \
  apk --update add bash python make gcc g++ && \
  USER=root npm install --global statsd && \
  USER=root npm install --global statsd-amqp-backend && \
  USER=root npm install --global statsd-influxdb-backend && \
  apk --purge del python make gcc g++ && \
  npm cache clean && \
  cd /usr/lib/node_modules && \
  mkdir -p /etc/statsd && \
  cp /usr/lib/node_modules/statsd/exampleConfig.js /etc/statsd/config.js
COPY run.sh /run.sh
WORKDIR /usr/lib/node_modules/statsd/
CMD ["/bin/bash", "/run.sh"]
EXPOSE 8125
