{
  flake.nixosModules.openvpn = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ openvpn ];

    networking.networkmanager.plugins = with pkgs; [
      networkmanager-openvpn
    ];
  };
}
