#!/bin/bash

function getToken {
    RESP=$(curl -s --request POST \
        --url https://cloudinfra-gw.portal.checkpoint.com/auth/external \
        --header 'content-type: application/json' \
        --data "{\"clientId\":\"$1\" ,\"accessKey\":\"$2\" }")
    TOKEN=$(echo "$RESP" | jq -r '.data.token')
}

function publishChanges {
    read -r -d '' QUERY <<'EOF'
mutation {
  publishChanges {
    isValid
    errors {
        id type subType name message 
    }
    warnings {
      id type subType name message
    }
  }
}
EOF
    BODY=$(jq -r -n --arg Q "$QUERY" '{query:$Q}')
    

    RESP=$(curl -s --request POST \
        --url https://cloudinfra-gw.portal.checkpoint.com/app/i2/graphql/V1 \
        --header "authorization: Bearer ${TOKEN}" \
        --header 'content-type: application/json' \
        --data "$BODY")
    RES=$(echo "$RESP" | jq -r '.')
    echo "$RES"
}

function enforcePolicy {
    read -r -d '' QUERY <<'EOF'
mutation {
  enforcePolicy {
    id
  }
}
EOF
    BODY=$(jq -r -n --arg Q "$QUERY" '{query:$Q}')
    

    RESP=$(curl -s --request POST \
        --url https://cloudinfra-gw.portal.checkpoint.com/app/i2/graphql/V1 \
        --header "authorization: Bearer ${TOKEN}" \
        --header 'content-type: application/json' \
        --data "$BODY")
    RES=$(echo "$RESP" | jq -r '.')
    echo "$RES"
    ENFORCETASK=$(echo "$RESP" | jq -r '.data.enforcePolicy.id')
    echo "$ENFORCETASK"
}


function getTask {
    read -r -d '' QUERY <<'EOF'
query getTask($id: ID!) {
  getTask(id: $id) {
    id
    tenantId
    type
    status
    message
    startTime
    endTime
    errorCode
    referenceId
  }
}
EOF
    BODY=$(jq -r -n --arg Q "$QUERY" --arg T "$1" '{query:$Q,variables:{id:$T}}')
    

    RESP=$(curl -s --request POST \
        --url https://cloudinfra-gw.portal.checkpoint.com/app/i2/graphql/V1 \
        --header "authorization: Bearer ${TOKEN}" \
        --header 'content-type: application/json' \
        --data "$BODY")
    RES=$(echo "$RESP" | jq -r '.')
    echo "$RES"
}

function getProfileToken {
    read -r -d '' QUERY <<'EOF'
query getProfile($id:ID!) {
	getEmbeddedProfile(id:$id) {
    name
    status
    authentication {
      authenticationType
      maxNumberOfAgents
      token
    }
  }
}
EOF
    BODY=$(jq -r -n --arg Q "$QUERY" --arg I "$1" '{query:$Q,variables:{id:$I}}')
    

    RESP=$(curl -s --request POST \
        --url https://cloudinfra-gw.portal.checkpoint.com/app/i2/graphql/V1 \
        --header "authorization: Bearer ${TOKEN}" \
        --header 'content-type: application/json' \
        --data "$BODY")
    RES=$(echo "$RESP" | jq -r '.')
    echo "$RES"
    PROFILETOKEN=$(echo "$RESP" | jq -r '.data.getEmbeddedProfile.authentication.token')
    echo "$PROFILETOKEN"
}

function getBestPractice {
    read -r -d '' Q_BESTPRACTICE <<'EOF'
query {
	getPractices(includePrivatePractices: false, matchSearch:"WEB APPLICATION BEST PRACTICE") {
    id name
  }
}
EOF
    BODY_BESTPRACTICE=$(jq -r -n --arg Q "$Q_BESTPRACTICE" '{query:$Q}')
    

    RESP=$(curl -s --request POST \
        --url https://cloudinfra-gw.portal.checkpoint.com/app/i2/graphql/V1 \
        --header "authorization: Bearer ${TOKEN}" \
        --header 'content-type: application/json' \
        --data "$BODY_BESTPRACTICE")
    PRACTICEID=$(echo "$RESP" | jq -r '.data.getPractices[0].id')
    echo "$PRACTICEID"
}

function newLinuxProfile {
    read -r -d '' M_NEWPROFILE <<'EOF'
mutation {
  newEmbeddedProfile(profileInput:{}) {
    id name
  }
}
EOF
    BODY_NEWPROFILE=$(jq -r -n --arg Q "$M_NEWPROFILE" '{query:$Q}')
    

    RESP=$(curl -s --request POST \
        --url https://cloudinfra-gw.portal.checkpoint.com/app/i2/graphql/V1 \
        --header "authorization: Bearer ${TOKEN}" \
        --header 'content-type: application/json' \
        --data "$BODY_NEWPROFILE")
    NEWPROFILEID=$(echo "$RESP" | jq -r '.data.newEmbeddedProfile.id')
    echo "$NEWPROFILEID"
}


function newWebAsset {
    read -r -d '' Q_NEWWEBASSET <<'EOF'
mutation newWebAppAsset($assetInput:WebApplicationAssetInput!)  {
	newWebApplicationAsset(assetInput:$assetInput) {
    id name
  }
}
EOF
    read -r -d '' JQ_SCRIPT <<'EOF'
{ 
    query:$Q, 
    variables: {
        assetInput: {
            name: "web app 2",
   	        URLs: [$U],
            "profiles": [$P],
            "practices": {
                "mainMode": "Prevent",
                "practiceId": $B
            }
       }
    } 
}
EOF

echo "$JQ_SCRIPT"

    BODY_NEWWEBASSET=$(jq -r -n --arg Q "$Q_NEWWEBASSET" \
        --arg U "$1" --arg P "$NEWPROFILEID" --arg B "$PRACTICEID" \
        "$JQ_SCRIPT" )
    

    RESP=$(curl -s --request POST \
        --url https://cloudinfra-gw.portal.checkpoint.com/app/i2/graphql/V1 \
        --header "authorization: Bearer ${TOKEN}" \
        --header 'content-type: application/json' \
        --data "$BODY_NEWWEBASSET")
    NEWASSET=$(echo "$RESP" | jq -r '.')
    echo "$NEWASSET"
}

source appsec_keys.sh

getToken "${HORIZON_POLICY_CLIENTID}" "${HORIZON_POLICY_SECRETKEY}"

publishChanges

enforcePolicy

getProfileToken "$NEWPROFILEID"