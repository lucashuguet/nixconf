{
  flake.nixosModules.nodeLang = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ nodejs ];
  };
}
