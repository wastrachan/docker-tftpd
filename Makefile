# Docker tftpd Image
#
# Winston Astrachan 2024

SHELL=/bin/bash

.PHONY: help
help:
	@echo ""
	@echo "Usage: make COMMAND"
	@echo ""
	@echo "Docker tftpd image makefile"
	@echo ""
	@echo "Commands:"
	@echo "  build        Build and tag image"
	@echo "  run          Start container in the background with locally mounted volume"
	@echo "  stop         Stop and remove container running in the background"
	@echo "  clean        Mark image for rebuild"
	@echo "  delete       Delete image and mark for rebuild"
	@echo ""

.PHONY: build
build: .tftpd.img

.tftpd.img:
	docker build -t wastrachan/tftpd:latest .
	@touch $@

.PHONY: run
run: build
	docker run -v "$(CURDIR)/data:/data" \
	           --name tftpd \
	           -p 69:69/udp \
			   -e PUID=$$(id -u) \
			   -e PGID=$$(id -g) \
	           --restart unless-stopped \
	           -d \
	           wastrachan/tftpd:latest

.PHONY: stop
stop:
	docker stop tftpd
	docker rm tftpd

.PHONY: clean
clean:
	rm -f .tftpd.img

.PHONY: delete
delete: clean
	docker rmi -f wastrachan/tftpd
