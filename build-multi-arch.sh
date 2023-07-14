#!/bin/bash

docker buildx build --platform linux/arm64,linux/amd64 -t hackinglab/ubuntu-nginx-nodejs-hl:latest -f Dockerfile . --push
docker buildx build --platform linux/arm64,linux/amd64 -t hackinglab/ubuntu-nginx-nodejs-hl:18.04 -f Dockerfile.18.04 . --push
docker buildx build --platform linux/arm64,linux/amd64 -t hackinglab/ubuntu-nginx-nodejs-hl:22.04 -f Dockerfile.22.04 . --push
