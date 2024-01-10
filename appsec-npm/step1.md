# Step 1

```
mkdir ./appsec-localconfig
```{{exec}}

```
wget https://raw.githubusercontent.com/openappsec/open-appsec-npm/main/deployment/local_policy.yaml -O ./appsec-localconfig/local_policy.yaml
```{{exec}}

```
wget https://raw.githubusercontent.com/openappsec/open-appsec-npm/main/deployment/docker-compose.yaml
```{{exec}}

```
docker compose up -d
```{{exec}}

```
docker ps
```{{exec}}

[NGINX Proxy Manager UI]({{TRAFFIC_HOST1_80}} running on port 81