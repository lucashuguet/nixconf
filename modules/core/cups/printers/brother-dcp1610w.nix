{
  flake.nixosModules.brotherDcp1610w = { pkgs, ... }: {
    services.printing.drivers = with pkgs; [
      brlaser
      cups-brother-dcp1610wlpr
    ];
  };
}
