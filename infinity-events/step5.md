# Step 5: Iterate rest of data

```bash
# we have token of 2nd page if not NULL(null)
echo "Page token: $PAGETOKEN"

while true; do
   if [ "$PAGETOKEN" == "null" ]; then
      echo "No more pages"
      break
   fi
   if [ "$PAGETOKEN" == "NULL" ]; then
      echo "No more pages"
      break
   fi
   LOGS=$(curl -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" \
      -s https://cloudinfra-gw.portal.checkpoint.com/app/laas-logs-api/api/logs_query/retrieve \
      -d "{\"taskId\":\"$TASKID\",\"pageToken\":\"$PAGETOKEN\"}")
   
   echo $LOGS | jq -r -c '.data.records[]' 
   PAGETOKEN=$(echo $LOGS | jq -r .data.nextPageToken)
done

```{{exec}}