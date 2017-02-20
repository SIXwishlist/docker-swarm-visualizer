#!/bin/bash

docker build -t sealsystems/visualizer:latest-aarch64 -f Dockerfile.aarch64 .

# Push
if [ "$1" == "--push" ]; then
  echo "Pushing sealsystems/visualizer..."
  docker push sealsystems/visualizer:latest-aarch64
fi

echo "Done."
