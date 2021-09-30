#!/bin/bash

apt-get update
echo "sleep 2m for install updates"; sleep 2m; echo "start install ruby"
DEBIAN_FRONTEND=noninteractive apt-get install -y ruby-full ruby-bundler build-essential git
