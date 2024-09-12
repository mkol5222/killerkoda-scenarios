# Scan container image with CloudGuard Shifyleft scanner

```shell
. ./.env-shiftleft
echo $CHKP_CLOUDGUARD_ID
```{{exec}}

```shell
docker pull node:22
curl --unix-socket /var/run/docker.sock -X GET "http://localhost/images/node:22/get" > /tmp/image.tar

ls -la image.tar
file /tmp/image.tar
tar tvf /tmp/image.tar
```{{exec}}

```shell
docker run --rm -v ./res:/res -v /tmp:/data -e CHKP_CLOUDGUARD_ID=$CHKP_CLOUDGUARD_ID -e CHKP_CLOUDGUARD_SECRET=$CHKP_CLOUDGUARD_SECRET -e SHIFTLEFT_REGION=$SHIFTLEFT_REGION -e SHIFTLEFT_ENV=$SHIFTLEFT_ENV checkpoint/shiftleft:latest_v2 shiftleft -D image-scan -j -i /data/image.tar -e $SHIFTLEFT_ENV -o /res/scan.json
```{{exec}}

```shell
cat ./res/scan.json | jq '.assessments[0].testEntities.scanSummary'
cat ./res/scan.json | jq '.assessments[0].testEntities.imageScan' | less
cat ./res/scan.json | jq '.assessments[0].testEntities.imageScan[0].totals' 
```{{exec}}