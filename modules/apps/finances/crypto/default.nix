{ self, ... }: {
  flake.nixosModules.crypto = { pkgs, ... }: {
    imports = with self.nixosModules; [ ledger ];
    environment.systemPackages = with pkgs; [ unstable.monero-gui ];
  };
}
