{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ rofi-wayland ];

    home.file = {
      ".config/rofi/config.rasi".source = ./config.rasi;
      ".config/rofi/theme.rasi".source = ./theme.rasi;
    };
  };
}
