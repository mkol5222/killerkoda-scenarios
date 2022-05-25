# Step 4: Source code scan

We will focus on source code scan functionality in this step.
```
"$SHIFTLEFT" code-scan -h
```{{exec}}


Lets clone some outdated project to be investigated.
```
mkdir /tmp/sourceguard-demo
git clone https://github.com/mkol5222/sbport /tmp/sourceguard-demo
```{{exec}}


Start scan
```
"$SHIFTLEFT" code-scan -s /tmp/sourceguard-demo
```{{exec}}


Scan may also produce JSON output with recommended ACTION and findings details:
```
"$SHIFTLEFT"  code-scan -s /tmp/sourceguard-demo --json | jq . | head
```{{exec}}


But production deployments upload data to CloudGuard Native web interface:

Find ShiftLeft environment ID in Assets / Environments / CloudGuard ID
Use your own IDs:
`-e 7e0a0329-6274-4ff7-afcd-233d63e036e1`

Find Container Scan rule set ID in Shift Left / Rulesets / [Container Image Assurance](https://portal.checkpoint.com/dashboard/cloudguard#/shiftleft/rulesets/-2003)
`-r -2000`

Summary:
`-e 7e0a0329-6274-4ff7-afcd-233d63e036e1 -r -2003`

Supply these additional arguments to the tool
```
"$SHIFTLEFT"  code-scan -s /tmp/sourceguard-demo -e 7e0a0329-6274-4ff7-afcd-233d63e036e1 -r -2003
```{{exec}}


Result is saved under ShiftLeft / Assesment History
https://portal.checkpoint.com/dashboard/cloudguard#/shiftleft/history?