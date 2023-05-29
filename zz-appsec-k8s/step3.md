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

while kubectl apply -f i.yaml; [[ $? -ne 0 ]];
do
  echo "Result unsuccessful"
  sleep 3
done

echo "Result successful"


kubectl get ingress -o yaml

echo "visit Killercoda on Ingress port $INGRESS_PORT"

echo "Make sure AppSec asset is handling incoming URL http://$host/" | sed  "s/-80/-${INGRESS_PORT}/" 

echo "BUT you should visit URL https://$host/?q=UNION=5=5" | sed  "s/-80/-${INGRESS_PORT}/" 

```{{exec}} 