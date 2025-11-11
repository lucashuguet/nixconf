{ pkgs, hostname, username, ... }:
{
  environment.systemPackages = with pkgs; [ networkmanagerapplet openvpn wireguard-tools ];

  networking = {
    hostName = hostname;
    wireguard.enable = true;
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
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
