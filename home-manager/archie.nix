{ pkgs, lib, ... }:

{
  imports = [
    ./git.nix
  ];

  home.file.".background-image" = {
    enable = true;
    source = ../programs/desktop/.background-image;
  };

  home.file.".lock-image" = {
    enable = true;
    source = ../programs/desktop/.lock-image;
  };

  home.username = "archie";
  home.homeDirectory = "/home/archie";
  home.stateVersion = "25.11";


  xdg.mimeApps.enable = true;
}
