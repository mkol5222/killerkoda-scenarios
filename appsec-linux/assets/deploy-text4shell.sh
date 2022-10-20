#!/bin/bash

echo 'Stopping Acme Audit'
docker stop acmeaudit

echo 'Getting text4shell'
cd
git clone https://github.com/karthikuj/cve-2022-42889-text4shell-docker.git
cd cve-2022-42889-text4shell-docker/

echo 'Installing Java and Maven'
sudo apt update
sudo apt install maven -y
mvn clean install

echo 'Building docker container'
docker build --tag=text4shell .

echo 'text4shell server starting'
docker run -p 8080:8080 -d --name text4shell text4shell
docker ps
echo 'Done'