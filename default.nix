{ home-manager, sddm-sugar-candy-nix, ... }:
{
  imports = [
    home-manager.nixosModules.home-manager
    sddm-sugar-candy-nix.nixosModules.default
    ./users
    ./modules
    ./hosts
    ./sh
  ];
}
