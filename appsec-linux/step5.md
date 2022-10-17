
## Monitor AppSec Agent

`cpnano -s` confirms agent is up and running, policy version used and already installed components (agent services)
```
cpnano -s
```{{exec}}

`watch` provides continuos visibility of policy updates and during installation of agent modules:
```
watch -d cpnano -s
```{{exec}}

Agent deployment progress can be monitored with
```
tail -f /var/log/nano_agent/cp-nano-orchestration.dbg
```{{exec}}

Once agent enforcement is installed into NGINX reverse proxy, confirm CP attachment module with
```
cat /etc/nginx/nginx.conf | grep cp_attachment
```{{exec}}

It would report line similar to
`load_module /usr/lib/nginx/modules/ngx_cp_attachment_module.so;`

