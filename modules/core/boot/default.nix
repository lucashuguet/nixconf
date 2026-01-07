{
  imports = [
    ./grub
    ./plymouth
  ];

  boot.initrd.systemd.enable = true;
}
