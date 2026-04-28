{
  flake.nixosModules.thunderbird = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ thunderbird ];
  };
}
