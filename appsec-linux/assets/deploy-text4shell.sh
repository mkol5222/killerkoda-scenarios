#!/bin/bash

docker stop acmeaudit

cd
git clone https://github.com/karthikuj/cve-2022-42889-text4shell-docker.git
cd cve-2022-42889-text4shell-docker/

sudo apt update
sudo apt install maven
mvn clean install
docker build --tag=text4shell .
docker run -p 8080:8080 text4shell
