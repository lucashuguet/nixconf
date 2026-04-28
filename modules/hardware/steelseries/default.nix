{ self, ... }: {
  flake.nixosModules.steelseries = { ... }: {
    imports = with self.nixosModules; [ aerox3 ];
  };
}
