{ self, ... }: {
  flake.nixosModules.study = { pkgs, ... }: {
    imports = with self.nixosModules; [ typst ];
    environment.systemPackages = with pkgs; [ anki ];
  };
}
