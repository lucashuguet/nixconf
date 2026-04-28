{ self, ... }: {
  flake.nixosModules.core = { pkgs, ... }: {
    imports = with self.nixosModules; [
      boot
      filesystems
      locale
      nix
      security
      terminal
      xorg
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
      usbutils
      vimv
      xxd
      yt-dlp
    ];
  };
}
