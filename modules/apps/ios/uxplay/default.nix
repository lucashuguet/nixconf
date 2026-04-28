{
  flake.nixosModules.uxplay = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ uxplay ];

    networking.firewall.allowedTCPPorts = [ 7000 7001 7100 ];
    networking.firewall.allowedUDPPorts = [ 6000 6001 7011 ];
  };
}
