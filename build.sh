#!/bin/bash

docker build -t sealsystems/visualizer:latest .

# Push
if [ "$1" == "--push" ]; then
  echo "Pushing sealsystems/visualizer..."
  docker push sealsystems/visualizer:latest
fi

echo "Done."
