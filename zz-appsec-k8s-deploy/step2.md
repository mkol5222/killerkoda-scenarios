# Deploy

Create new Kubernetes deployment of CloudGuard WAF managed sigle container (NGINX and agent in one)

`https://gist.githubusercontent.com/mkol5222/284007fa0d2780bb0e5dc43b122f7144/raw/f4a112514960688446c238b39344d0982aacd852/kk-appsec-deploy.yaml`{{exec}}

Check how it goes:
`watch -d kubectl get po -l app=appsec`{{exec}}

After some time all agents become ready.

Focus on AppSec service exposing these agents:
`kubectl get svc appsec-service`{{exec}}

Service distributes requests to multiple CG WAF agents and exposes itself on high-port of every cluster node.

We may expose it to Killercode port access feature by
`kubectl port-forward svc/appsec-service 8080:80 --address 0.0.0.0 &`{{exec}} 

You can access it [here]({{TRAFFIC_HOST1_8080}})

Note Killercoda port access feature hostname:
`sed 's/PORT/8080/g' /etc/killercoda/host`{{exec}}