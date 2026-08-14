{
  flake.nixosModules.steam = {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
    };

    environment.sessionVariables.PROTON_ENABLE_WAYLAND = 1;
  };
}
