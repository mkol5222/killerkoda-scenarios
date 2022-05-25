# Step 2: Instalation

Download requires part of DSN to be provided
```
export SPECTRAL_TOKEN=$(echo "$SPECTRAL_DSN" | cut -d/ -f3 | cut -d@ -f1)
```{{exec}}

Optional: inspect installation helper script
```
curl -s -L "https://get.spectralops.io/latest/x/sh?key=${SPECTRAL_TOKEN}" | head 
```{{exec}}

Run installation
```
curl -L "https://get.spectralops.io/latest/x/sh?key=${SPECTRAL_TOKEN}" | sh
```{{exec}}

Verify. Binary was stored in dot-folder `$HOME/.spectral`
```
$HOME/.spectral/spectral --help
```{{exec}}

Check config - DSN is your identity - https://en.wikipedia.org/wiki/Data_source_name - "connection string"
```
$HOME/.spectral/spectral config
```{{exec}}