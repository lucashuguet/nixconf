{ self, ... }: {
  flake.nixosModules.filesystems = { ... }: {
    imports = with self.nixosModules; [
      btrfs ntfs
    ];
  };
}
