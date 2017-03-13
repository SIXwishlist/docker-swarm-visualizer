#!/bin/bash
set -e

docker service create \
  --name visualizer \
  --publish 8080:8080 \
  --constraint 'node.role==manager' \
  --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  visualizer
