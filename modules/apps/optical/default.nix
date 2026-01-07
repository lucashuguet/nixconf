{ username, ... }:
{
  imports = [
    ./brasero
    ./dvdbackup
    ./handbrake
  ];

  users.users.${username}.extraGroups = [ "cdrom" ];
}
