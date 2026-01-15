{ config, ... }:

{
  imports = [
    ./git.nix
  ];

  home.username = "archie";
  home.homeDirectory = "/home/archie";
  home.stateVersion = "25.11";
}
