#!/bin/bash

yc compute instance create \
  --name reddit-vm \
  --hostname reddit-vm \
  --cores=2 \
  --memory=2 \
  --core-fraction=20 \
  --create-boot-disk image-id=fd8vkmrjb10ge19blod1,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --ssh-key ~/.ssh/appuser.pub
