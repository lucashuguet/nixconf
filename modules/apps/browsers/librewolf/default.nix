{
  flake.nixosModules.librewolf = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ librewolf ];
  };
}
