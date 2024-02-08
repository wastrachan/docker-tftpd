# Tftpd Docker Image

Tftpd in a Docker container, with a data directory in a volume, and a configurable UID/GID for data files.

[![CircleCI](https://circleci.com/gh/wastrachan/docker-tftpd/tree/master.svg?style=svg)](https://circleci.com/gh/wastrachan/docker-tftpd/tree/master)
[![](https://img.shields.io/docker/pulls/wastrachan/tftpd.svg)](https://hub.docker.com/r/wastrachan/tftpd)

## Install

#### Docker Hub

Pull the latest image from Docker Hub:

```shell
docker pull wastrachan/tftpd
```

#### Manually

Clone this repository, and run `make build` to build an image:

```shell
git clone https://github.com/wastrachan/docker-tftpd.git
cd docker-tftpd
make build
```

If you need to rebuild the image, run `make clean build`.

## Run

#### Docker

Run this image with the `make run` shortcut, or manually with `docker run`.

```shell
docker run -v "$(pwd)/data:/data" \
           --name tftpd \
           -p 69:69/udp \
			     -e PUID=$(id -u) \
			     -e PGID=$(id -g) \
           --restart unless-stopped \
           wastrachan/tftpd:latest
```

#### Docker Compose

If you wish to run this image with docker-compose, an example `docker-compose.yml` might read as follows:

```yaml
---
version: "2"

services:
  tftpd:
    image: wastrachan/tftpd
    container_name: tftpd
    environment:
      - PUID=1111
      - PGID=1112
    volumes:
      - </path/to/data>:/data
    ports:
      - 69:69/udp
    restart: unless-stopped
```

## Configuration

#### User / Group Identifiers

If you'd like to override the UID and GID of the `tftpd` process, you can do so with the environment variables `PUID` and `PGID`. This is helpful if other containers must access your configuration volume.

#### Services

| Service | Port |
| ------- | ---- |
| TFTPD   | 69   |

#### Volumes

| Volume  | Description                              |
| ------- | ---------------------------------------- |
| `/data` | Data directory for files served by tftpd |

## License

The content of this project itself is licensed under the [MIT License](LICENSE).

View [license information](https://www.isc.org/downloads/software-support-policy/isc-license/) for the software contained in this image.
