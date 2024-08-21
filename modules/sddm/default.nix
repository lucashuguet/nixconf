{ lib, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    settings = {
      Theme = {
        CursorTheme = "capitaine-cursors";
        CursorSize = 32;
      };
    };
    sugarCandyNix = {
      enable = true;
      settings = {
        Background = lib.cleanSource ../../assets/background.png;
        FormPosition = "left";
        MainColor = "#99d2e8";
        AccentColor = "#9169B0";
        BackgroundColor = "#99d2e8";
      };
    };
  };
}
