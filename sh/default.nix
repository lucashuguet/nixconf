{ pkgs, username, ... }:
{
  imports = [ ../modules/wm/hyprland/rofi ../modules/apps/browsers/surf ];
  home-manager.users.${username} = {
    home.packages =
      (with pkgs; [ fzf pywal ])
      ++
      [
        (pkgs.writeScriptBin "audiosetup" (builtins.readFile ./audiosetup.sh))
        (pkgs.writeScriptBin "createcbz" (builtins.readFile ./createcbz.py))
        (pkgs.writeScriptBin "epub2cbz" (builtins.readFile ./epub2cbz.sh))
        (pkgs.writeScriptBin "gamemode" (builtins.readFile ./gamemode.sh))
        (pkgs.writeScriptBin "gs" (builtins.readFile ./gs.sh))
	(pkgs.writeScriptBin "roficompose" (builtins.readFile ./roficompose.py))
        (pkgs.writeScriptBin "rofidrives" (builtins.readFile ./rofidrives.py))
        (pkgs.writeScriptBin "rofinmcli" (builtins.readFile ./rofinmcli.py))
        (pkgs.writeScriptBin "rofipass" (builtins.readFile ./rofipass.sh))
        (pkgs.writeScriptBin "rofishutdown" (builtins.readFile ./rofishutdown.py))
        (pkgs.writeScriptBin "rofisink" (builtins.readFile ./rofisink.py))
        (pkgs.writeScriptBin "rofisurf" (builtins.readFile ./rofisurf.py))
        (pkgs.writeScriptBin "rofitheme" (builtins.readFile ./rofitheme.sh))
        (pkgs.writeScriptBin "aurastatic" ''
          asusctl led-mode static -c $(cat ~/.config/colors/aura.txt)
        '')
      ];
  };
}
