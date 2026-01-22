{ pkgs, lib, ... }:
{
  imports = [
    ./archie.nix
  ];

  system.autoUpgrade.flake = lib.mkForce "git+https://github.com/iLikeToCode/nixos-config#olp-ml04";
  shared.programs.discord.enable = lib.mkForce false;

  networking.hostName = "OLP-ML04";
}
