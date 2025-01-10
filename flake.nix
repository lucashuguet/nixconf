{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dwm.url = "github:lucashuguet/dwm";
    st.url = "github:lucashuguet/st";

    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { nixpkgs, nixpkgs-unstable, rust-overlay, ... }@inputs:
    let
      system = "x86_64-linux";
      unstable = import nixpkgs-unstable { inherit system; };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
	  (import rust-overlay)
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
            ./modules/containers
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

      devShells.${system}.default = pkgs.mkShell rec {
        nativeBuildInputs = with pkgs; [
          pkg-config
        ];
        buildInputs = with pkgs; [
          udev openssl alsa-lib vulkan-loader
          xorg.libX11 xorg.libXcursor xorg.libXi xorg.libXrandr # To use the x11 feature
          libxkbcommon wayland # To use the wayland feature
          sqlite
	  cmake
        ];
        LD_LIBRARY_PATH = nixpkgs.lib.makeLibraryPath buildInputs;
      };
    };
}
