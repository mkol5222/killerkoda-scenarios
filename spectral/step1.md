# Step 1: Authentication

Spectral is authenticated by providing DSN (data source name, "connection string" - https://en.wikipedia.org/wiki/Data_source_name )

Get your own SpectralOps DSN from web UI in your existing account 
https://get.spectralops.io/

and store it to enviroment variable similer to below:
```
export SPECTRAL_DSN='https://spk-bring-your-own-dsn-from-webui@get.spectralops.io/'
```{{exec}} 


Hint: your password manager might help with quick cut&paste in future demos.

```
# macOS: LastPass CLI storing ShiftLeft credentials script to clipboard
lpass show spectral-demo --notes | pbcopy
# now paste it to terminal here
```
