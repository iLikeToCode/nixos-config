{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  imports = [
    ../hardware/generic.nix
  ];

  system.autoUpgrade = {
    enable = true;
    flake = self.outPath;
    dates = "03:00";
  };

  nix.gc.automatic = true;
  nix.gc.date = "03:00";
  nix.gc.options = "--delete-older-than 3d";

  users.users.archie = {
    description = "Archie Hurst";
    email = "archie@archiesbytes.xyz";
    isNormalUser = true;
    extraGroups = [ "dialout" "networkmanager" "wheel" ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = "nix-command flakes";

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = lib.mkForce "uk";
    useXkbConfig = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    chromium
    bitwarden-desktop
  ];

  system.stateVersion = "25.11";
}
