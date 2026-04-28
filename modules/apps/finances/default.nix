{ self, ... }: {
  flake.nixosModules.finances = { ... }: {
    imports = with self.nixosModules; [
      beancount
      crypto
    ];
  };
}
