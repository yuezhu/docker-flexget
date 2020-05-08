.PHONY: build push

TAG := latest

build:
	docker build -t yuezhu/flexget:$(TAG) .

push:
	docker push yuezhu/flexget:$(TAG)
