# Republish to local

Login as write / vpn123

```shell
docker login reg.localtest.me
```{{exec}}

```shell
docker pull ubuntu
docker tag ubuntu reg.localtest.me/ubuntu
docker image ls
```{{exec}}

```shell
docker push reg.localtest.me/ubuntu
docker volume ls | grep registry 
docker run --rm -it -v root_registry_data:/data ubuntu find /data/
```{{exec}}
