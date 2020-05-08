.PHONY: build push

DOCKER_UID := 1024
DOCKER_GID := 100
TAG := latest

build:
	docker build --build-arg DOCKER_UID=$(DOCKER_UID) --build-arg DOCKER_GID=$(DOCKER_GID) -t yuezhu/flexget:$(TAG) .

push:
	docker push yuezhu/flexget:$(TAG)
