{
  flake.nixosModules.zoxide = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ zoxide ];
  };
}
