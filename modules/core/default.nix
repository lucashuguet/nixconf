{ pkgs, ... }:
{
  imports = [
    ./boot
    ./filesystems
    ./locale
    ./nix
    ./security
    ./terminal
    ./xorg
  ];

  environment.systemPackages = with pkgs; [
    aria2
    fd
    ffmpeg
    file
    git git-lfs
    imagemagick
    ncdu
    p7zip
    vimv
    xxd
    yt-dlp
  ];
}
