{ lib, ... }:
{
  imports = [
    ./archie.nix
  ];

  system.autoUpgrade.flake = lib.mkForce "git+https://github.com/iLikeToCode/nixos-config#olp-ml04";
  environment.systemPackages =
    builtins.filter
      (pkg: pkg != pkgs.discord)
      config.environment.systemPackages;

  networking.hostName = "OLP-ML04";
}
