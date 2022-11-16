#!/bin/bash

CODE=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL?q=UNION+1=1")
if [[ "$CODE" = "403" ]] ; then
    touch /tmp/appsec-Enforcing
fi
stat /tmp/appsec-Enforcing
