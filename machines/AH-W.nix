{ lib, ... }:
{
  imports = [
    ./archie.nix
  ];

  system.autoUpgrade.flake = lib.mkForce "git+https://github.com/iLikeToCode/nixos-config#ah-w";
  networking.firewall.allowedTCPPorts = [ 443 3000 8080 8081 ];

  networking.hostName = "AH-W";
}
