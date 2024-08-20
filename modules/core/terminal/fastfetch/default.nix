{ pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [ fastfetch ];
  home-manager.users.${username} = {
    home.file = {
      ".config/fastfetch/config.jsonc".source = ./config.jsonc;
    };
  };
}
