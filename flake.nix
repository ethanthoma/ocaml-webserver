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
                embedded_ocaml_templates = "*";
            };

            overlay = final: prev: {
                ${package} = prev.${package}.overrideAttrs (oa: {
                    buildInputs = oa.buildInputs ++ [ 
                        final.opium 
                        final.embedded_ocaml_templates
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
