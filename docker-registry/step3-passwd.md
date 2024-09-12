# User accounts

```shell
# read only
echo -n > htpasswd-ro
docker run --rm --entrypoint htpasswd httpd -Bbn read vpn123 >>htpasswd-ro
# write and read
echo -n > htpasswd-rw
docker run --rm --entrypoint htpasswd httpd -Bbn write vpn123 >>htpasswd-rw
docker run --rm --entrypoint htpasswd httpd -Bbn write vpn123 >>htpasswd-ro

cat htpasswd-ro
cat htpasswd-rw
```