{
  perSystem = { pkgs, ... }: {
    packages.iloader = pkgs.callPackage ../../../../pkgs/iloader {};
  };

  flake.nixosModules.iloader = { pkgs, ... }: {
    environment.systemPackages = [ (pkgs.callPackage ../../../../pkgs/iloader {}) ];
  };
}
