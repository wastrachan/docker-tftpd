# TFTPD


## Description

This project contains the configuration to create a docker image of the tftpd service.


## Pre-Requirements

### Packages
```
docker
docker compose
```

### Directories and files
```bash
/tftpboot
/var/log/tftpd.log
```


## Installation

Generate the configuration file from `docker-compose.yml` located in this project and modify the following parameters:
* `image`: Locates the tag where the most up-to-date image is located.
* `volumes`: Volumes contain the path of the files necessary for correct operation ("`/tftpboot` and `/var/log/tftpd.log`")

To download the project image, run in the path where the `docker-compose.yml` file is located:
```bash
PGID=$(id -g) PUID=$(id -u) docker-compose up -d
```

`Note`: If you'd like to override the UID and GID of the tftpd process, you can do so with the environment variables `PUID` and `PGID`. This is helpful if other containers must access your configuration volume.


## Running the tests

Perform a GET or PUT method query through the tftp client and verify that the file was copied correctly.

### GET method
```bash
tftp -v 172.20.0.2 69 -c get Spanish.txt Spanish-local.txt
```


### PUT method

```bash
tftp -v 172.20.0.2 69 -c put Spanish-local.txt Spanish.txt
```

`Note`: Remember that to perform the `PUT` method the file must exist on the `/tftpboot` shared volume. If you want to create a file, add the following line in your `docker-compose.yml` 
```yml
command: ["/usr/sbin/in.tftpd", "-c", "-L", "-v", "-s" , "-u", "tftpd", "/tftpboot"]
```
The `-c` flag allows you to create new files in case they do not exist.


## Built with

* Docker - v26.1.3
* Docker Compose - v2.18.1


## Autors

* iKono Telecomunicaciones