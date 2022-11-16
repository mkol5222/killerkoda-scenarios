Lets introduce reverse proxy in-front of this application.

This reverse proxy terminates all app ingress 
and therefore is potential integration point
for security inspection and enforcement.

Install NGINX
```
apt install nginx -y
```{{exec}} 

Reconfigure to reverse proxy for port 8080:
```
cat > /etc/nginx/sites-enabled/default  <<'EOF'

server {
    server_name _;
    location / { 
        proxy_pass http://localhost:8080;
    }
}
EOF
```{{exec}} 

Reload NGINX configuration to activate new settings:
```
nginx -s reload
```{{exec}} 

Your proxy is now serving here.

Also port 80 displays your application from container on port 8080:

Port 80:
{{TRAFFIC_HOST1_80}}

And Ports menu (traffic selector):
{{TRAFFIC_SELECTOR}}