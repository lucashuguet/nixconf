{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    brasero
    dvdbackup
    handbrake
  ];

  users.users.${username}.extraGroups = [ "cdrom" ];
}
