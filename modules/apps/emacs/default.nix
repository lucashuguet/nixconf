{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ emacs ];
    services.emacs.enable = true;
  };
}
