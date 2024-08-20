{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    zathura.url = "github:nixos/nixpkgs/5a83f6f984f387d47373f6f0c43b97a64e7755c0"; # zathura 5.2

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = inputs.unstable.legacyPackages.${system};
    in {
      nixosConfigurations = {
        "rog" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system pkgs-unstable;
            DE = [ "hyprland" "gnome" ];
            username = "astrogoat";
            hostname = "rog";
          } // inputs;
          modules = [
            ./.
            ./modules/hardware/nvidia
            ./modules/games
            ./modules/cups
            ./modules/code
            ./modules/apps/ai
            ./modules/apps/ledger
            ./modules/apps/mangal
            ./modules/virt
          ];
        };
      };
    };
}
