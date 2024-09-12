# Read-only access

```shell
docker logout reg.localtest.me
rm /root/.docker/config.json

docker pull hello-world
docker tag hello-world reg.localtest.me:hello-world
docker push
```{{exec}}

Login as read / vpn123
```shell
docker login reg.localtest.me
```{{exec}}

```shell
docker push reg.localtest.me:hello-world
```{{exec}}

Expected failure happened.
