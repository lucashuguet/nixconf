{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages =
      (with pkgs; [ rofi-wayland pywal ])
      ++
      [
        (pkgs.writeScriptBin "rofisink" (builtins.readFile ../../../sh/rofisink.py))
        (pkgs.writeScriptBin "rofidrives" (builtins.readFile ../../../sh/rofidrives.py))
        (pkgs.writeScriptBin "rofinmcli" (builtins.readFile ../../../sh/rofinmcli.py))
        (pkgs.writeScriptBin "rofitheme" (builtins.readFile ../../../sh/rofitheme.sh))
        (pkgs.writeScriptBin "screenshot" (builtins.readFile ../../../sh/screenshot.sh))
        (pkgs.writeScriptBin "aurastatic" ''
      asusctl led-mode static -c $(cat ~/.config/colors/aura.txt)
    '')
        (pkgs.writeScriptBin "em" "emacsclient -nc $@")
      ];

    home.file = {
      ".config/rofi/config.rasi".source = ./config.rasi;
      ".config/rofi/theme.rasi".source = ./theme.rasi;
    };
  };
}
