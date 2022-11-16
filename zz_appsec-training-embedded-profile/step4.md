
Create web asset in AppSec management:
```
export APP_URL={{TRAFFIC_HOST1_80}}
appsec-setup-for-appurl.sh
```{{exec}} 

You may monitor nano agent deployment in detail using
```
tail -f /var/log/nano_agent/cp-nano-orchestration.dbg
```{{exec}} 
