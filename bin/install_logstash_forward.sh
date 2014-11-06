#!/usr/bin/env bash
#2014-11-06

cp /etc/apt/sources.list /etc/apt/sources.list.date '+%y%m%d%H%M'
echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | tee /etc/apt/sources.list.d/logstashforwarder.list
apt-get update
apt-get install -y logstash-forwarder
cd /etc/init.d/
wget https://raw.github.com/elasticsearch/logstash-forwarder/master/logstash-forwarder.init -O logstash-forwarder
chmod +x logstash-forwarder
update-rc.d logstash-forwarder defaults
mkdir -p /etc/pki/tls/certs
