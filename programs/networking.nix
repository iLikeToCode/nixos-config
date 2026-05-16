{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    openvpn
  ];
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openvpn
    ];
    dns = "systemd-resolved";
  };
  services.tailscale.enable = true;
  services.resolved.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  networking.firewall.checkReversePath = "loose";
  networking.nftables.enable = true;
}
