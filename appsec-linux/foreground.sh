echo "Installing scenario..."

echo "Starting services"
docker run -d -p 8080:3000 --name acmeaudit public.ecr.aws/f4q1i2m2/acmeaudit
docker ps

echo "DONE"