{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [ picom ];
  home-manager.users.${username} = {
    home.file = {
      ".config/picom/picom.conf".source = ./picom.conf;
    };
  };
}
