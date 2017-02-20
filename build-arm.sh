#!/bin/bash

docker build -t sealsystems/visualizer:latest-arm -f Dockerfile.arm .

# Push
if [ "$1" == "--push" ]; then
  echo "Pushing sealsystems/visualizer..."
  docker push sealsystems/visualizer:latest-arm
fi

echo "Done."
