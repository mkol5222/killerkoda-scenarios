
```bash
kubectl create deployment web --image=nginx --replicas 2
```{{exec}}


```bash
kubectl get pods -o wide --show-labels
```{{exec}}