# 2

Install storage operator
```
kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml
```{{exec}} 

Get and install CP AppSec Ingress
```
CHART='https://github.com/CheckPointSW/Infinity-Next/raw/main/deployments/cp-k8s-appsec-nginx-ingress-4.0.1.tgz'
TOKEN='cp-19dbe41f-f86e-4e3f-8242-44b825a9b267167b3c1b-cf37-4b59-a44e-6f53c061e1fa'
helm install "$CHART" --name-template cp-appsec --set appsec.agentToken="$TOKEN" --set appsec.persistence.storageClass=openebs-hostpath

kubectl get svc
```{{exec}}
