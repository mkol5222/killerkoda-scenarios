
Install open-appsec:
```
wget https://downloads.openappsec.io/open-appsec-install && chmod +x open-appsec-install 
```{{exec}} 

```
./open-appsec-install --auto --prevent --no-email
```{{exec}} 

You may monitor nano agent deployment in detail using
```
tail -f /var/log/nano_agent/cp-nano-orchestration.dbg
```{{exec}} 
