{
  config,
  lib,
  pkgs,
  self,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    acpi
    pulseaudio
    self.packages.${pkgs.stdenv.hostPlatform.system}.feh
    gcr
    autorandr
    kdePackages.polkit-kde-agent-1
    xrandr
    xfce4-terminal
  ];

  services.libinput.touchpad.naturalScrolling = true;

  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr --change"
  '';

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;  # provides pactl compatibility
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  services.xserver = {
    enable = true;

    xkb = {
      layout = "gb";
      variant = "";
    };

    desktopManager = {
      xterm.enable = false;
      #xfce = {
      #  enable = true;
      #  noDesktop = true;
      #  enableXfwm = false;
      #};
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3lock-color
        i3blocks
        self.packages.${pkgs.stdenv.hostPlatform.system}.rofi
        xss-lock
        brightnessctl
        flameshot
        kdePackages.kstatusnotifieritem
      ];
    };
  };
  services.displayManager.defaultSession = "none+i3";

  services.xserver.displayManager.lightdm.enable = true;
  #services.xserver.displayManager.setupCommands = ''
   # ${pkgs.autorandr}/bin/autorandr --load desktop
  #'';
  
  location.provider = "manual";
  location.latitude = 54.0;
  location.longitude = -3.0;
  services.redshift = {
    enable = true;
    brightness = {
      day = "1";
      night = "0.5";
    };
    temperature = {
      day = 5500;
      night = 3700;
    };
  };
}
