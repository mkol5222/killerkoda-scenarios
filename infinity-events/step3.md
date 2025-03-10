# Step 3: Execute query

```bash
# now we have auth TOKEN and ready to use LOGQUERY
echo $LOGQUERY | jq

# lets execute the query and check for status
LOGQUERY_RES=$(curl -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" \
        -s https://cloudinfra-gw.portal.checkpoint.com/app/laas-logs-api/api/logs_query \
        -d "$LOGQUERY")
echo $LOGQUERY_RES | jq .
```{{exec}}

Response should look like:
```
{
  "success": true,
  "data": {
    "taskId": "c2264bae-9418-4213-83ad-73e1eae5dda6"
  }
}
```

This means that query was accepted and now we can check the status of the task.
```bash
TASKID=$(echo $LOGQUERY_RES | jq -r .data.taskId)
echo $TASKID

LOGSTASK=$(curl -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" \
        -s https://cloudinfra-gw.portal.checkpoint.com/app/laas-logs-api/api/logs_query/$TASKID)
echo $LOGSTASK | jq .
```{{exec}}

Response should look like below depending on state of the task.
If  not ready yet, execute again later.
```
{
  "success": true,
  "data": {
    "state": "Ready",
    "pageTokens": [
      "eyJyZXF1ZXN0SWQiOiJjMjI2NGJhZS05NDE4LTQyMTMtODNhZC03M2UxZWFlNWRkYTYiLCJwYWdlT2Zmc2V0IjoxfQ=="
    ]
  }
}
```

```bash
# if state is Ready, we can get the data
PAGETOKEN=$(echo $LOGSTASK | jq -r .data.pageTokens[0])
echo "Page token: $PAGETOKEN"
```{{exec}}