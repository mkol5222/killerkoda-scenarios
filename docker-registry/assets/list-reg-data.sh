#!/bin/bash

docker volume ls | grep registry 
docker run --rm -it -v registry_data:/data ubuntu find /data/