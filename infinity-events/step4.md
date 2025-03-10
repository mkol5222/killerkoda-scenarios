# Step 4: Fetch data - first page

```bash
# query was executed, data ready

# get the first page by token
echo "Page token: $PAGETOKEN"

# fetch the data
LOGS=$(curl -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" \
   -s https://cloudinfra-gw.portal.checkpoint.com/app/laas-logs-api/api/logs_query/retrieve \
   -d "{\"taskId\":\"$TASKID\",\"pageToken\":\"$PAGETOKEN\"}")

# show the data
echo $LOGS | jq -r '.data.records[]' | less

# we have got N records
echo -n "Count: "; echo $LOGS | jq -r -c '.data.records[]' | wc -l

# data include next page token, if needed
echo $LOGS | jq -r -c '.data | keys'

PAGETOKEN=$(echo $LOGS | jq -r '.data.nextPageToken')
echo "Next page token: $PAGETOKEN"
```{{exec}}