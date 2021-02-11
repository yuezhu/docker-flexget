.PHONY: build push all

TAG := latest

all: build push

build:
	docker build -t yuezhu/flexget:$(TAG) .

push:
	docker push yuezhu/flexget:$(TAG)
