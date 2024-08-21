{ hostname, username, ... }:
{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
