# Temporary Storage Volume Plugin for Docker

This Docker plugin provides temporary storage for volumes. This is commonly used to provide a drop-in mock/replacement for other volume drivers via aliases.

Run `build.sh` or `build.ps1` to compile the source code and package the result as a [Managed Docker Plugin](https://docs.docker.com/engine/extend/).
These scripts take a version number as an input argument. The source code itself contains no version numbers. Instead version numbers should be determined at build time using [GitVersion](http://gitversion.readthedocs.io/).



## Usage

### 1. Install the plugin

```
$ docker plugin install --grant-all-permissions --alias data docker.axoom.cloud/docker-volume-temp:1.0.0
```

### 2. Create a volume

```
$ docker volume create -d data myvolume
sharedvolume
$ docker volume ls
DRIVER              VOLUME NAME
local               2d75de358a70ba469ac968ee852efd4234b9118b7722ee26a1c5a90dcaea6751
local               842a765a9bb11e234642c933b3dfc702dee32b73e0cf7305239436a145b89017
local               9d72c664cbd20512d4e3d5bb9b39ed11e4a632c386447461d48ed84731e44034
local               be9632386a2d396d438c9707e261f86fd9f5e72a7319417901d84041c8f14a4d
local               e1496dfe4fa27b39121e4383d1b16a0a7510f0de89f05b336aab3c0deb4dda0e
data                myvolume
```

### 3. Use the volume

For a single container:
```
$ docker run -it -v global:<path> busybox ls <path>
```

In Docker Compose:
```yml
version: '3.0'

services:
  myservice:
    volumes:
      - "myvolume:/some/dir"

volumes:
  myvolume:
    driver: global
```
