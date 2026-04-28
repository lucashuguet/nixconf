{ self, ... }: {
  flake.nixosModules.boot = { ... }: {
    imports = with self.nixosModules; [
      grub plymouth
    ];

    boot.initrd.systemd.enable = true;
  };
}
