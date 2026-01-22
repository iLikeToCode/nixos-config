{ lib, ... }:
{
  imports = [
    ./archie.nix
    ../programs/discord.nix
  ];

  system.autoUpgrade.flake = lib.mkForce "git+https://github.com/iLikeToCode/nixos-config#ah-l";

  networking.hostName = "AH-L";
}
