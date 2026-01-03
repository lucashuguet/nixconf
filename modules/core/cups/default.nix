{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cups-brother-hl1210w
  ];

  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ brlaser ];
}
