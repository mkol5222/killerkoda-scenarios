# Step 1

Within the directory which you want to use for the deployment:
Create a folder appsec-localconfig which will hold the appsec declarative configuration file (this will be managed by the enhanced NPM WebUI).

```
mkdir ./appsec-localconfig
```{{exec}}


Download the initial declarative configuration file for open-appsec into that folder:

```
wget https://raw.githubusercontent.com/openappsec/open-appsec-npm/main/deployment/local_policy.yaml -O ./appsec-localconfig/local_policy.yaml
```{{exec}}


Create a docker-compose.yaml file with the content below, it can be downloaded as follows and you may review it in Killercoda's editor:

```
wget https://raw.githubusercontent.com/openappsec/open-appsec-npm/main/deployment/docker-compose.yaml
```{{exec}}


Edit the docker-compose.yaml file and replace "user@email.com" with your own email address, so we can provide assistance in case of any issues with the specific deployment in the future and provide information proactively regarding open-appsec.

This is an optional parameter and can be removed. If we send automatic emails there will also be an opt-out option included for receiving similar communication in the future.

Start the deployment:

```
docker-compose up -d
```{{exec}}


Check the status of the containers:

```
docker ps
```{{exec}}


Logs are telling you what is going on:

```
docker-compose logs -ft
```{{exec}}

Look at logs. Be patient. It takes time to initialize the containers.

Later you may access [NGINX Proxy Manager UI]({{TRAFFIC_HOST1_81}}) running on port 81

We will define port 80 [website]({{TRAFFIC_HOST1_80}})  later.