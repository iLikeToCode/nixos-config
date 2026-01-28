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
            qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
        };
        spiceUSBRedirection.enable = true;
        docker.enable = true;
    };
}
