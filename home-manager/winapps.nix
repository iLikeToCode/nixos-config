{ config, pkgs, lib, ... }:

{
  home.file.".config/winapps/compose.yaml" = {
    enable = true;
    source = ./winapps-compose.yaml
  };

  home.file.".config/winapps/winapps.conf" = {
    enable = true;
    source = ./winapps.conf
  };
}
