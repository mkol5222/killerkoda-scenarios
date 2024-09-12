#  Self-signed certificate

```shell
# start CA by private key
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 3650 -key ca.key -out ca.crt -subj "/CN=registry-ca"

# server key, csr and cert
openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr -subj "/CN=reg.localtest.me" -addext "subjectAltName = DNS:reg.localtest.me"
openssl x509 -req -days 3650 -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt
```{{exec}}

```shell
openssl x509 -in server.crt -text -noout | egrep 'DNS|CN'
```{{exec}}