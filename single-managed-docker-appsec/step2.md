Lets introduce WAAP protection using singke managed docker container:

Note your frontend URL:
```
export APP_URL_RAW={{TRAFFIC_HOST1_80}}
APP_URL=$(echo "$APP_URL_RAW" | sed s/^https:/http:/)

echo "Asset front-end URL to use: $APP_URL/"
```{{exec}}


Note your backend URL - based on IP of docker0 NIC:
```
DOCKER0IP=$(ip -j a | jq -r '.[]|select(.ifname=="docker0")|.addr_info[]|select(.family=="inet")|.local')

echo $DOCKER0IP
echo
echo "Backend URL is: http://$DOCKER0IP:8080/"
```{{exec}}


Create Agent profile: Docker / Single Container - CloudGuard AppSec (With Reverse Proxy)
Use descriptive name and remember it for next step.
And store it to env variable called CPTOKEN:
Make sure to Publish and Enforce.

```
export CPTOKEN=cp-1958-USE_REAL_TOKEN_HERE 
```{{copy}}

Create asset on top of this agent profile (you've used descriptive name for agent, choose it), go for Prevent mode and use front end and back end URLs from above.
Make sure to Publish and Enforce.

Now you are ready to deploy the agent with embedded managed NGINX reverse proxy:
```
echo docker run -d --name=agent-container -v=./cp-conf:/etc/cp/conf -v=./cp-data:/etc/cp/data -v=./cp-logs:/var/log/nano_agent -v=./cp-nginx:/etc/nginx/conf.d/ -v=./cp-certs:/etc/certs/ -p 8443:443 -p 80:80 -p 8117:8117 -it checkpoint/cloudguard-appsec-standalone /cloudguard-appsec-standalone --token "$CPTOKEN"
```{{exec}}




