{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    zathura.url = "github:nixos/nixpkgs/5a83f6f984f387d47373f6f0c43b97a64e7755c0"; # zathura 5.2

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, zathura, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = unstable.legacyPackages.${system};
      pkgs-zathura = zathura.legacyPackages.${system};

      home-manager = inputs.home-manager;
    in {
      nixosConfigurations."nixos" = lib.nixosSystem {
        inherit system;
        specialArgs = {
	        # inherit inputs;
	        inherit pkgs-unstable;
          inherit pkgs-zathura;
	      };
        modules = [ ./configuration.nix ];
      };

      homeConfigurations."astrogoat@nixos" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	      modules = [ ./home.nix ];
	      extraSpecialArgs = {
          inherit pkgs-unstable;
	      };
      };
    };
}
