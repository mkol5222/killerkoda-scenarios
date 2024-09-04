#!/bin/bash

# echo -n 'devops:' > htpasswd
# openssl passwd -apr1 >> htpasswd

# read only
echo -n > htpasswd-ro
docker run --rm --entrypoint htpasswd httpd -Bbn read vpn123 >>htpasswd-ro
# write and read
echo -n > htpasswd-rw
docker run --rm --entrypoint htpasswd httpd -Bbn write vpn123 >>htpasswd-rw
docker run --rm --entrypoint htpasswd httpd -Bbn write vpn123 >>htpasswd-ro

cat htpasswd-ro
cat htpasswd-rw

curl -u write:vpn123 -k https://reg.localtest.me/v2/_catalog
curl -u read:vpn123 -k https://reg.localtest.me/v2/_catalog