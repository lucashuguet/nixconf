{ pkgs, ... }:
{
  services.printing.drivers = with pkgs; [ cups-brother-hl1210w ];
}
