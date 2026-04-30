{ inputs, self, ... }: {
  flake.nixosModules.common = { ... }: {
    imports = (with inputs; [
      home-manager.nixosModules.home-manager
    ]) ++ (with self.nixosModules; [
      core hardware sh users
    ]);
  };
}
