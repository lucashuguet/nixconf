{
  flake.nixosModules.fonts = { pkgs, ... }: {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.fantasque-sans-mono
        noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji
      ];

      fontDir.enable = true;

      fontconfig.defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "FantasqueSansM Nerd Font" ];
      };
    };
  };
}
