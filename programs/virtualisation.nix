{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        qemu_full
    ];
    programs.virt-manager.enable = true;

    virtualisation = {
        libvirtd.enable = true;
        spiceUSBRedirection.enable = true;
        docker.enable = true;
    };

    users.users.archie.extraGroups = [ "docker" ];
}
