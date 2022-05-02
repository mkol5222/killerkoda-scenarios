
<br>

### Install AppSec Ingress with Helm

Grab Helm chart
`git clone https://github.com/mkol5222/appsec-helm-chart.git cpappsec`{{exec}}

Get your agent token from Infinity Portal and set variable
`export CP_TOKEN="cp-xxx"`

Install
```
 helm install ./cpappsec/cp-k8s-appsec-nginx-ingress-4.0.1-modified/ \
  --name-template cp-appsec \
  --set appsec.agentToken="$CP_TOKEN" \
  --set appsec.persistence.storageClass="my-local-storage" \
  --set controller.image.tag="latest-1.19.2" \
  --set controller.ingressClass="nginx" \
  --set appsec.resources.requests.cpu="10m" \
  --set controller.resources.requests.cpu="10m"
```{{exec}}

Wait for controller to be Running
`k get pod/cp-appsec-cpappsec-ingress-nginx-controller-0 --watch`{{exec}}



