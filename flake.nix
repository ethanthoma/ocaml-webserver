{
    inputs = {
        opam-nix.url = "github:tweag/opam-nix";
        flake-utils.url = "github:numtide/flake-utils";
        nixpkgs.follows = "opam-nix/nixpkgs";
    };

    outputs = { self, flake-utils, opam-nix, nixpkgs }:
    let 
        package = "webserver";
    in flake-utils.lib.eachDefaultSystem (system:
        let
            pkgs = nixpkgs.legacyPackages.${system};

            on = opam-nix.lib.${system};

            scope = on.buildDuneProject { } package ./. { 
                ocaml-base-compiler = "*"; 
                opium = "*";
                reason = "*";
                tyxml-jsx = "*";
                easy_logging = "*";
                fuzzy_match = "*";
            };

            overlay = final: prev: {
                ${package} = prev.${package}.overrideAttrs (oa: {
                    buildInputs = oa.buildInputs ++ [ 
                        final.opium 
                        final.reason
                        final.tyxml-jsx
                        final.easy_logging
                        final.fuzzy_match
                    ];
                    buildPhase = "dune build --release"; 
                });
            };
        in {
            legacyPackages = scope.overrideScope' overlay;
            packages.default = self.legacyPackages.${system}.${package};
        }
    );
}
