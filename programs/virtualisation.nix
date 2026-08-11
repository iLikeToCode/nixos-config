{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        qemu
    ];

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
