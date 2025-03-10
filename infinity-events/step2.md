# Step 2: Build query

```bash
# we alteady have the token
echo $TOKEN | cut -d. -f2 | base64 -d | jq

# let's build a query

# time range - since start of the month
start_of_month=$(date -u +"%Y-%m-01T00:00:00Z")
now=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# WAF web requests
filter='ci_app_name:"CloudGuard WAF" AND eventname:"Web Request"'

LOGQUERY=$(jq -n --arg FILTER "$filter" --arg START "$start_of_month" --arg END "$now" '
{
    "filter": $FILTER,
    "limit": 1000,
    "pageLimit": 100,
    "timeframe": {
        "startTime": $START,
        "endTime": $END
    }
}
'
)

# result
echo $LOGQUERY | jq 
```{{exec}}