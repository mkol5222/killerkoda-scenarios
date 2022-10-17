
## Monitor NGINX reverse proxy

Confirm NGINX is present, version and configured options
```
nginx -V
```{{exec}}

Confirm NGINX is listening on port 80 with
```
ss -l -p -n | grep :80
```{{exec}}

Check if it is reachable and forwarding to Acme Audit app
```
curl localhost
```{{exec}}

Dump whole proxy configuration including proxy setup for Acme Audit
```
nginx -T
```{{exec}}

And cause fake SQL injection incident with opening browser on [Attack Link]({{TRAFFIC_HOST1_80}}/?q=UNION+1=1) or from command line using
```
curl {{TRAFFIC_HOST1_80}}/?q=UNION+1=1
```{{exec}}

Be patient - enforcement kicks in after while since agent deployment.