{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        qemu_full
    ];
    programs.virt-manager.enable = true;

    networking.nftables.enable = true;
    networking.firewall.trustedInterfaces = [ "incusbr0" ];

    virtualisation = {
        libvirtd = {
            enable = true;
            allowedBridges = [ "incusbr0" ];
            qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
        };
        spiceUSBRedirection.enable = true;
        docker.enable = true;
        incus = {
            enable = true;
            preseed = {
                networks = [
                    {
                        config = {
                            "ipv4.address" = "172.0.50.1/24";
                            "ipv4.nat" = "true";
                        };
                        name = "incusbr0";
                        type = "bridge";
                    }
                ];
                storage_pools = [
                    {
                        config = {
                            source = "/var/lib/incus/storage-pools/default";
                        };
                        driver = "dir";
                        name = "default";
                    }
                ];
            };
        };
    };
}
