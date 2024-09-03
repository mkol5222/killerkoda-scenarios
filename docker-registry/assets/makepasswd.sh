#!/bin/bash

# echo -n 'devops:' > htpasswd
# openssl passwd -apr1 >> htpasswd

docker run --rm --entrypoint htpasswd httpd -Bbn devops vpn123 >htpasswd