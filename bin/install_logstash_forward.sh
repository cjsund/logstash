#!/usr/bin/env bash
#2014-11-06

set -e
cp /etc/apt/sources.list /etc/apt/sources.list.`date '+%y%m%d%H%M'`
echo 'deb http://packages.elasticsearch.org/logstashforwarder/debian stable main' | tee /etc/apt/sources.list.d/logstashforwarder.list
apt-get update
apt-get -y install logstash-forwarder --force-yes
cd /etc/init.d/
wget https://raw.github.com/elasticsearch/logstash-forwarder/master/logstash-forwarder.init -O logstash-forwarder
chmod +x logstash-forwarder
update-rc.d logstash-forwarder defaults
mkdir -p /etc/pki/tls/certs

cat > /etc/logstash-forwarder << EOF
{
  "network": {
    "servers": [ "192.168.1.253:5000" ],
    "timeout": 15,
    "ssl ca": "/etc/pki/tls/certs/logstash-forwarder.crt"
  },
  "files": [
    {
      "paths": [
        "/var/log/syslog",
        "/var/log/auth.log"
       ],
      "fields": { "type": "syslog" }
    }
   ]
}

EOF