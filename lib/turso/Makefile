.PHONY: build

build:
	go build -o dllgo_turso.so -buildmode=c-shared -mod=vendor ./cmd/
	go build -o libgo_turso.a -buildmode=c-archive -mod=vendor ./cmd/
