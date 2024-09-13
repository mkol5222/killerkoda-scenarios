#!/bin/bash

# cd ./docker-registry/assets/

# set creds
# . ./env-shiftleft
# env | grep SHIFTLEFT_
# env | grep CLOUDGUARD_


# if [[ -z $CHKP_CLOUDGUARD_ID ]]; then
#     echo "Error: Checkpoint CloudGuard ID is not set"
#     # exit 1
# fi

# export image - eg. node:22 or hello-world:latest
function export_image() {
    IMAGE=$1
    echo "Exporting image $IMAGE"
    curl --unix-socket /var/run/docker.sock -X GET "http://localhost/images/$IMAGE/get" > /tmp/image.tar
    file /tmp/image.tar
    tar tvf /tmp/image.tar
}

# export_image node:22
# export_image debian:latest
# export_image hello-world:latest

function scanResults() {
    # cat ./res/scan.json
    # cat ./res/scan.json | jq '. | keys'
    # cat ./res/scan.json | jq '.assessments[0] | keys'
    # cat ./res/scan.json | jq '.assessments[0].testEntities | keys'
    # cat ./res/scan.json | jq '.assessments[0].testEntities.scanSummary'
    # cat ./res/scan.json | jq '.assessments[0].testEntities.imageScan' | less
    cat ./res/scan.json | jq '.assessments[0].testEntities.imageScan[0].totals' 
}

# scanResults

function scanMetadata() {
    IMAGE=$1
    IMAGEID=$(curl -s --unix-socket /var/run/docker.sock -X GET "http://localhost/images/$IMAGE/json" | jq -r '.Id')

    AUTH="$CHKP_CLOUDGUARD_ID:$CHKP_CLOUDGUARD_SECRET"
    

    APIHOST="api.dome9.com"
    APIURL="https://${APIHOST}/v2/vulnerability/scan-metadata?EnvironmentId=${SHIFTLEFT_ENV}&EntityType=ShiftLeftImage&EntityId=${IMAGEID}"
    

    curl -s -H "Content-Type: application/json" -u $AUTH $APIURL | jq .
}

# scanMetadata ubuntu:latest

# /v2/kubernetes/imageAssurance/image/general?id=13|7f1fedb8-0584-4473-91c9-ff3b9047fe81|Image|sha256:edbfe74c41f8a3501ce542e137cf28ea04dd03e6df8c9d66519b6ad761c2598a

function scanResultsInDb() {
    IMAGE=$1
    IMAGEID=$(curl -s --unix-socket /var/run/docker.sock -X GET "http://localhost/images/$IMAGE/json" | jq -r '.Id')

    AUTH="$CHKP_CLOUDGUARD_ID:$CHKP_CLOUDGUARD_SECRET"
    
    ID="13|$SHIFTLEFT_ENV|Image|$IMAGEID"
    URLENCODED_ID=$(echo -n $ID | jq -sRr @uri)

    APIHOST="api.dome9.com"
    APIURL="https://${APIHOST}/v2/kubernetes/imageAssurance/image/general?id=${URLENCODED_ID}"
    

    curl -s -H "Content-Type: application/json" -u $AUTH $APIURL | jq .
}

# scanResultsInDb ubuntu:latest

function imageLink() {
    IMAGEID=$1
    SHORT_IMAGEID=$(echo $IMAGEID | cut -c 8-)
    LINK="https://portal.checkpoint.com/dashboard/cloudguard#/workload/images/generic?cloudAccountId=$SHIFTLEFT_ENV&assetType=ShiftLeftImage&assetId=sha256%3A$SHORT_IMAGEID&tabName=overview&tabOnly=true&platform=shiftleft&drawer=undefined"
    echo 
    echo "Infinity Portal link to scan results: $LINK"
    echo
}


function scan_image() {
    IMAGE=$1
    docker pull $IMAGE
    export_image $IMAGE
    echo "Scanning image $IMAGE"
    docker run --rm -v ./res:/res -v /tmp:/data -e CHKP_CLOUDGUARD_ID=$CHKP_CLOUDGUARD_ID -e CHKP_CLOUDGUARD_SECRET=$CHKP_CLOUDGUARD_SECRET -e SHIFTLEFT_REGION=$SHIFTLEFT_REGION -e SHIFTLEFT_ENV=$SHIFTLEFT_ENV checkpoint/shiftleft:latest_v2 shiftleft -D image-scan -j -i /data/image.tar -e $SHIFTLEFT_ENV -o /res/scan.json

    IMAGEID=$(curl -s --unix-socket /var/run/docker.sock -X GET "http://localhost/images/$IMAGE/json" | jq -r '.Id')
    if [[ $IMAGEID == sha256:* ]]; then
        echo "IMAGEID is valid"
    else
        echo "IMAGEID is invalid"
    fi

    scanResults

    imageLink $IMAGEID
}

# scan_image ubuntu:latest
# scan_image checkpoint/shiftleft:latest_v2
# scan_image hello-world:latest

# scanResultsInDb hello-world:latest | jq .image.scanDetails.totals
# scanResultsInDb ubuntu:latest | jq .image.scanDetails.totals

function scanIfNeeded() {
    IMAGE=$1
    RES=$(scanResultsInDb $IMAGE | jq -r .image.scanDetails.totals)
    if [[ $RES != "null" ]]; then
        echo "Scan results found"
        echo $RES | jq .
        IMAGEID=$(curl -s --unix-socket /var/run/docker.sock -X GET "http://localhost/images/$IMAGE/json" | jq -r '.Id')
        imageLink $IMAGEID
    else
        echo "Scan results not found"
        echo "$RES"
        scan_image $IMAGE
    fi
}

# scanIfNeeded debian:latest





