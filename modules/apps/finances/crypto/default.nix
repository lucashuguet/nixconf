{ self, ... }: {
  flake.nixosModules.crypto = { ... }: {
    imports = with self.nixosModules; [
      ledger
      moneroGui
    ];
  };
}
