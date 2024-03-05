{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        opam-nix.url = "github:tweag/opam-nix";
        flake-utils.url = "github:numtide/flake-utils";
    };

    outputs = { self, flake-utils, opam-nix, nixpkgs }:
    let 
        package = "webserver";
        src = ./.;
    in flake-utils.lib.eachDefaultSystem (system:
        let
            pkgs = nixpkgs.legacyPackages.${system};

            on = opam-nix.lib.${system};

            scope = on.buildDuneProject { } package src { 
                ocaml-base-compiler = "*"; 
                dream = "*";
                reason = "*";
                tyxml-jsx = "*";
                fuzzy_match = "*";
                omd = "*";
            };

            overlay = final: prev: {
                ${package} = prev.${package}.overrideAttrs (oa: {
                    buildInputs = oa.buildInputs ++ [ 
                        final.dream 
                        final.reason
                        final.tyxml-jsx
                        final.fuzzy_match
                        final.omd
                    ];
                    buildPhase = "dune build --release"; 
                    postInstall = ''
                        cp -rf $src/public $out/public
                        cp -rf $src/blogs $out/blogs
                    '';
                });
            };

            legacyPackages = scope.overrideScope' overlay;

            derivation = self.legacyPackages.${system}.${package};
        in {
            inherit legacyPackages;

            packages.default = derivation;

            packages.docker = pkgs.callPackage ./nix/docker.nix {
                inherit pkgs package derivation;
            };

            devShells.default = pkgs.callPackage ./nix/shell.nix {
                inherit pkgs;
            };
        }
    );
}
