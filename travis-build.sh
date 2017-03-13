#!/bin/bash
set -e

dockerfile=Dockerfile

if [ $ARCH != "amd64" ]; then
  # prepare qemu
  docker run --rm --privileged multiarch/qemu-user-static:register --reset
  dockerfile=Dockerfile.$ARCH

  if [ $ARCH == "arm64" ]; then
    # prepare qemu binary
    docker create --name register hypriot/qemu-register
    docker cp register:qemu-aarch64 qemu-aarch64-static
    dockerfile=Dockerfile.aarch64
  fi
fi

# build image
docker build -t visualizer -f $dockerfile .
