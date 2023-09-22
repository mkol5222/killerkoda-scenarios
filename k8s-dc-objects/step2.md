
Install necessary dependencies:

```bash
sudo apt-get update && sudo apt-get install yq jq mitmproxy -y
```{{exec}}

Get real local Kubernetes API server URL:
```bash
cat ~/.kube/config | yq eval -o json | jq -r '.clusters[0].cluster.server'
```{{exec}}

Expose Kubernetes API server to Internet with Killercoda port and mitmproxy. 
Keep proxy running. Open one more terminal tab and run:

```bash
export APP_URL={{TRAFFIC_HOST1_8080}}; echo "Internet address of Kubernetes API is $APP_URL - take note"; read -p "Press enter to continue"
```{{exec}}

```bash
mitmproxy --listen-port 8080 --mode "reverse:https://172.30.1.2:6443" --ssl-insecure
```{{exec}}

Create Kubernetes service account and permissions for CloudGuard Controller to access Kubernetes API:

```bash
kubectl create serviceaccount cloudguard-controller
kubectl create clusterrole endpoint-reader --verb=get,list --resource=endpoints
kubectl create clusterrolebinding allow-cloudguard-access-endpoints --clusterrole=endpoint-reader --serviceaccount=default:cloudguard-controller
kubectl create clusterrole pod-reader --verb=get,list --resource=pods
kubectl create clusterrolebinding allow-cloudguard-access-pods --clusterrole=pod-reader --serviceaccount=default:cloudguard-controller
kubectl create clusterrole service-reader --verb=get,list --resource=services
kubectl create clusterrolebinding allow-cloudguard-access-services --clusterrole=service-reader --serviceaccount=default:cloudguard-controller
kubectl create clusterrole node-reader --verb=get,list --resource=nodes
kubectl create clusterrolebinding allow-cloudguard-access-nodes --clusterrole=node-reader --serviceaccount=default:cloudguard-controller
```{{exec}}

```bash
# create token
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: cloudguard-controller
  annotations:
    kubernetes.io/service-account.name: "cloudguard-controller"
EOF
```{{exec}}

Note Service Account token:
```bash
echo; kubectl get secret/cloudguard-controller -o json | jq -r .data.token | base64 -d ; echo; echo

```{{exec}}



