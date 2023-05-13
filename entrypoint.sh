#!/bin/bash

# replace flexibee config values
for value in host port user password forceHttps
do
  new_value=$(echo "POSTGRES_$value" | tr '[:lower:]' '[:upper:]')
  sed -i "s/<entry key=\"$value\">[^<]*<\/entry>/<entry key=\"$value\">${!new_value}<\/entry>/" /etc/flexibee/flexibee-server.xml
done

# start flexibee & wait forever
./etc/init.d/flexibee start && tail -F /var/log/flexibee.log

