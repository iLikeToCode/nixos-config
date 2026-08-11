{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        qemu
    ];

    networking.firewall.allowedUDPPorts = [ 53 67 68 ];

    users.users.archie.extraGroups = [ "incus-admin" "docker" ];

    virtualisation = {
        spiceUSBRedirection.enable = true;
        docker.enable = true;
        incus = {
            enable = true;
            ui.enable = true;
        };
    };
}
