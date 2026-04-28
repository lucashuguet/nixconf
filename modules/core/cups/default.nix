{ self, ... }: {
  flake.nixosModules.cups = { ... }: {
    imports = with self.nixosModules; [
      brotherDcp1610w brotherHl1210w
    ];

    services.printing.enable = true;
  };
}
