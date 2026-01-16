{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./generic.nix
  ];

  swapDevices =
    [ { device = "/dev/disk/by-label/swap"; }
    ];
}
