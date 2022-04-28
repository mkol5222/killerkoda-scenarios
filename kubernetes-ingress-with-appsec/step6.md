
<br>

### Install AppSec Ingress with Helm

Grab Helm chart
`git clone https://github.com/mkol5222/appsec-helm-chart.git cpappsec`{{exec}}

Install
```
 helm install ./cpappsec/cp-k8s-appsec-nginx-ingress-4.0.1-modified/ \
  --name-template cp-appsec \
  --set appsec.agentToken="cp-fce04623-a09d-4bc8-b0ec-054f7f26eede42623815-91d6-4e5f-b25a-4cd929ef39da" \
  --set appsec.persistence.storageClass="my-local-storage" \
  --set controller.image.tag="latest-1.19.2" \
  --set controller.ingressClass="nginx" \
  --set appsec.resources.requests.cpu="10m" \
  --set controller.resources.requests.cpu="10m"
```{{exec}}


