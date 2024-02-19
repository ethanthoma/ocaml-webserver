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
                fromImage = pkgs.dockerTools.pullImage {
                    imageName = "alpine";
                    imageDigest = "sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b";
                    sha256 = "0h4k892b3izv6ypk3w07z96asmpr987cmbcianajhdk0kz4z62my";
                    finalImageName = "alpine";
                    finalImageTag = "3.19.1";
                };
                copyToRoot = pkgs.buildEnv {
                    name = "webserver";
                    paths = [
                        default
                        pkgs.coreutils
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
