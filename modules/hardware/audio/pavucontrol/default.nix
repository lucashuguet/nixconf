{
  flake.nixosModules.pavucontrol = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ pavucontrol ];
  };
}
