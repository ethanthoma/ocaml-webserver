FROM nixos/nix:latest AS builder

COPY . /tmp/build
WORKDIR /tmp/build

RUN nix-channel --update

RUN nix \
    --extra-experimental-features "nix-command flakes" \
    --option filter-syscalls false \
    build

RUN mkdir /tmp/nix-store-closure
RUN cp -R $(nix-store -qR result/) /tmp/nix-store-closure

FROM scratch

COPY --from=builder /tmp/nix-store-closure /nix/store
COPY --from=builder /tmp/build/result /app
CMD ["/app/bin/webserver"]
