<h3 align="center">
	<img 
    src="https://raw.githubusercontent.com/ethanthoma/ocaml-webserver/main/public/favicon/android-chrome-512x512.png" 
    width="100"
    alt="Logo"/>
  <br/>
	Blog and Personal <a href="https://www.ethanthoma.com/">Website</a>
</h3>

<p align="center">
	<img src="https://img.shields.io/github/last-commit/ethanthoma/ocaml-webserver/main?style=for-the-badge&labelColor=%231f1d2e&color=%23c4a7e7">
	<img src="https://img.shields.io/github/actions/workflow/status/ethanthoma/ocaml-webserver/docker.yml?style=for-the-badge&labelColor=%231f1d2e&color=%239ccfd8">
	<img src="https://img.shields.io/github/languages/count/ethanthoma/ocaml-webserver?style=for-the-badge&labelColor=%231f1d2e&color=%23ebbcba">
</p>


## 🤖 Stack

| Tech           | Stack    |
|----------------|----------|
| Htmx           | Frontend |
| Ocaml & Reason | Backend  |
| Turso w/ Go    | Database |

## 🚀 Building + Running

The nix flake has two build targets:
1. dune project derivation: produces a binary that one can run as is
2. docker image: produces a minimal image that contains the derivation

The derivation can be built with `nix build` and the image can be built with 
`nix build .#docker`.

You can run it easily (assuming you have docker setup) with `make run`. If you 
want to clean up afterwards, use `make clean`.

## 🧮 Complications

It uses Ocaml for the webserver and Reason for templating. I opted to use Turso 
for the DB but the client support for Ocaml is _poor_. So, I compiled Go to C 
and use Dune to bind the C code to Ocaml...probably not the best idea but it 
does work. Nix is used to build the code and with GitHub workflows, it gets 
deployed. Locally, I test using the Makefile. This will let you easily run and 
clean.
