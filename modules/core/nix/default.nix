{ nixpkgs, nixpkgs-unstable, username, ... }:
{
  imports = [ ./nh ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    users.${username} = {
      home.stateVersion = "24.05";
    };
  };

  nix.registry = {
    nixpkgs.flake = nixpkgs;
    unstable.flake = nixpkgs-unstable;
  };
}
