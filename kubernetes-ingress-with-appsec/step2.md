
<br>

### Deploy web application

Run 
```
cat <<"EOF" | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
 labels:
   app: web
 name: web
spec:
 replicas: 3
 selector:
   matchLabels:
     app: web
 template:
   metadata:
     labels:
       app: web
   spec:
     containers:
     - image: nginx
       name: nginx
       ports:
       - containerPort: 80
       command: ["bash"]
       args: ["-c", 'echo "$(hostname)" "$(hostname -i)" > /usr/share/nginx/html/index.html; nginx -g "daemon off;"']
EOF
```{{exec}} 
to start web application where it is easy to see name and IP address of responding pod.

And expose it with new Service  `kubectl expose deployment/web --type NodePort --port 80`{{exec}}

Check our new service:
`kubectl describe service web`{{exec}}

Check it live
{{TRAFFIC_SELECTOR}}




