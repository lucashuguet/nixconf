{
  flake.nixosModules.latex = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ texliveFull ];
  };
}
