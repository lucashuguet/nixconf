{
  flake.nixosModules.gimp = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ gimp ];
  };
}
