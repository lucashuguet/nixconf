{ self, ... }: {
  flake.nixosModules.security = { ... }: {
    imports = with self.nixosModules; [
      firewall gnupg pass pcscd
    ];
  };
}
