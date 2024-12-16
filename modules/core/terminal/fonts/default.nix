{ pkgs, unstable, ... }:
{
  fonts = {
    packages = (with unstable; [
      nerd-fonts.fantasque-sans-mono
    ])

    ++

    (with pkgs; [ noto-fonts noto-fonts-cjk-sans noto-fonts-emoji]);

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "FantasqueSansM Nerd Font" ];
    };
  };
}
