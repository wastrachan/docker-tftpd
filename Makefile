.DEFAULT_GOAL := help

.PHONY: help
help:  ## Show this help message
	@echo ""
	@echo "Docker tftpd Makefile"
	@echo "Usage: make [target]"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"} \
		/^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5); next } \
		/^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2 }' \
		$(MAKEFILE_LIST)
	@echo ""

IMAGE=wastrachan/tftpd
TAG=latest
REGISTRY=docker.io

.PHONY: build
build: ## Build and tag image
	@docker build -t ${REGISTRY}/${IMAGE}:${TAG} .

.PHONY: push
push: ## Push tagged image to registry
	@docker push ${REGISTRY}/${IMAGE}:${TAG}

.PHONY: run
run: build ## Start container in the background with locally mounted volume
	docker run -v "$(CURDIR)/config:/config" \
	           --name tftpd \
			   --rm \
	           -p 69:69/udp \
	           -e PUID=$$(id -u) \
	           -e PGID=$$(id -g) \
	           -d \
	           ${REGISTRY}/${IMAGE}:${TAG}

.PHONY: stop
stop: ## Stop and remove container running in the background
	@docker stop tftpd

.PHONY: delete
delete: ## Delete all built image versions
	@docker image ls | grep ${IMAGE} | awk '{print $$3}' | xargs -I + docker rmi +
