{
  description = "NixOS config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";

    nixos-06cb-009a-fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=25.05";

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
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

    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { flake-parts, import-tree, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = with inputs; [
        disko.flakeModules.default
        home-manager.flakeModules.home-manager
        (import-tree ./hosts)
        (import-tree ./modules)
        (import-tree ./secrets)
        (import-tree ./sh)
        (import-tree ./users)
      ];

      systems = [ "x86_64-linux" ];
    };
}
