{
  disko,
  emacs-overlay,
  home-manager,
  nixpkgs-unstable,
  rust-overlay,
  sddm-sugar-candy-nix,
  system,
  sops-nix,
  ...
}:
let
  unstable = import nixpkgs-unstable { inherit system; };
in {
  imports = [
    disko.nixosModules.disko
    home-manager.nixosModules.home-manager
    sddm-sugar-candy-nix.nixosModules.default
    sops-nix.nixosModules.sops
    ./hosts
    ./modules
    ./secrets
    ./users
  ];

  nixpkgs.overlays = [
    (import rust-overlay)
    (import emacs-overlay)
    (final: prev: { inherit unstable; })
  ];

  nixpkgs.config.allowUnfree = true;
}
