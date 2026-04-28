{ self, ... }: {
  flake.nixosModules.study = { ... }: {
    imports = with self.nixosModules; [
      anki
      maths
    ];
  };
}
