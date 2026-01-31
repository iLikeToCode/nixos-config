{ pkgs, webots, ... }:
{
    environment.systemPackages = [
        webots.packages.x86_64-linux.default
    ];
}