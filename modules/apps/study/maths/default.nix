{ self, ... }: {
  flake.nixosModules.math = {
    imports = with self.nixosModules; [
      latex
      typst
    ];
  };
}
