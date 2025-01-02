{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [ ripgrep ];

  home-manager.users.${username} = {
    home.packages = with pkgs; [ emacs ];
    services.emacs.enable = true;
  };
}
