# Blog Website

This is a really simple blogging website made in Ocaml (and reasonml).

## Stack

- ReasonML  | templating
- Ocaml     | backend
- Turso     | database
- Htmx      | frontend library

## TODO

- Use turso for blog storage and blog meta-data
- Setup cloudfair for cdn and routing from domain name

## Building + Running

The nix flake has two build targets:
1. dune project derivation: produces a binary that one can run as is
2. docker image: produces a minimal image that contains the derivation

The derivation can be built with `nix build` and the image can be built with 
`nix build .#image`.
