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

"No more pages" means that all data was fetched.
Task state now should be `Done` and there is list of all consumed log pages:

```bash
LOGSTASK=$(curl -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" \
        -s https://cloudinfra-gw.portal.checkpoint.com/app/laas-logs-api/api/logs_query/$TASKID)
echo $LOGSTASK | jq .
```{{exec}}

Similar to output:
```json
{
  "success": true,
  "data": {
    "state": "Done",
    "pageTokens": [
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0IjoxfQ==",
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0IjoxMDF9",
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0IjoyMDF9",
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0IjozMDF9",
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0Ijo0MDF9",
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0Ijo1MDF9",
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0Ijo2MDF9",
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0Ijo3MDF9",
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0Ijo4MDF9",
      "eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0Ijo5MDF9"
    ]
  }
}
```

Did you know that you can decode PAGETOKENS too? 

```bash
echo eyJyZXF1ZXN0SWQiOiJjNGM4Y2I2Yi0xMzI5LTQxZGQtYTlhNy04ODNhNmM0MzZkZjIiLCJwYWdlT2Zmc2V0Ijo3MDF9 | base64 -d | jq
```{{exec}} 

Sample (requestId is TASKID and there is offset of the page in number of records before):
```json
{
  "requestId": "c4c8cb6b-1329-41dd-a9a7-883a6c436df2",
  "pageOffset": 701
}
```
