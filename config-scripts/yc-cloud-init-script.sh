#!/bin/bash

echo "======Put public key to authorized_keys======"
PUBKEY="- ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDnUHhUfPX9xRkuVJmyp0wgBtgU82ZzPxSpQ62V82KmzU0oNI8maepGkIoppEOXQmNriX5mH5jg0PONKbYAQMFENFEByM11iyBHzgssDsUne05/JD2pufewPgY3mtZW5Rq6kXpDXlKTuYEw6f7gYxHU9NjluwSJc+EJoaD6sbnDwC7U1wvew9SGwC9rEVOMjURi7STtd8lb1d2cTQ/L2MnEb4uKuSO5wS0F/gaE31ulLQ2QAqirZytzXYYGsEUdW9/a2GfEMsJRbjs8qlQQUYz69PoUtuBWUvofc5FOftl7GLrJ48JWe30vUX0PspJdb1AF0mGeuQ2ZCgi2WAnTZ1m105NFtDhpznw3AvKvbQiW/uTqPZMmmUgSg2Iwunh54jed1wXr3LLOEhBsaR0n01gpD6RePPI39AUw9RizDa+DGIB0GvKIIouFa/hkXENVQuRwJ9sYhNnEvl1/F1t5LmPkv7ctYa298usGOwaKVmiCKOT3LFfRWb5QpDg6bZWuFZs= appuser"
sudo echo $PUBKEY > ~/.ssh/authorized_keys

echo "======Create user======"
USERNAME="yc-user"
adduser --disabled-password --gecos "" $USERNAME
echo "$USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USERNAME
sudo -i -u $USERNAME bash << EOF
echo "Run installation as user:"
whoami
mkdir /home/$USERNAME/.ssh
touch /home/$USERNAME/.ssh/authorized_keys
echo $PUBKEY > /home/$USERNAME/.ssh/authorized_keys
chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
chmod 0700 /home/$USERNAME/.ssh
chmod 0600 /home/$USERNAME/.ssh/authorized_keys
echo "======Install Ruby======"
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential
ruby -v
bundler -v
echo "======Install and run MongoDB======"
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl status mongod
echo "======Deploy Reddit======"
sudo apt-get update
sudo apt-get install -y git
cd ~ && git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
echo "======Project processes======"
ps aux | grep puma
echo "Finish installation as user $(whoami)"
EOF
