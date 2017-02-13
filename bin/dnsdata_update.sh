#!/bin/sh

cd /
while /bin/true
do
  #date
  # Ignore DEPRECATED due to docker gogs image that needs updating
  cd /etc/tinydns/root && git pull 2>&1 | egrep -ve "(is up to date.|Already up-to-date|DEPRECATED)"
  make 2>&1 | egrep -ve "(is up to date.|Already up-to-date|DEPRECATED|^/usr/local/bin/tinydns-data$)"
  sleep $GIT_UPDATE_FREQUENCY
done
