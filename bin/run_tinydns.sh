#!/bin/sh

cat >> /root/.ssh/config <<EOF
StrictHostKeyChecking no
EOF

if [ ! -d /etc/tinydns/root/.git ]; then
    cd /
    rm -rf /etc/tinydns/root/* /etc/tinydns/root/.git
    #cd /etc/tinydns/root
    #git clone $GIT_DNSDATA .
    git clone $GIT_DNSDATA /etc/tinydns/root
fi

# Runs git pull && make in a while loop to avoid cron installation
/dnsdata_update.sh 2>&1 &

for i in `ls -1 /etc/tinydns/env`
do
  eval $i=`cat /etc/tinydns/env/$i`
  eval export $i
done

sleep 2

tinydns 2>&1 | /usr/local/bin/tai64n | /usr/local/bin/tai64nlocal
