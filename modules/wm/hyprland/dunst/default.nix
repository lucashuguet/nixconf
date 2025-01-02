{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ dunst ];
    home.file = {
      ".config/dunst/config.toml".source = ./config.toml;
    };
  };
}
