{ config, ... }:

{
  programs.git = {
    enable = true;
    user.name  = config.home.username;
    user.email = "archie@archiesbytes.xyz";
  };
}
