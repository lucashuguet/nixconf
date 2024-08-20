{ pkgs, username, ... }:
{
  imports = [ ./nh ];

  system.stateVersion = "24.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    users.${username} = {
      home.stateVersion = "24.05";
      nixpkgs.config.allowUnfree = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
