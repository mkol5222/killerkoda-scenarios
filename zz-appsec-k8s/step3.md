# 3

Create ingress YAML with Killercoda URL

```
export url={{TRAFFIC_HOST1_80}}
echo $url
host="${url#*://}"
host="${host%%/*}"
echo $host

cat > i.yaml <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /\$1
spec:
  ingressClassName: nginx
  rules:
    - host: $host
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

kubectl apply -f i.yaml

kubectl get ingress -o yaml
```{{exec}} 