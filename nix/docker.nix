{ pkgs, package, derivation }:

pkgs.dockerTools.buildImage {
    name = package;
    tag = "latest";
    created = "now";
    copyToRoot = pkgs.buildEnv {
        name = "webserver";
        paths = [
            derivation
            pkgs.bash
            pkgs.getconf
        ];
        pathsToLink = [ "/bin" "/public" "/blogs" ];
    };
    config = {
        Cmd = [ 
            "${derivation}/bin/${package}"
        ];
        ExposedPorts = {
            "3000/tcp" = {};
        };
    };
}
