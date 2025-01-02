{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ waybar ];
    home.file = {
      ".config/waybar/config".source = ./config.json;
      ".config/waybar/style.css".source = ./style.css;
    };
  };
}
