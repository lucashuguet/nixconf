{
  flake.nixosModules.fastfetch = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [ fastfetch ];

    home-manager.users.${username} = {
      home.file = {
        ".config/fastfetch/config.jsonc".text = ''
          {
            "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
            "logo": {
              "source": "${./logo.txt}",
            },
            "modules": [
              "title",
              "separator",
              "os",
              "host",
              "packages",
              "de",
              "wm",
              "terminal",
              "cpu",
              "gpu",
              "memory",
              "break",
              "colors"
            ]
          }
        '';
      };
    };
  };
}
