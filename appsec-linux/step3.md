# Step 3

## NGINX as reverse proxy for Acme Audit application

Reconfigure NGINX to reverse proxy Acme Audit 
instead of serving HTML from disk. 

http://localhost:8080 is where Acme Audit runs. Remember?

```
cat > /etc/nginx/sites-enabled/default  <<'EOF'
server {
   server_name _;
   location / { proxy_pass http://localhost:8080; }
}
EOF
```{{exec}} 

Configuration is in place. Reload NGINX configuration:
```
nginx -s reload
```{{exec}} 

Test if you reach Acme Audit login page:
```
curl localhost
```{{exec}} 

And http://localhost:80 (NGINX reverse proxy) from browser [HERE]({{TRAFFIC_HOST1_80}})

NGINX is handling access to Acme Audit, but still nobody prevents you to bypass login dialog.