{ pkgs, ... }:
{
  imports = [
    ./boot
    ./btrfs.nix
    ./locale.nix
    ./nix
    ./security.nix
    ./terminal
    ./xorg.nix
  ];

  environment.systemPackages = with pkgs; [
    aria ffmpeg imagemagick git git-lfs ncdu p7zip yt-dlp vimv file xxd fd
  ];
}
