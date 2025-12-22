{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    brasero
    dvdbackup
    handbrake
    kdePackages.k3b
  ];

  users.users.${username}.extraGroups = [ "cdrom" ];
}
