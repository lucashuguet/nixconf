{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris wineWowPackages.stable wineWowPackages.waylandFull winetricks
    prismlauncher
    jdk8 jdk17 jdk21
    mangohud
  ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    gamescopeSession.enable = true;
  };

  hardware.xone.enable = true;
}
