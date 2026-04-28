{
  flake.nixosModules.firefox = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ firefox ];
  };
}
