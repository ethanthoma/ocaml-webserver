{ 
    pkgs ? let 
        nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable";
    in import nixpkgs {},
    goDeps
}:

pkgs.mkShell {
    packages = with pkgs; [
        ocaml
        ocamlformat
        ocamlPackages.findlib
        ocamlPackages.ocamlformat-rpc-lib
        ocamlPackages.utop
        opam
        turso-cli
        pkg-config
    ] ++ goDeps;

    shellHook = ''
        eval $(opam env --switch=website)
    '';
}
