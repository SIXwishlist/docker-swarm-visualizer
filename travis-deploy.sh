#!/bin/bash
set -e

docker tag visualizer "sealsystems/visualizer:linux-$ARCH-$TRAVIS_TAG"
docker push "sealsystems/visualizer:linux-$ARCH-$TRAVIS_TAG"

if [ "$ARCH" == "amd64" ]; then
  set +e
  echo "Waiting for other images sealsystems/visualizer:linux-arm-$TRAVIS_TAG"
  until docker run --rm stefanscherer/winspector "sealsystems/visualizer:linux-arm-$TRAVIS_TAG"
  do
    sleep 15
    echo "Try again"
  done
  until docker run --rm stefanscherer/winspector "sealsystems/visualizer:linux-arm64-$TRAVIS_TAG"
  do
    sleep 15
    echo "Try again"
  done
  until docker run --rm stefanscherer/winspector "sealsystems/visualizer:windows-amd64-$TRAVIS_TAG"
  do
    sleep 15
    echo "Try again"
  done
  set -e

  echo "Downloading manifest-tool"
  wget https://github.com/estesp/manifest-tool/releases/download/v0.4.0/manifest-tool-linux-amd64
  mv manifest-tool-linux-amd64 manifest-tool
  chmod +x manifest-tool
  ./manifest-tool

  echo "Pushing manifest sealsystems/visualizer:$TRAVIS_TAG"
  ./manifest-tool push from-args \
    --platforms linux/amd64,linux/arm,linux/arm64,windows/amd64 \
    --template "sealsystems/visualizer:OS-ARCH-$TRAVIS_TAG" \
    --target "sealsystems/visualizer:$TRAVIS_TAG"

  echo "Pushing manifest sealsystems/visualizer:latest"
  ./manifest-tool push from-args \
    --platforms linux/amd64,linux/arm,linux/arm64,windows/amd64 \
    --template "sealsystems/visualizer:OS-ARCH-$TRAVIS_TAG" \
    --target "sealsystems/visualizer:latest"
fi
