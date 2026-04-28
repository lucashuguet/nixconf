{
  flake.nixosModules.sqliteLang = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ sqlite ];
  };
}
