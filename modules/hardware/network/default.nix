{ pkgs, hostname, username, ... }:
{
  imports = [
    ./avahi
    ./openvpn
    ./wireguard
  ];

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

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };
}
