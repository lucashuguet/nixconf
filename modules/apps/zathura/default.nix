{
  flake.nixosModules.zathura = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [ unstable.zathura ];

    home-manager.users.${username} = {
      home.file = {
        ".config/zathura/zathurarc".text = ''
          set selection-clipboard clipboard
          map <C-i> recolor
        '';
      };
    };
  };
}
