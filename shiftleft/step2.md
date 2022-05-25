# Step 2: Instalation

### Download
```
mkdir "$HOME/.cpshiftleft"
SHIFTLEFT="$HOME/.cpshiftleft/shiftleft"
echo "Downloading shiftleft binary to ${SHIFTLEFT}"
curl -L https://shiftleft-prod.s3.amazonaws.com/blades/shiftleft/bin/linux/amd64/0.0.24/shiftleft -o "$SHIFTLEFT"
```{{exec}} 


### Make executable and test
```
chmod +x "$SHIFTLEFT"
"$SHIFTLEFT" --version
```{{exec}} 


Reference: shiftleft on [GitHub](https://github.com/dome9/shiftleft)