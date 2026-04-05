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
      terminal = "xfce4-terminal";
      assigns = {
        "1" = [ { class = "Firefox"; } ];
        "2" = [ { class = "Xfce4-terminal"; } ];
        "3" = [ { class = "Code"; } ];
        "11" = [ { class = "PrismLauncher"; } ];
        "12" = [ { class = "^Minecraft"; } ];
        "17" = [ { class = "Spotify"; } ];
        "18" = [ { class = "Slack"; } ];
        "19" = [ { class = "Element"; } ];
        "20" = [ { class = "discord"; } ];
      };
      keybindings = lib.mkOptionDefault {
        # Basic Keybinds
        "${mod}+d" = "exec --no-startup-id rofi -show drun";
        "${mod}+shift+d" = "exec --no-startup-id rofi -show window";
        "${mod}+shift+x" = "exec --no-startup-id i3lock --image $HOME/.lock-image";

        "${mod}+Return" = "exec xfce4-terminal";

        # Screenshots (Flameshot)

        # Win + Shift + S → select to clipboard
        "Mod4+Shift+s" = "exec --no-startup-id flameshot gui -c";

        # Ctrl + Print → select to file (timestamped)
        "Ctrl+Print" = ''exec --no-startup-id flameshot gui -p ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png'';

        # Print → current screen to clipboard
        "Print" = "exec --no-startup-id flameshot screen -c";

        # Shift + Print → current screen to file
        "Shift+Print" = ''exec --no-startup-id flameshot screen -p ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png'';

        # Win + Print → full (all screens) to clipboard
        "Mod4+Print" = "exec --no-startup-id flameshot full -c";

        # Win + Shift + Print → full (all screens) to file
        "Mod4+Shift+Print" = ''exec --no-startup-id flameshot full -p ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png'';

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

        "${mod}+Control+1" = "workspace 11";
        "${mod}+Control+2" = "workspace 12";
        "${mod}+Control+3" = "workspace 13";
        "${mod}+Control+4" = "workspace 14";
        "${mod}+Control+5" = "workspace 15";
        "${mod}+Control+6" = "workspace 16";
        "${mod}+Control+7" = "workspace 17";
        "${mod}+Control+8" = "workspace 18";
        "${mod}+Control+9" = "workspace 19";
        "${mod}+Control+0" = "workspace 20";

        "${mod}+Control+Shift+1" = "move container to workspace 11";
        "${mod}+Control+Shift+2" = "move container to workspace 12";
        "${mod}+Control+Shift+3" = "move container to workspace 13";
        "${mod}+Control+Shift+4" = "move container to workspace 14";
        "${mod}+Control+Shift+5" = "move container to workspace 15";
        "${mod}+Control+Shift+6" = "move container to workspace 16";
        "${mod}+Control+Shift+7" = "move container to workspace 17";
        "${mod}+Control+Shift+8" = "move container to workspace 18";
        "${mod}+Control+Shift+9" = "move container to workspace 19";
        "${mod}+Control+Shift+0" = "move container to workspace 20";
        
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
      
      exec --no-startup-id xss-lock -- i3lock --image $HOME/.lock-image

      exec --no-startup-id gnome-keyring-daemon --start --components=ssh,secrets,pkcs11
      exec_always --no-startup-id autorandr --change
      exec --no-startup-id nm-applet
      exec --no-startup-id mkdir -p ~/Pictures/Screenshots
      exec --no-startup-id flameshot

      exec --no-startup-id i3-msg 'workspace 1'
    '';
  };
}
