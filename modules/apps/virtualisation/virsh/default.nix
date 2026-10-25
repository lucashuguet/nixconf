{
  flake.nixosModules.virtManager = { pkgs, username, ... }: {
    users.users.${username} = {
      extraGroups = [ "libvirtd" "kvm" ];
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm", MODE="0660"
    '';

    security.pam.loginLimits = [
      { domain = "@kvm"; type = "-"; item = "memlock"; value = "unlimited"; }
    ];

    environment.systemPackages = with pkgs; [ dnsmasq virt-viewer ];
    networking.firewall.trustedInterfaces = [ "virbr0" ];
    programs.virt-manager.enable = true;

    virtualisation.spiceUSBRedirection.enable = true;
    virtualisation.kvmgt.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu.override { smbdSupport = true; };
        vhostUserPackages = with pkgs; [ virtiofsd ];
      };
    };
  };
}
