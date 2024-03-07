{ pkgs, package, derivation }:

let 
    baseImage = pkgs.dockerTools.pullImage {
        imageName = "ghcr.io/tursodatabase/libsql-server";
        imageDigest = "sha256:253207a90cdae061ce8702625011c62ff6b5725119199b2d079de06ae8001700";
        sha256 = "8+nYYweux3KKtkip4GMtsZ/TmiYKueFCj3TQrUQ3GVM=";
    };
in pkgs.dockerTools.buildImage {
    name = package;
    tag = "latest";
    created = "now";
    fromImage = baseImage;
    copyToRoot = pkgs.buildEnv {
        name = "webserver";
        paths = [
            derivation
            pkgs.bash
            pkgs.getconf
            pkgs.turso-cli
        ];
        pathsToLink = [ "/bin" "/public" "/blogs" ];
    };
    config = {
        Cmd = [ 
            "${derivation}/bin/${package}"
        ];
        Env = [
            "TURSO_INSTALL_SKIP_SIGNUP=true"
        ];
        ExposedPorts = {
            "3000/tcp" = {};
        };
    };
}
