# Tftpd Docker Image

tftpd in a Docker container, with a data directory in a volume, and a configurable UID/GID for the tftpd process.

[![CircleCI](https://circleci.com/gh/wastrachan/docker-tftpd/tree/master.svg?style=svg)](https://circleci.com/gh/wastrachan/docker-tftpd/tree/master)
[![](https://img.shields.io/docker/pulls/wastrachan/tftpd.svg)](https://hub.docker.com/r/wastrachan/tftpd)

## Install

#### Docker Hub

Pull the latest image from Docker Hub:

```shell
docker pull wastrachan/tftpd
```

#### Github Container Registry

Or, pull from the GitHub Container Registry:

```shell
docker pull ghcr.io/wastrachan/tftpd
```

#### Build From Source

Clone this repository, and run `make build` to build an image:

```shell
git clone https://github.com/wastrachan/docker-tftpd.git
cd docker-tftpd
make build
```

## Run

#### Docker

Run this image with the `make run` shortcut, or manually with `docker run`.

```shell
docker run -v "$(pwd)/data:/data" \
           --name tftpd \
           --rm \
           -p 69:69/udp \
           -e PUID=$(id -u) \
           -e PGID=$(id -g) \
           wastrachan/tftpd:latest
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
