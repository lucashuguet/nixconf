{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nixos-06cb-009a-fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=25.05";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
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
            displayManager = "greetd";
            windowManager = [ "hyprland" "dwm" "gnome" ];
            extraBrowsers = [ "firefox" "qutebrowser" ];
            username = "astrogoat";
            hostname = "rog";
          } // inputs;
          modules = [
            ./.
            ./modules/apps/crypto
            ./modules/apps/emacs
            ./modules/apps/filezilla
            ./modules/apps/games
            ./modules/apps/games/prismlauncher
            ./modules/apps/games/retroarch
            ./modules/apps/games/steam
            ./modules/apps/koreader
            ./modules/apps/mpd
            ./modules/apps/ios/sideloader
            ./modules/apps/study
            ./modules/apps/study/maths
            ./modules/apps/thunderbird
            ./modules/apps/virt
            ./modules/code
            ./modules/core/cups
            ./modules/hardware/nvidia
            ./sh
          ];
        };

        "natnix" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            displayManager = "greetd";
            windowManager = [ "gnome" ];
            extraBrowsers = [];
            username = "natminer";
            hostname = "natnix";
          } // inputs;
          modules = [
            ./.
            ./modules/apps/virt/docker
            ./modules/hardware/nvidia
          ];
        };

        "t470" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            displayManager = "greetd";
            windowManager = [ "hyprland" "dwm" "gnome" ];
            extraBrowsers = [ "firefox" ];
            username = "astrogoat";
            hostname = "t470";
          } // inputs;
          modules = [
            ./.
            ./modules/apps/crypto
            ./modules/apps/emacs
            ./modules/apps/filezilla
            ./modules/apps/games
            ./modules/apps/games/prismlauncher
            ./modules/apps/games/retroarch
            ./modules/apps/games/steam
            ./modules/apps/mpd
            ./modules/apps/optical
            ./modules/apps/study/maths/typst
            ./modules/apps/thunderbird
            ./modules/apps/virt
            ./modules/code
            ./modules/core/cups
            ./sh
          ];
        };

        "t480" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            displayManager = "greetd";
            windowManager = [ "hyprland" "dwm" "gnome" ];
            extraBrowsers = [ "firefox" ];
            username = "astrogoat";
            hostname = "t480";
          } // inputs;
          modules = [
            ./.
            ./modules/apps/crypto
            ./modules/apps/emacs
            ./modules/apps/filezilla
            ./modules/apps/games
            ./modules/apps/games/prismlauncher
            ./modules/apps/games/retroarch
            ./modules/apps/games/steam
            ./modules/apps/ios/impactor
            ./modules/apps/ios/localsend
            ./modules/apps/ios/uxplay
            ./modules/apps/mpd
            ./modules/apps/optical
            ./modules/apps/study/maths/typst
            ./modules/apps/thunderbird
            ./modules/apps/virt
            ./modules/code
            ./modules/core/cups
            ./sh
          ];
        };
      };
    };
}
