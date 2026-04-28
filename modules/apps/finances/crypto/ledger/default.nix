{
  flake.nixosModules.ledger = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ unstable.ledger-live-desktop ];
    hardware.ledger.enable = true;
  };
}
