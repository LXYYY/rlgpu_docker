.PHONY: build start run shell stop clean

IMAGE_NAME := mikexyliu/rlgpu:latest
CONTAINER_NAME := air_hockey_rlgpu_container

build:
	docker build -t $(IMAGE_NAME) .

start: run

run:
	docker run --name $(CONTAINER_NAME) --gpus all -v "$(shell pwd):/workspace/src" $(IMAGE_NAME)

shell:
	docker exec -it -u gymuser $(CONTAINER_NAME)  /bin/bash

stop:
	docker stop $(CONTAINER_NAME) && docker rm $(CONTAINER_NAME)

clean:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true
	docker rmi $(IMAGE_NAME) || true

