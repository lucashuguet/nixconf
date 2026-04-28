{ self, ... }: {
  flake.nixosModules.virtualisation = { ... }: {
    imports = with self.nixosModules; [
      docker
      virtManager
    ];
  };
}
