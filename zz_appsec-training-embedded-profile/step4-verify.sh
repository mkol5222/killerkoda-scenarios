#!/bin/bash

CODE=$(curl -s -o /dev/null -w "%{http_code}" "$APP_URL?q=UNION+1=1")
[[ "$CODE" = "403" ]]
