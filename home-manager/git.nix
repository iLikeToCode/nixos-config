{ config, ... }:

{
  programs.git = {
    enable = true;
    userName  = config.home.username;
    userEmail = "archie@archiesbytes.xyz";
  };
}
