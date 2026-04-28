{
  perSystem = { pkgs, ... }: {
    packages.impactor = pkgs.callPackage ../../../../pkgs/impactor {};
  };

  flake.nixosModules.impactor = { pkgs, ... }: {
    environment.systemPackages = [ (pkgs.callPackage ../../../../pkgs/impactor {}) ];
  };
}
