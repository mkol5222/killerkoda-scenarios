# Enjoy

Pods in deployment should be up and ready to server users
`kubectl get po -l app=appsec`{{exec}}

You can access it [here]({{TRAFFIC_HOST1_8080}})

`for P in $(kubectl get po -l app=appsec -o name); do echo $P; kubectl exec -it $P -- cpnano -s; done`{{exec}}

`for P in $(kubectl get po -l app=appsec -o name); do echo $P; kubectl describe $P; done`{{exec}}

`for P in $(kubectl get po -l app=appsec -o name); do echo $P; kubectl exec -it $P -- cat /etc/cp/conf/settings.json | jq; done`{{exec}}


Agents should be visible in [portal](https://portal.checkpoint.com/dashboard/appsec#/waf-policy/agents?status=Connected) - serving latest version of policy.

You can also scale up with `kubectl scale deploy appsec --replicas 6`{{exec}}

And monitor agents to bedome ready to serve `kubectl get po -l app=appsec --watch`{{exec}}
