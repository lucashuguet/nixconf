{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ mpv ];
    home.file = {
      ".config/mpv" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
