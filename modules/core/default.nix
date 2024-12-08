{ pkgs, ... }:
{
  imports = [
    ./boot/grub
    ./nix
    ./security
    ./terminal
    ./xorg
  ];

  environment.systemPackages = with pkgs; [
    aria ffmpeg imagemagick git git-lfs ncdu p7zip yt-dlp vimv file
  ];
}
