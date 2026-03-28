{
  pkgs,
  lib,
  config,
  ...
}:

let
  mod = "Mod4";
in
{
  programs.i3blocks = {
    enable = true;
    bars = {
      top = {
        battery = {
          interval = 1;
          command = ''echo "Battery: $(acpi -b | grep -P -o '[0-9]+(?=%)')%"'';
        };
        disk = {
          interval = 1;
          command = ''echo "Disk: $(df -h / | grep / | awk '{print $5}')"'';
        };
        cpu = {
          interval = 1;
          command = ''echo "CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{printf "%.1f%%\n", $2 + $4}')"'';
        };
        memory = {
          interval = 1;
          command = ''echo "Memory: $(free -h | grep Mem | awk '{print $3}')"'';
        };
        volume = {
          interval = 1;
          command = ''pactl get-sink-volume @DEFAULT_SINK@ | awk '{print "Volume: " $5}' | head -n1'';
        };
        brightness = {
          interval = 1;
          command = ''echo "Brightness: $(brightnessctl g) / $(brightnessctl m)"'';
        };
        user = {
          interval = "persistent";
          command = ''echo "User: $(whoami)"'';
        };
        time_date = {
          interval = 1;
          command = ''date +" %a, %d %b - %H:%M:%S"'';
        };
      };
    };
  };
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;
      fonts = {
        names = [ "FiraCode" ];
        size = 10.0;
      };
      keybindings = lib.mkOptionDefault {
        # Basic Keybinds
        "${mod}+d" = "exec --no-startup-id rofi -show drun";
        "${mod}+shift+d" = "exec --no-startup-id rofi -show window";

        "${mod}+Shift+x" = "exec --no-startup-id i3lock-fancy";
        "${mod}+Return" = "exec xfce4-terminal";

        # Focus
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus down";
        "${mod}+semicolon" = "focus right";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move down";
        "${mod}+Shift+semicolon" = "move right";
        
        # Audio
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume 0 -5%";

        # Screen Brightness
        "XF86MonBrightnessUp" = "exec brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
      };
      bars = [
        {
          position = "top";
          statusCommand = "i3blocks -c $HOME/.config/i3blocks/top";
        }
      ];
    };
    extraConfig = ''
      exec --no-startup-id xset s 300 10
      exec --no-startup-id xset dpms 300 300 300
      exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock-fancy
      exec --no-startup-id gnome-keyring-daemon --start --components=ssh,secrets,pkcs11
      exec_always --no-startup-id autorandr --change
      exec --no-startup-id nm-applet
    '';
  };
}
