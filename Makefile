# tftpd Docker Image

.PHONY: help
help:
	@echo ""
	@echo "Usage: make COMMAND"
	@echo ""
	@echo "Docker tftpd image makefile"
	@echo ""
	@echo "Commands:"
	@echo "  build        Build and tag image"
	@echo "  push         Push tagged image to registry"
	@echo "  run          Start container in the background with locally mounted volume"
	@echo "  stop         Stop and remove container running in the background"
	@echo "  delete       Delete all built image versions"
	@echo ""

IMAGE=wastrachan/tftpd
TAG=latest
REGISTRY=docker.io

.PHONY: build
build:
	@docker build -t ${REGISTRY}/${IMAGE}:${TAG} .

.PHONY: push
push:
	@docker push ${REGISTRY}/${IMAGE}:${TAG}

.PHONY: run
run: build
	docker run -v "$(CURDIR)/config:/config" \
	           --name tftpd \
			   --rm \
	           -p 69:69/udp \
	           -e PUID=$$(id -u) \
	           -e PGID=$$(id -g) \
	           -d \
	           ${REGISTRY}/${IMAGE}:${TAG}

.PHONY: stop
stop:
	@docker stop tftpd

.PHONY: delete
delete:
	@docker image ls | grep ${IMAGE} | awk '{print $$3}' | xargs -I + docker rmi +
