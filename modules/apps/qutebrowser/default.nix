{
  flake.nixosModules.qutebrowser = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [ qutebrowser ];

    home-manager.users.${username} = {
      home.file = {
        ".config/qutebrowser/config.py".source = ./config.py;
      };
    };
  };
}
