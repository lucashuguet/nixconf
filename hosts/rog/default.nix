{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  # broken screen on 144hz
  boot.kernelParams = [ "video=1920x1080@60" ];
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --rate 60
  '';

  # fix sound
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=asus-zenbook
  '';

  # asus services
  services.asusd.enable = true;
}