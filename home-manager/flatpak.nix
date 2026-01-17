{ pkgs, ... }:

{
    systemd.user.services.flatpak-update = {
        Service = {
            Type = "oneshot";
            script = "${pkgs.flatpak}/bin/flatpak update -y";
        };
    };

        systemd.user.timers.flatpak-update = {
        Timer = {
            OnCalendar = "daily";
            Persistent = true;
        };
        Install.WantedBy = [ "timers.target" ];
    };

    systemd.user.services.flatpak-install = {
        Unit = {
            Description = "Install user Flatpaks";
            After = [ "network-online.target" ];
            Wants = [ "network-online.target" ];
        };

        Service = {
        Type = "oneshot";
        script = ''
            ${pkgs.flatpak}/bin/flatpak update -y || true

            ${pkgs.flatpak}/bin/flatpak install -y \
            flathub \
            org.vinegarhq.Sober
        '';
        };

        Install = {
            WantedBy = [ "default.target" ];
        };
    };
}