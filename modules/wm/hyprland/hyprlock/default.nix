{
  flake.nixosModules.hyprlock = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [ hyprlock ];

    home-manager.users.${username} = {
      home.file = {
        ".config/hypr/hyprlock.conf".source = ./hyprlock.conf;
      };
    };
  };
}
