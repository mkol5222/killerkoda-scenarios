
Install terraform:
```bash
getLatestVersion() {
LATEST_ARR=($(wget -q -O- https://api.github.com/repos/hashicorp/terraform/releases 2> /dev/null | awk '/tag_name/ {print $2}' | cut -d '"' -f 2 | cut -d 'v' -f 2))
for ver in "${LATEST_ARR[@]}"; do
  if [[ ! $ver =~ beta ]] && [[ ! $ver =~ rc ]] && [[ ! $ver =~ alpha ]]; then
    LATEST="$ver"
    break
  fi
done
echo -n "$LATEST"
}

VERSION=$(getLatestVersion)

cd ~
wget "https://releases.hashicorp.com/terraform/"$VERSION"/terraform_"$VERSION"_linux_amd64.zip"
unzip "terraform_"$VERSION"_linux_amd64.zip"
sudo install terraform /usr/local/bin/
```{{exec}}

Now terraform is readyt to use:
```bash
terraform -v
```{{exec}}