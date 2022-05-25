# Step 3: Container image scan

We will focus on container image scan functionality in this step.
```
"$SHIFTLEFT" image-scan -h
```{{exec}}

Lets use Docker to bring outdated container image to be scanned.

Is docker ready?
```
docker info | head
```{{exec}}

[Docker Hub](https://hub.docker.com/_/debian?tab=tags&page=1&ordering=-last_updated) and container image tag view sorted with oldest first would help find intersting images. Debian image from 6/2017:
```
docker pull debian:stable-20170606
```{{exec}}

Tool is scanning image saved to TAR. Get it from Docker:
```
docker save -o /tmp/oldimage.tar debian:stable-20170606
```{{exec}}


Scan start (-D for verbose debug output)
```
"$SHIFTLEFT" image-scan -i /tmp/oldimage.tar
```{{exec}}

But we would like to see results in CloudGuard Native web interface.
Find ShiftLeft environment ID in Assets / Environments / CloudGuard ID
Use your own environment ID:
`-e 7e0a0329-6274-4ff7-afcd-233d63e036e1`

And find Container Scan rule set ID in Shift Left / Rulesets / Container Image Assurance
https://portal.checkpoint.com/dashboard/cloudguard#/shiftleft/rulesets/-2000
`-r -2000`

Scan with data upload to web UI.
Use your own environment ID:
`-e 7e0a0329-6274-4ff7-afcd-233d63e036e1 -r -2000`

```
"$SHIFTLEFT"  image-scan -i /tmp/oldimage.tar -e 7e0a0329-6274-4ff7-afcd-233d63e036e1 -r -2000
```{{exec}}

Result is saved under ShiftLeft / Assesment History
https://portal.checkpoint.com/dashboard/cloudguard#/shiftleft/history?

