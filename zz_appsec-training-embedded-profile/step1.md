Welcome to fresh new Ubuntu 20.04 LTS machine.

Lets deploy ready to use Acme Audit web app using Docker container:
```
docker run -d -p 8080:3000 --name acmeaudit public.ecr.aws/f4q1i2m2/acmeaudit
```{{exec}} 

Your app is now reachable via

Port 8080:
{{TRAFFIC_HOST1_8080}}

And Ports menu (traffic selector):
{{TRAFFIC_SELECTOR}}