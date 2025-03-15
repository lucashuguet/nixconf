{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dwm = {
      url = "github:lucashuguet/dwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    st = {
      url = "github:lucashuguet/st";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-unstable, emacs-overlay, rust-overlay, ... }@inputs:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable { inherit system; };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (import rust-overlay)
          (import emacs-overlay)
          (final: prev: { inherit unstable; })
        ];
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        "rog" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs system;
            DM = "sddm";
            DE = [ "hyprland" "dwm" "gnome" ];
            apps = [
              "games" "latex" "ledger" "mangal" "mpd" "thunderbird"
            ];
            extra-browsers = [ "qutebrowser" ];
            username = "astrogoat";
            hostname = "rog";
          } // inputs;
          modules = [
            ./.
            ./modules/hardware/nvidia
            ./modules/apps/sideloader
            ./modules/apps/virt
            ./modules/core/cups
            ./modules/code
            ./sh
          ];
        };

        "natnix" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs system;
            DM = "sddm";
            DE = [ "gnome" ];
            extra-browsers = [];
            apps = [ "virt/docker" ];
            username = "natminer";
            hostname = "natnix";
          } // inputs;
          modules = [
            ./.
            ./modules/hardware/nvidia
          ];
        };
      };
    };
}
