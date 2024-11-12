#!/bin/bash

docker tag client docker.io/kirilliliych/pdris-task3-docker-client:latest
docker push kirilliliych/pdris-task3-docker-client:latest

docker tag server docker.io/kirilliliych/pdris-task3-docker-server:latest
docker push kirilliliych/pdris-task3-docker-server:latest
