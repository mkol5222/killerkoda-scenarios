# 3

Create ingress YAML with Killercoda URL

```
export APP_URL={{TRAFFIC_HOST1_80}}
echo $APP_URL

cat > i.yaml <<"EOF"
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /\$1
spec:
  ingressClassName: nginx
  rules:
    - host: $APP_URL
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web
                port:
                  number: 8080
EOF
```{{exec}} 