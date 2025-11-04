# Asus ROG Stix G15 G512LV

{ pkgs, ... }:
{
  imports = [ ./hardware-configuration.nix ./disko-config.nix ];

  # broken screen on 144hz
  boot.kernelParams = [ "video=1920x1080@60" ];
  programs.hyprland.monitor-resolution = "1920x1080@60";
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --rate 60
  '';

  # fix sound
  boot.extraModprobeConfig = ''
    blacklist snd_hda_codec_realtek
  '';

  # asus services
  services.asusd.enable = true;
}
