{
  flake.nixosModules.thunar = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ thunar ];
    services.gvfs.enable = true;
    services.tumbler.enable = true;
  };
}
