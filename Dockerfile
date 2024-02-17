FROM nixos/nix:latest

COPY . .
WORKDIR .

RUN nix \
    --extra-experimental-features "nix-command flakes" \
    --option filter-syscalls false \
    build

CMD ["/result/bin/webserver"]
