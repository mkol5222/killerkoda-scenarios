# Enjoy

Pods in deployment should be up and ready to server users
`kubectl get po -l app=appsec`{{exec}}

You can access it [here]({{TRAFFIC_HOST1_8080}})

`kubectl exec deploy/appsec cpnano -s`{{exec}}

`for P in $(kubectl get po -l app=appsec -o name); do echo $P; kubectl exec -it $P -- cpnanios -s; done`{{exec}}

`for P in $(kubectl get po -l app=appsec -o name); do echo $P; kubectl describe $P; done`{{exec}}

Agents should be visible in [portal](https://portal.checkpoint.com/dashboard/appsec#/waf-policy/agents?status=Connected) - serving latest version of policy.

