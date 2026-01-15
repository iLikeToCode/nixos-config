{ pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.hostName = "AH-W";
  services.tailscale.enable = true;
  networking.resolvconf.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.checkReversePath = "loose";
}