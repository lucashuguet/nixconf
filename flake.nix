{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
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
      url = "github:nix-community/home-manager/release-25.05";
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

    dwm.url = "github:lucashuguet/dwm";
    st.url = "github:lucashuguet/st";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        "rog" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            DM = "sddm";
            DE = [ "hyprland" "dwm" "gnome" ];
            apps = [
              "games" "latex" "ledger" "mangal" "mpd" "thunderbird" "koreader" "anki" "filezilla"
            ];
            extra-browsers = [ "firefox" "qutebrowser" ];
            username = "astrogoat";
            hostname = "rog";
          } // inputs;
          modules = [
            ./.
            ./modules/hardware/nvidia
            ./modules/apps/sideloader
	    ./modules/apps/emacs
            ./modules/apps/virt
            ./modules/core/cups
            ./modules/code
            ./sh
          ];
        };

        "natnix" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
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

	"t470" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            DM = "sddm";
            DE = [ "hyprland" "dwm" "gnome" ];
            extra-browsers = [ "firefox" ];
            apps = [ "games" "thunderbird" "filezilla" "mpd" ];
            username = "astrogoat";
            hostname = "t470";
          } // inputs;
          modules = [
            ./.
	    ./modules/apps/emacs
            ./modules/apps/virt
	    ./modules/code
	    ./sh
          ];
        };
      };
    };
}
