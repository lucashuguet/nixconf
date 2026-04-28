{
  flake.nixosModules.dunst = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [ dunst ];

    home-manager.users.${username} = {
      home.file = {
        ".config/dunst/config.toml".source = ./config.toml;
      };
    };
  };
}
