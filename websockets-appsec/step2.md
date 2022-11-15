Lets introduce reverse proxy in-front of this application:

Install NGINX
```
apt install nginx -y
```{{exec}} 

Reconfigure to reverse proxy for port 8080 with special attention to WebSockets access:
```
cat > /etc/nginx/sites-enabled/default  <<'EOF'
map $http_upgrade $connection_upgrade {
    default upgrade;
    '' close;
}

server {
    server_name _;
    location / { 
        proxy_pass http://localhost:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
    }
}
EOF
```{{exec}} 

Reload NGINX configuration to activate new settings:
```
nginx -s reload
```{{exec}} 

Your proxy is now serving here

Port 80:
{{TRAFFIC_HOST1_80}}

And Ports menu (traffic selector):
{{TRAFFIC_SELECTOR}}