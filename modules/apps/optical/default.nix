{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    dvdbackup
    handbrake
    kdePackages.k3b

  ];

  users.users.${username}.extraGroups = [ "cdrom" ];
}
