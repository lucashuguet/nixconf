{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.file = {
      ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
    };

    home.packages = with pkgs; [ hyprlock ];
  };
}
