{
  flake.nixosModules.koreader = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ koreader ];
  };
}
