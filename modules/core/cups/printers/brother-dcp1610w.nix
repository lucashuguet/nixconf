{ pkgs, ... }:
{
  services.printing.drivers = with pkgs; [
    brlaser
    cups-brother-dcp1610wlpr
  ];
}
