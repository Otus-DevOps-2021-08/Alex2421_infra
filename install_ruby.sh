#!/bin/bash
#update OS
sudo apt update
#insatall ruby&bundler
sudo apt install -y ruby-full ruby-bundler build-essential
#test ruby and bundler
ruby -v
bundler -v
