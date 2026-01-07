{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris mangohud
    wineWowPackages.stable wineWowPackages.waylandFull winetricks
  ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
}
