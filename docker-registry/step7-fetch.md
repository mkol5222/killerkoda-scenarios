# Fetch local

delete local copies

```shell
cat .docker/config.json
docker image rm reg.localtest.me/ubuntu
docker image rm ubuntu
docker image ls
```{{exec}}

read may download

```shell
docker pull reg.localtest.me/ubuntu
docker run --rm -it reg.localtest.me/ubuntu cat /etc/os-release
```{{exec}}
