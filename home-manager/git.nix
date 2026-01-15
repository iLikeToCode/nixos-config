{ config, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name  = config.home.username;
      user.email = "archie@archiesbytes.xyz";
    };
  };
}
