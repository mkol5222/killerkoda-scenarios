# Step 4

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

Download installation script
```
curl -o appsec-killercoda-install.sh -L 'https://gist.githubusercontent.com/mkol5222/f3d7d7d6c681a5c2a53e249c448d438c/raw/c0d46cb23b2119ab5e1403fa20776d107e545113/appsec-cli.sh'
```{{exec}} 

and execute it
```
chmod +x ./appsec-killercoda-install.sh
./appsec-killercoda-install.sh
```{{exec}} 
