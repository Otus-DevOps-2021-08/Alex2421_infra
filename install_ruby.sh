#!/bin/bash
#update and install
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

#test ruby and bundler
ruby -v
bundler -v
