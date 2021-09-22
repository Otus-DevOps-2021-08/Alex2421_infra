#!/bin/bash
#uploadinf repo
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
#updating repo
sudo apt-get update
#install mongodb
sudo apt-get install -y mongodb-org
#starting mongodb
sudo systemctl start mongod
#added to autorun
sudo systemctl enable mongod
#check status
sudo systemctl status mongod
