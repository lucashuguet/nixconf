{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    brasero dvdplusrwtools
    dvdbackup
    handbrake
  ];

  users.users.${username}.extraGroups = [ "cdrom" ];
}
