{
  flake.nixosModules.firewall = {
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 21 80 4002 ];
    };
  };
}
