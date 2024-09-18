{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-zathura.url = "github:nixos/nixpkgs/336eda0d07dc5e2be1f923990ad9fdb6bc8e28e3"; # zathura 5.2 (fix cbz being cropped)

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      nixosConfigurations = {
        "rog" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system unstable;
            DE = [ "hyprland" "gnome" ];
            extra-browsers = [ "qutebrowser" ];
            username = "astrogoat";
            hostname = "rog";
          } // inputs;
          modules = [
            ./.
            ./modules/hardware/nvidia
            ./modules/games
            ./modules/cups
            ./modules/code
            ./modules/apps/ledger
            ./modules/apps/mangal
            ./modules/virt/docker
          ];
        };

        "natnix" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system unstable;
            DE = [ "gnome" ];
            extra-browsers = [];
            username = "natminer";
            hostname = "natnix";
          } // inputs;
          modules = [
            ./.
            ./modules/hardware/nvidia
            ./modules/hyprland/rofi
            ./modules/virt/docker
          ];
        };
      };
    };
}
