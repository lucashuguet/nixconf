{ zathura, system, username, ... }:
let
  zathura-pkgs = zathura.legacyPackages.${system};
in
{
  home-manager.users.${username} = {
    # zathura 5.2 (fix cbz being cropped)
    home.packages = with zathura-pkgs; [ zathura ];
    home.file = {
      ".config/zathura/zathurarc".text = ''
        set selection-clipboard clipboard
        map <C-i> recolor
      '';
    };
  };
}
