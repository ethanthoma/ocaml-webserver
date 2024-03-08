# Blog Website

This is a really simple blogging website. You can check it out 
[here](https://www.ethanthoma.com/).

## Stack

| Tech           | Stack    |
|----------------|----------|
| Htmx           | Frontend |
| Ocaml & Reason | Backend  |
| Turso w/ Go    | Database |

## Building + Running

The nix flake has two build targets:
1. dune project derivation: produces a binary that one can run as is
2. docker image: produces a minimal image that contains the derivation

The derivation can be built with `nix build` and the image can be built with 
`nix build .#docker`.

## Complications

It uses Ocaml for the webserver and Reason for templating. I opted to use Turso 
for the DB but the client support for Ocaml is _poor_. So, I compiled Go to C 
and use Dune to bind the C code to Ocaml...probably not the best idea but it 
does work. Nix is used to build the code and with GitHub workflows, it gets 
deployed. Locally, I test using the Makefile. This will let you easily run and 
clean.
