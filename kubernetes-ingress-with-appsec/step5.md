
<br>

### Prepare storage

`mkdir /data; chmod 777 /data/`{{exec}}

```
cat > storageClass.yaml << "EOF"
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: my-local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
EOF
```{{exec}}

`kubectl create -f storageClass.yaml`{{exec}}

```
cat > persistentVolume1.yaml << "EOF"
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-local-pv-1
spec:
  capacity:
    storage: 1.5Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: my-local-storage
  local:
    path: /data
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - controlplane
EOF
```{{exec}}

`kubectl apply -f persistentVolume1.yaml`{{exec}}

```
cat > persistentVolume2.yaml << "EOF"
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-local-pv-2
spec:
  capacity:
    storage: 1.5Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: my-local-storage
  local:
    path: /data
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - controlplane
EOF
```{{exec}}

`kubectl apply -f persistentVolume2.yaml`{{exec}}

`k get pv`{{exec}}