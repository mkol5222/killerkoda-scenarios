
<br>

### Create Ingress

```
cat << "EOF" > tea-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: cafe-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  ingressClassName: nginx
  rules:
  - http:
      paths:
      - path: /tea(/|$)(.*)
        pathType: Prefix
        backend:
          service:
            name: web
            port:
              number: 80
EOF
```{{exec}}

`kubectl apply -f tea-ingress.yaml`{{exec}}

Check port of our Ingress controller
`k get svc`{{exec}}

And use it here to access /tea path.
{{TRAFFIC_SELECTOR}}


