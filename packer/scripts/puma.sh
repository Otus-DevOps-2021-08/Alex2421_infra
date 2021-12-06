#!/bin/bash

cd /opt
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
mv /tmp/puma.service /lib/systemd/system/puma.service
systemctl enable puma.service && systemctl start puma.service
