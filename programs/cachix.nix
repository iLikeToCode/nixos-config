{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    cachix
  ];
  nix = {
    settings = {
      substituters = [
        "https://iliketocode.cachix.org"
      ];
      trusted-public-keys = [
        "iliketocode.cachix.org-1:yNcYC972e1mCXFWsQsEsyYh1hPiRNUIeUkOlnBk8xLE="
      ];
    };
  };
}