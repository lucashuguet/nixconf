{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    dvdbackup
  ];
}
