#!/bin/bash
set -e

if [ "$ARCH" != "amd64" ]; then
  # prepare qemu
  docker run --rm --privileged multiarch/qemu-user-static:register --reset

  if [ "$ARCH" == "arm64" ]; then
    # prepare qemu binary
    docker create --name register hypriot/qemu-register
    docker cp register:qemu-aarch64 qemu-aarch64-static
  fi
fi

if [ -d tmp ]; then
  docker rm build
  rm -rf tmp
fi

# prepare build on Intel
docker build -t build -f Dockerfile.amd64-build .
docker create --name build build
docker cp build:/app/ tmp/
rm -rf tmp/node_modules
# build final image
docker build -t visualizer -f "Dockerfile.$ARCH" .
