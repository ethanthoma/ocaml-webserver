.PHONY: healthy

IMAGE_NAME = webserver
TAG = latest
CONTAINER_NAME = "webserver-instance"
LOCAL_HOST = 127.0.0.1:3000

build:
	nix build .#docker

run: build
	docker load < result
	docker run -d -t --name $(CONTAINER_NAME) -p $(LOCAL_HOST):3000 $(IMAGE_NAME):$(TAG) 

healthy:
	wget $(LOCAL_HOST)/healthy
	rm healthy

clean:
	-docker stop $(CONTAINER_NAME)
	-docker rm $(CONTAINER_NAME)
	-docker rmi $(IMAGE_NAME):$(TAG)
