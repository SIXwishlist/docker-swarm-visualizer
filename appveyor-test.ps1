Write-Host Starting test

$ErrorActionPreference = 'Stop';
Write-Host Testing container
docker run --entrypoint node.exe visualizer --version
