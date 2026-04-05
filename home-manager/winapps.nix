{ config, pkgs, lib, ... }:

{
  home.file.".config/winapps/compose.yaml" = {
    enable = true;
    source = ./winapps-compose.yaml
  };
}
