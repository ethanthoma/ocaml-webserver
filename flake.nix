{
    inputs = {
        opam-nix.url = "github:tweag/opam-nix";
        flake-utils.url = "github:numtide/flake-utils";
        nixpkgs.follows = "opam-nix/nixpkgs";
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
                opium = "*";
                reason = "*";
                tyxml-jsx = "*";
                easy_logging = "*";
                fuzzy_match = "*";
                omd = "*";
            };

            overlay = final: prev: {
                ${package} = prev.${package}.overrideAttrs (oa: {
                    buildInputs = oa.buildInputs ++ [ 
                        final.opium 
                        final.reason
                        final.tyxml-jsx
                        final.easy_logging
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

            default = self.legacyPackages.${system}.${package};

            image = pkgs.dockerTools.buildImage {
                name = "webserver";
                tag = "latest";
                created = "now";
                copyToRoot = pkgs.buildEnv {
                    name = "webserver";
                    paths = [
                        default
                        pkgs.bash
                        pkgs.getconf
                    ];
                    pathsToLink = [ "/bin" "/public" "/blogs" ];
                };
                config = {
                    Cmd = [ 
                        "${default}/bin/${package}"
                    ];
                    ExposedPorts = {
                        "3000/tcp" = {};
                    };
                };
            };
        in {
            inherit legacyPackages;
            packages = {
                inherit default;
                docker = image;
            };
            defaultPackage = default;
        }
    );
}
