let
    nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-23.11";
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
    ];

    shellHook = ''
        eval $(opam env)    
    '';
}
