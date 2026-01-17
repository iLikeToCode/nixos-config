{ config, ... }:

{
  imports = [
    ./git.nix
    ./flatpak.nix
  ];

  home.username = "archie";
  home.homeDirectory = "/home/archie";
  home.stateVersion = "25.11";
  home.file.".background-image".source = ./wallpaper.png;
}
