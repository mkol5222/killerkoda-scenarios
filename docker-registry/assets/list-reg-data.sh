#!/bin/bash

docker volume ls | grep registry 
docker run --rm -it -v root_registry_data:/data ubuntu find /data/

curl -u read:vpn123 -k https://reg.localtest.me/v2/_catalog
curl -u write:vpn123 -k https://reg.localtest.me/v2/_catalog