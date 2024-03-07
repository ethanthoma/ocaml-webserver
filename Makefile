.PHONY: healthy

IMAGE_NAME = webserver
TAG = latest
CONTAINER_NAME = "webserver-instance"
LOCAL_HOST = 127.0.0.1:3000

install:
	opam switch create . 5.1.1 -w --no-install -y
	opam install dream reason tyxml-jsx fuzzy_match omd ppx_string ocaml-lsp-server -y

build:
	nix build .#docker

run: build
	docker load < result
	docker run --env-file ./.env -d -t --name $(CONTAINER_NAME) -p $(LOCAL_HOST):3000 $(IMAGE_NAME):$(TAG) 

healthy:
	wget $(LOCAL_HOST)/healthy
	rm healthy

clean:
	-docker stop $(CONTAINER_NAME)
	-docker rm $(CONTAINER_NAME)
	-docker rmi $(IMAGE_NAME):$(TAG)
