{ inputs, self, ... }: {
  flake.nixosModules.nix = { username, ... }: {
    imports = with self.nixosModules; [ nh ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nix.registry = {
      nixpkgs.flake = inputs.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
    };

    home-manager.users.${username} = {
      home.stateVersion = "25.11";
    };
  };
}
