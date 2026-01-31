{ pkgs, webots, ... }:
{
    environment.systemPackages = with pkgs [
        webots.packages.x86_64-linux.default
    ];
}