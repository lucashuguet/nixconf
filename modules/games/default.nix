{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    prismlauncher
    jdk8 jdk17 jdk21
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
