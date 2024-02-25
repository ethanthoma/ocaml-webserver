let
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable";
    pkgs = import nixpkgs { config = {}; overlays = []; };
in pkgs.mkShell {
    buildInputs = with pkgs; [
        dune_3
        ocaml
        ocamlformat
        ocamlPackages.findlib
        ocamlPackages.ocamlformat-rpc-lib
        ocamlPackages.ocaml-lsp
        ocamlPackages.utop
        opam
        reason
        turso-cli
        pkg-config
        openssl
    ];

    shellHook = ''
        eval $(opam env --switch=webserver)
    '';
}
