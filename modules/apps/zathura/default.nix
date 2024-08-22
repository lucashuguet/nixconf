{ system, nixpkgs-zathura, username, ... }:
let
  zathura = nixpkgs-zathura.legacyPackages.${system}.zathura;
in
{
  home-manager.users.${username} = {
    home.packages = [ zathura ];
    home.file = {
      ".config/zathura/zathurarc".text = ''
        set selection-clipboard clipboard
        map <C-i> recolor
      '';
    };
  };
}
