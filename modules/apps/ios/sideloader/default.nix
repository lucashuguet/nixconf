{
  perSystem = { pkgs, ... }: {
    packages.sideloader = pkgs.callPackage ../../../../pkgs/sideloader {};
  };

  flake.nixosModules.sideloader = { pkgs, ... }: {
    environment.systemPackages = [ (pkgs.callPackage ../../../../pkgs/sideloader {}) ];
  };
}
