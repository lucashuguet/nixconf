{ pkgs, hostname, username, ... }:
{
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
