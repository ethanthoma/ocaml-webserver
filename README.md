# Blog Website

This is a really simple blogging website made in Ocaml (and reasonml).

## Stack

- ReasonML for JSX templating
- Ocaml backend
- Htmx

## TODO

- Add meta-data for blogs
- Probably a db for storing blogs
- Better way to search all blogs

## Installation

The nix flake has two build targets:
1. dune project derivation: produces a binary that one can run as is
2. docker image: produces a minimal image that contains the derivation

The derivation can be built with `nix build` and the image can be built with 
`nix build .#image`.
