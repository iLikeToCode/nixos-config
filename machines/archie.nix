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
    ../programs/firefox.nix
    ../programs/vscode.nix
    ../programs/python.nix
    ../programs/git.nix
    ../programs/zsh.nix
    ../programs/virtualisation.nix
    ../programs/node.nix
    ../programs/networking.nix
    ../programs/desktop.nix
  ];

  system.autoUpgrade = {
    enable = true;
    flake = self.outPath;
    dates = "03:00";
  };

  programs.nh = {
    enable = true;

    clean = {
      enable = true;
      extraArgs = "--keep 5";
    };
  };

  users.users.archie = {
    description = "Archie Hurst";
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
