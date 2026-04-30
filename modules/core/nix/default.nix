{ inputs, self, ... }: {
  flake.nixosModules.nix = { pkgs, username, stateVersion, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
  in {
    imports = with self.nixosModules; [ nh ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [
      (import inputs.rust-overlay)
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable { inherit system; };
      })
    ];

    system = { inherit stateVersion; };
    home-manager.users.${username} = {
      home = { inherit stateVersion; };
    };
  };
}
