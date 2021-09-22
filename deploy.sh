#!/bin/bash
#install GIT
sudo apt install git
#copy cod
git clone -b monolith https://github.com/express42/reddit.git
#install addiction
cd reddit && bundle install
#run application
 puma -d
 #server check
 ps aux | grep puma
