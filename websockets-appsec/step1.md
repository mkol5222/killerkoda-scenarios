
Welcome to fresh new Ubuntu 20.04 LTS machine.

Lets clone and build SignalR based real-time web app and deploy it as Docker container:
```
git clone https://github.com/mkol5222/signalr-app.git
cd signalr-app
docker build -t signalrapp .
docker run -d -it -p 8080:80 signalrapp

```{{exec}} 

Your app is now reachable via

Port 8080:
{{TRAFFIC_HOST1_8080}}

And Ports menu (traffic selector):
{{TRAFFIC_SELECTOR}}