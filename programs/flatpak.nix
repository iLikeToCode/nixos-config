{ pkgs, ... }:

{
    services.flatpak.enable = true;

    system.activationScripts.flatpakFlathub = {
    text = ''
        ${pkgs.flatpak}/bin/flatpak \
        remote-add --if-not-exists \
        flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
    };

    systemd.services.flatpak-install = {
        description = "Install system Flatpaks";
        wantedBy = [ "multi-user.target" ];
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];

        path = [ pkgs.flatpak ];

        script = ''
            flatpak update -y --system

            flatpak install -y --system \
            flathub \
            org.vinegarhq.Sober
        '';
    };
}