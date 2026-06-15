{
  flake.nixosModules.virtManager = { pkgs, username, ... }: {
    users.users.${username} = {
      extraGroups = [ "libvirtd" ];
    };

    environment.systemPackages = with pkgs; [ dnsmasq ];
    networking.firewall.trustedInterfaces = [ "virbr0" ];
    programs.virt-manager.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };
}
