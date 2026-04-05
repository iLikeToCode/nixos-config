{ config, pkgs, lib, ... }:

{
  home.file."winapps-compose.yaml" = {
    enable = true;
    source = ./winapps-compose.yaml
  };
}
