{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ unstable.zathura ];
    home.file = {
      ".config/zathura/zathurarc".text = ''
        set selection-clipboard clipboard
        map <C-i> recolor
      '';
    };
  };
}
