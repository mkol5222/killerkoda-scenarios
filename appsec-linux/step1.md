# Step 1

Welcome to fresh new Ubuntu 20.04 LTS machine.

Lets use package manager to introduce NGINX web server / reverse proxy:
```
apt install nginx -y
```{{exec}} 

Now confirm new web server is running and reachable:
```
curl http://localhost
```{{exec}} 

You may also reach your web server from browser
by visiting "hamburger menu" at top right corner of terminal
and choose Traffic / Ports menu and Host 1 / Common Ports / 80.

There are even shortcuts for you:

Port 80:
{{TRAFFIC_HOST1_80}}

And Ports menu (traffic selector):
{{TRAFFIC_SELECTOR}}