{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      unstable.nerd-fonts.fantasque-sans-mono
      noto-fonts noto-fonts-cjk-sans noto-fonts-emoji
    ];

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "FantasqueSansM Nerd Font" ];
    };
  };
}
