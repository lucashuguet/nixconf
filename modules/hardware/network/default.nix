{ self, ... }: {
  flake.nixosModules.network = { pkgs, username, hostname, ... }: {
    imports = with self.nixosModules; [
      avahi
      openvpn
      wireguard
    ];

    environment.systemPackages = with pkgs; [ networkmanagerapplet ];

    networking = {
      hostName = hostname;
      networkmanager = {
        enable = true;
      };
    };

    users.users.${username} = {
      extraGroups = [ "networkmanager" ];
    };
  };
}
