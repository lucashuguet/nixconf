{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      librewolf chromium qutebrowser
    ];

    home.file = {
      ".config/qutebrowser/config.py".source = ./config.py;
    };
  };
}
