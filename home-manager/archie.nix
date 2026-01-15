{ account, ... }:

{
  imports = [
    ./git.nix
  ];

  home.username = account.username;
  home.homeDirectory = "/home/${account.username}";
  home.stateVersion = "25.11";
}