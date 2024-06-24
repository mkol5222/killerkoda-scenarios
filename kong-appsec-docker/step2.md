Lets introduce API Gateway in front of our API server.

Create new CloudGuard WAF Profile - type Docker - dual-container with Kong.
Make sure to publish and ENFORCE policy before using the token.
Note profile token for command below:

```
export TOKEN=your-real-token
```

Lets expose sample API on Kong Gateway:
```
cat <<EOF >> kong.yml
_format_version: "2.1"
services:
- name: vulnerable-api-server
  url: http://172.19.0.1:8080
- name: ip-iol-cz-service
  url: http://ip.iol.cz/ip/
routes:
- name: vulnerable-api-server
  service: vulnerable-api-server
  paths:
  - /
- name: ip
  service: ip-iol-cz-service
  paths:
  - /ip/
EOF
```{{exec}} 

Lets bring container definitions; remember that TOKEN is required and should have valid data:
```
cat <<EOF >> docker-compose.yml
version: "3.7"
networks:
  apinet:

services:

  kong:
    container_name: kong
    ports:
      - 8000:8000
    ipc: host
    image: checkpoint/infinity-next-kong
    volumes:
      - ./kong.yml:/etc/kong/kong.yml
    environment:
      - KONG_DATABASE=off
      - KONG_DECLARATIVE_CONFIG=/etc/kong/kong.yml
      - KONG_PROXY_ACCESS_LOG=/dev/stdout
      - KONG_ADMIN_ACCESS_LOG=/dev/stdout
      - KONG_PROXY_ERROR_LOG=/dev/stderr
      - KONG_ADMIN_ERROR_LOG=/dev/stderr
      - KONG_ADMIN_LISTEN=0.0.0.0:8001
      - KONG_ADMIN_GUI_URL=http://localhost:8002
    networks:
      - apinet
  agent-container:
    ipc: host
    volumes:
      - ./agent-container/data:/etc/cp/data
      - ./agent-container/conf:/etc/cp/conf
      - ./agent-container/logs:/var/log/nano_agent
    image: checkpoint/infinity-next-nano-agent
    command: ["/cp-nano-agent", "--token", "$TOKEN"]
    networks:
      - apinet
EOF
```{{exec}} 

Start the services with
```
docker-compose up -d
```{{exec}} 

Create new asset for http://localhost:8000 to match all Kong traffic. Assign it to Kong agent profile.
Publish and ENFORCE the policy.

Wait for agent in CloudGuard WAF agents section - to be visible and reporting current policy version.

You may also check agent status on machine using
```
docker-compose exec agent-container cpnano -s
```{{exec}} 

Check line 'Policy version:', if it already has current version number.

Test some traffic through Kong gw:
```
curl -s 'localhost:8000/ip/'
```{{exec}} 

It should return source IP.

And some incident:
```
curl -s 'localhost:8000/ip/?z=UNION+1=1'
curl -s 'localhost:8000/ip/?z=cat+/etc/passwd'
```{{exec}} 


Our API service from step 1 is also protected against SQL Injection attack,
when accessed via Kong on port 8000:
```
curl -s -G -v -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImpvaG4uc21pdGhAZXhhbXBsZS5jb20iLCJpZCI6MX0.pnlUuw6CzSG2In05n7WMDFP1l5GeqyAnWN98x9zcAc0" --data-urlencode "email=john.smith@example.com' OR '1'='1" http://localhost:8000/getemployees
```{{exec}}


While legit query goes through:
```
curl -s -G -v -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImpvaG4uc21pdGhAZXhhbXBsZS5jb20iLCJpZCI6MX0.pnlUuw6CzSG2In05n7WMDFP1l5GeqyAnWN98x9zcAc0" --data-urlencode "email=john.smith@example.com" http://localhost:8000/getemployees
```{{exec}}

Return to CloudGuard WAF portal Monitor section and review the incidents.