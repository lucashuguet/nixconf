{ disko, home-manager, sddm-sugar-candy-nix, sops-nix, ... }:
{
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
}
