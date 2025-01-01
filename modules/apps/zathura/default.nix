{ unstable, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with unstable; [ zathura ];
    home.file = {
      ".config/zathura/zathurarc".text = ''
        set selection-clipboard clipboard
        map <C-i> recolor
      '';
    };
  };
}
