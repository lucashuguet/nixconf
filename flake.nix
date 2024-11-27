{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-zathura.url = "github:nixos/nixpkgs/336eda0d07dc5e2be1f923990ad9fdb6bc8e28e3"; # zathura 5.2 (fix cbz being cropped)

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, rust-overlay, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (import rust-overlay) ];
        config.allowUnfree = true;
      };
      unstable = import nixpkgs-unstable { inherit system; };
    in {
      nixosConfigurations = {
        "rog" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit pkgs system unstable;
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
            ./modules/virt/virsh
            ./modules/maths
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
            ./modules/virt/docker
          ];
        };
      };

      devShells.${system}.default = pkgs.mkShell rec {
        nativeBuildInputs = with pkgs; [
          pkg-config
        ];
        buildInputs = with pkgs; [
          udev openssl alsa-lib vulkan-loader
          xorg.libX11 xorg.libXcursor xorg.libXi xorg.libXrandr # To use the x11 feature
          libxkbcommon wayland # To use the wayland feature
          sqlite
        ];
        LD_LIBRARY_PATH = nixpkgs.lib.makeLibraryPath buildInputs;
      };
    };
}
