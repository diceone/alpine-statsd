#!/bin/bash

sed -i "s/graphite.example.com/${GRAPHITEHOST}/g" /etc/statsd/config.js
sed -i "s/2003/${GRAPHITEPORT}/g" /etc/statsd/config.js
sed -i "s/8125/${STATSDPORT}/g" /etc/statsd/config.js

exec /usr/bin/node stats.js /etc/statsd/config.js
