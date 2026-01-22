{ pkgs, lib, ... }:
{
  imports = [
    ./archie.nix
  ];

  system.autoUpgrade.flake = lib.mkForce "git+https://github.com/iLikeToCode/nixos-config#ah-w";

  environment.systemPackages = with pkgs; [
    makemkv
  ];

  networking.hostName = "AH-W";
}
