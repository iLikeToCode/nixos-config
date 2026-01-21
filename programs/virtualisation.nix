{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        qemu_full
    ];
    programs.virt-manager.enable = true;

    virtualisation = {
        libvirtd = {
            enable = true;
            allowedBridges = [ "nm-bridge" ];
        };
        spiceUSBRedirection.enable = true;
        docker.enable = true;
    };
}
