{ lib, ... }:
{
  imports = [
    ./archie.nix
  ];

  system.autoUpgrade.flake = lib.mkForce "git+https://github.com/iLikeToCode/nixos-config#ah-hpl";

  networking.hostName = "AH-HPL";
}
