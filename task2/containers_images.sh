#!/bin/bash

docker build -t host_img -f Dockerfile_host .
docker build -t ansible_img -f Dockerfile_ansible .