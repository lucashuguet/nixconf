{
  flake.nixosModules.steam = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
    };
  };
}
