Param ([string]$Version = "0.1-dev")
Push-Location $(Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

$DockerRegistry = if ($Version.Contains("-")) {"docker-ci.axoom.cloud"} else {"docker.axoom.cloud"}

echo "Build Temporary Image"
$ImageId = docker build -q .

echo "Removing Old Plugin (if exists)"
docker plugin rm "$DockerRegistry/docker-volume-temp:$Version"

echo "Build Plugin"
docker run --rm --volume /var/run/docker.sock:/var/run/docker.sock $ImageId docker plugin create "$DockerRegistry/docker-volume-temp:$Version" /plugin

echo "Remove Temporary Image"
docker image rm $ImageId

Pop-Location
