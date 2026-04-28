{ inputs, self, ... }: {
  flake.nixosModules.common = { pkgs, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    imports = (with inputs; [
      home-manager.nixosModules.home-manager
    ]) ++ (with self.nixosModules; [
      core hardware sh users
    ]);

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [
      (import inputs.rust-overlay)
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable { inherit system; };
      })
    ];
  };
}
