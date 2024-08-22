{ pkgs, unstable, ... }:
{
  fonts = {
    packages = (with unstable; [
      (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    ])

    ++

    (with pkgs; [ noto-fonts noto-fonts-cjk noto-fonts-emoji ]);

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "FantasqueSansM Nerd Font" ];
    };
  };
}
