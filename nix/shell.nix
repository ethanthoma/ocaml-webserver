{ 
    pkgs ? let 
        nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable";
    in import nixpkgs {},
    devDeps
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
        openssl
    ] ++ devDeps;

    shellHook = ''
        turso config set token "$TURSO_TOKEN"
        eval $(opam env --switch=website)
    '';
}
