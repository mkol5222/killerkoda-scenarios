# Step 1: Login to Infinity Events

```bash
# bring your own Infinity Logs API key: 
#  https://portal.checkpoint.com/dashboard/settings/api-keys
export KEY=7de7b4390fb9421fbf1133024ab50aed
export SECRET=e23d4fe4092f4ae3b1c3fb00a24a1f4d

# login to the Infinity API
LOGIN_PAYLOAD=$(jq -n --arg key $KEY --arg secret $SECRET '{"clientId":$key,"accessKey":$secret}')
LOGINRESP=$(curl -s -X POST -H "Content-Type: application/json" -d "$LOGIN_PAYLOAD" https://cloudinfra-gw.portal.checkpoint.com/auth/external)
TOKEN=$(echo "$LOGINRESP" | jq -r .data.token)

# now we have TOKEN for our Infinity API
echo $TOKEN
# it is JWT token, so we can decode it to see what is inside
echo $TOKEN | cut -d. -f2 | base64 -d | jq
```{{exec}}