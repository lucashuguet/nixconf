{
  flake.nixosModules.moneroGui = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ unstable.monero-gui ];
  };
}
