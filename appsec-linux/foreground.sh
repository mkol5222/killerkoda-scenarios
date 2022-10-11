echo "Installing scenario..."

echo "Packages"
apt install jq -y

echo "Services"
docker run -d -p 8080:3000 public.ecr.aws/f4q1i2m2/acmeaudit
docker ps

echo "DONE"