{
  flake.nixosModules.rofi = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [ rofi ];

    home-manager.users.${username} = {
      home.file = {
        ".config/rofi/config.rasi".source = ./config.rasi;
        ".config/rofi/theme.rasi".source = ./theme.rasi;
      };
    };
  };
}
