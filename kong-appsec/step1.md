Welcome to fresh new Ubuntu 20.04 LTS machine.

Lets deploy our API server. It will be exposed on port 8080 and we will put it behind Kong API Gateway later.
```
docker run -d -p 8080:5000  ghcr.io/openappsec/vulnerable-api-server:latest
```{{exec}} 

Wait for deployment to finish and verify with
```
docker ps
```{{exec}}

Your app is now reachable via port 8080
```
 curl -s -G -v -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImpvaG4uc21pdGhAZXhhbXBsZS5jb20iLCJpZCI6MX0.pnlUuw6CzSG2In05n7WMDFP1l5GeqyAnWN98x9zcAc0" \
--data-urlencode "email=john.smith@example.com' OR '1'='1" \
http://localhost:8080/getemployees | jq .
```{{exec}}


Port 8080 in your browser:
{{TRAFFIC_HOST1_8080}}

And Ports menu (traffic selector):
{{TRAFFIC_SELECTOR}}