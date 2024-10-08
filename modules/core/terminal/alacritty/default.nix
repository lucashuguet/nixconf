{ unstable, username, ... }:
{
  environment.systemPackages = with unstable; [ alacritty ];

  home-manager.users.${username} = _: {
    home.file = {
      ".config/alacritty/alacritty.toml".source = ./alacritty.toml;
    };
  };
}
