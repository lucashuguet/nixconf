{
  imports = [ ./grub.nix ];

  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
}
