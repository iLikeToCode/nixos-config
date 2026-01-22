{ pkgs, lib, ... }:
{
  imports = [
    ./archie.nix
  ];

  system.autoUpgrade.flake = lib.mkForce "git+https://github.com/iLikeToCode/nixos-config#olp-ml04";
  environment.systemPackages = lib.mkForce (
    builtins.filter
      (pkg: pkg != pkgs.discord)
      environment.systemPackages
  ); 

  networking.hostName = "OLP-ML04";
}
