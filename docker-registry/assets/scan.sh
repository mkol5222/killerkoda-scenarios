#!/bin/bash

. ./.env-shiftleft
echo $CHKP_CLOUDGUARD_ID

curl --unix-socket /var/run/docker.sock -X GET "http://localhost/images/node:22/get" > /tmp/image.tar
file /tmp/image.tar
tar tvf /tmp/image.tar

docker run --rm -v /tmp:/data -e CHKP_CLOUDGUARD_ID=$CHKP_CLOUDGUARD_ID -e CHKP_CLOUDGUARD_SECRET=$CHKP_CLOUDGUARD_SECRET -e SHIFTLEFT_REGION=$SHIFTLEFT_REGION -e SHIFTLEFT_ENV=$SHIFTLEFT_ENV checkpoint/shiftleft:latest_v2 shiftleft -D image-scan -j -i /data/image.tar -e $SHIFTLEFT_ENV