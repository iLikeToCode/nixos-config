{ codex-cli-nix, pkgs, ... }:
{
    environment.systemPackages = [
        codex-cli-nix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    nix.settings = {
        substituters = [ "https://codex-cli.cachix.org" ];
        trusted-public-keys = [ "codex-cli.cachix.org-1:1Br3H1hHoRYG22n//cGKJOk3cQXgYobUel6O8DgSing=" ];
    };
}