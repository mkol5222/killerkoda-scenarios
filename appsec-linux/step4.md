
## Installation of AppSec Agent

Create new account or use existing AppSec management app at [Infinity Portal](https://portal.checkpoint.com/signin)

Create Linux Nano Agent PROFILE and ENFORCE policy to make Authentication Token valid.
Profile instructions include command similar to below, with your specific profile token:
```
wget https://checkpoint.com/nanoegg -O nanoegg && chmod +x nanoegg && ./nanoegg --install --token cp-****
```

Notice: command will not succeed with deployment if your forget to ENFORCE policy with new profile definition.
(you will get 401 error on installation script download)

```
HTTP status code: 401
Error: Unauthorized token (Error ID: 102-003)
```

In case of successful installation, you may check progress of Nano Agent modules deployment using
```
cpnano -s
```{{exec}} 

You can also watch for updates and new policy with
```
watch -d cpnano -s
```{{exec}} 

Lets create AppSec ASSET for our site (notice: replace HTTPS with HTTP):
{{TRAFFIC_HOST1_80}}
and assign it to new PROFILE in asset creation wizard.

