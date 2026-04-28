{
  flake.nixosModules.waybar = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [ waybar ];

    home-manager.users.${username} = {
      home.file = {
        ".config/waybar/config".source = ./config.json;
        ".config/waybar/style.css".source = ./style.css;
      };
    };
  };
}
