{
  flake.nixosModules.alacritty = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [ unstable.alacritty ];

    home-manager.users.${username} = {
      home.file = {
        ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
      };
    };
  };
}
