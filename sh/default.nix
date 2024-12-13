{ pkgs, username, ... }:
{
  imports = [ ../modules/hyprland/rofi ];
  home-manager.users.${username} = {
    home.packages =
      (with pkgs; [ fzf pywal ])
      ++
      [
        (pkgs.writeScriptBin "audiosetup" (builtins.readFile ./audiosetup.sh))
        (pkgs.writeScriptBin "createcbz" (builtins.readFile ./createcbz.py))
        (pkgs.writeScriptBin "gamemode" (builtins.readFile ./gamemode.sh))
	(pkgs.writeScriptBin "roficompose" (builtins.readFile ./roficompose.py))
        (pkgs.writeScriptBin "rofidrives" (builtins.readFile ./rofidrives.py))
        (pkgs.writeScriptBin "rofinmcli" (builtins.readFile ./rofinmcli.py))
        (pkgs.writeScriptBin "rofipass" (builtins.readFile ./rofipass.sh))
        (pkgs.writeScriptBin "rofishutdown" (builtins.readFile ./rofishutdown.py))
        (pkgs.writeScriptBin "rofisink" (builtins.readFile ./rofisink.py))
        (pkgs.writeScriptBin "rofitheme" (builtins.readFile ./rofitheme.sh))
        (pkgs.writeScriptBin "screenshot" (builtins.readFile ./screenshot.sh))
        (pkgs.writeScriptBin "aurastatic" ''
          asusctl led-mode static -c $(cat ~/.config/colors/aura.txt)
        '')
      ];
  };
}
