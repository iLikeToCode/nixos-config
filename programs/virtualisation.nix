{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        qemu_full
        virtiofsd
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
