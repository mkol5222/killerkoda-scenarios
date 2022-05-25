# Step 1: Authentication

`shiftleft` command is authorized when presenting API keys that are generated in CloudGuard Native web UI. Please run equivalent of these commands based on your real account.

```
export CHKP_CLOUDGUARD_ID=bring-your-own
export CHKP_CLOUDGUARD_SECRET=key-from-cloudguard-native-webui
export SHIFTLEFT_REGION=eu1
```{{exec}} 


Hint: your password manager might help with quick cut&paste in future demos.

```
# macOS: LastPass CLI storing ShiftLeft credentials script to clipboard
lpass show shiftleft-mtest2 --notes | pbcopy
# now paste to terminal here
```
