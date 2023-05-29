# 1

Create and expose app
```
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0

kubectl expose deployment web --type=NodePort --port=8080

kubectl scale deploy/web --replicas 3

kubectl get svc
```{{exec}} 

Now connect to relevant port and see app.