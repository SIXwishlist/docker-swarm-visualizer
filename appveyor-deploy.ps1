$ErrorActionPreference = 'Stop';

docker tag visualizer sealsystems/visualizer:windows-amd64-$env:APPVEYOR_REPO_TAG_NAME

docker push sealsystems/visualizer:windows-amd64-$env:APPVEYOR_REPO_TAG_NAME
