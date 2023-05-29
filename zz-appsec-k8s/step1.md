# 1

Create and expose app
```
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0

kubectl expose deployment web --type=NodePort --port=8080

kubectl scale deploy/web --replicas 3

kubectl get svc

APP_PORT=$(k get svc/cp-appsec-cpappsec-controller -o json | jq -r '.spec.ports[]|select(.port==80)|.nodePort')
echo $APP_PORT

echo "visit Killercoda on Web App port $APP_PORT"
```{{exec}} 

Now connect to relevant port and see app.