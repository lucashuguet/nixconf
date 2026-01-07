{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    brasero dvdplusrwtools
  ];
}
