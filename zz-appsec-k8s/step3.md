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

INGRESS_PORT=$(k get svc/cp-appsec-cpappsec-controller -o json | jq -r '.spec.ports[]|select(.port==80)|.nodePort')
echo $INGRESS_PORT
sed -i "s/-80/-${INGRESS_PORT}/" i.yaml

kubectl apply -f i.yaml

kubectl get ingress -o yaml

echo "visit Killercoda on Ingress port $INGRESS_PORT"
```{{exec}} 