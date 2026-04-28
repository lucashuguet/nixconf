{
  perSystem = { pkgs, ... }: {
    packages.bpytop = pkgs.callPackage ../../../../pkgs/bpytop {};
  };

  flake.nixosModules.bpytop = { pkgs, ... }: {
    environment.systemPackages = [ (pkgs.callPackage ../../../../pkgs/bpytop {}) ];
  };
}
