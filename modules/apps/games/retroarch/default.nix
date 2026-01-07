{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
}
