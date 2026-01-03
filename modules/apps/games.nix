{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris wineWowPackages.stable wineWowPackages.waylandFull winetricks
    prismlauncher
    jdk8 jdk17 jdk21
    mangohud
    retroarch-assets
    (retroarch.withCores (
      cores: with cores; [
        fceumm # nes
        gambatte # gb / gbc
        gpsp # gba
        libretro.beetle-psx-hw # psx
        libretro.dolphin # wii
        libretro.dosbox-pure # dos
        melonds # ds
        mupen64plus # n64
        snes9x   # snes
      ]
    ))
  ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
  };

  hardware.xone.enable = true;
}
