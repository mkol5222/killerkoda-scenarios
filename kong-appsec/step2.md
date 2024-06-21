Lets introduce API Gateway in front of our API server.

Download Kong Gateway 3.1.1 package and install it:
```
curl -Lo kong-3.1.1.amd64.deb "https://packages.konghq.com/public/gateway-31/deb/ubuntu/pool/focal/main/k/ko/kong_3.1.1/kong_3.1.1_amd64.deb" && sudo dpkg -i kong-3.1.1.amd64.deb
```{{exec}} 

Configure Kong Gateway to use declarative configuration and disable database:
```
sed -e '1idatabase = off' -e '1ideclarative_config = /etc/kong/kong.yml' /etc/kong/kong.conf.default > /etc/kong/kong.conf
```{{exec}} 

Lets expose our API on Kong Gateway:
```
cat <<EOF >> /etc/kong/kong.yml
_format_version: "2.1"
services:
- name: vulnerable-api-server
  url: http://localhost:8080
routes:
- name: vulnerable-api-server
  service: vulnerable-api-server
  paths:
  - /
EOF
```{{exec}} 

Restart Kong Gateway to apply configuration changes:
```
kong restart -c /etc/kong/kong.conf
```{{exec}}

API is now accessible via Kong Gateway on port 8000:

```
curl -s -G -v -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImpvaG4uc21pdGhAZXhhbXBsZS5jb20iLCJpZCI6MX0.pnlUuw6CzSG2In05n7WMDFP1l5GeqyAnWN98x9zcAc0" \
--data-urlencode "email=john.smith@example.com' OR '1'='1" \
http://localhost:8000/getemployees | jq .
```{{exec}} 
