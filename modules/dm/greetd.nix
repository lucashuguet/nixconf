{ config, ... }:
{
  programs.regreet = {
    enable = true;
    font.name = config.theme.font.name;
    iconTheme.name = config.theme.icon.name;
    theme.name = config.theme.gtk.name;
    settings = {
      background.path = ../../assets/background.png;
      GTK.application_prefer_dark_theme = true;
    };
  };
}
