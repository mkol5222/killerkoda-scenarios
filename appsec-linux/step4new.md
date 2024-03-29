
## Get API keys

Obtain [API keys](https://portal.checkpoint.com/dashboard/settings/api-keys) in your Infinity Portal


Once known set environment variables by appending to commands:
```
export HORIZON_POLICY_CLIENTID=
```{{exec}} 

```
export HORIZON_POLICY_SECRETKEY=
```{{exec}} 

## Set ingress URL for our proxied app

```
export APP_URL={{TRAFFIC_HOST1_80}}
```{{exec}} 

## Install AppSec and provision configuration on server using API

JQ is required for provisioning script
```
apt install jq -y
```{{exec}} 

Download installation script
```
curl -o appsec-killercoda-install.sh -L 'https://gist.githubusercontent.com/mkol5222/86eb345c547c227fd3b0326b6ca447ef/raw/9e8c44ccc3b1116210ad764a8c88f651383aa4d2/appsec-killercoda-install.sh'
```{{exec}} 

and execute it
```
chmod +x ./appsec-killercoda-install.sh
./appsec-killercoda-install.sh
```{{exec}} 
