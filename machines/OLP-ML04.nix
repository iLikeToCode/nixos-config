{ pkgs, lib, ... }:
{
  imports = [
    ./archie.nix
  ];

  system.autoUpgrade.flake = lib.mkForce "git+https://github.com/iLikeToCode/nixos-config#olp-ml04";

  networking.hostName = "OLP-ML04";
}
