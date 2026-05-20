{
  flake.nixosModules.mpv = { pkgs, username, ... }: {
    environment.systemPackages = with pkgs; [
      (mpv.override {
        mpv = mpv-unwrapped.override {
          cddaSupport = true;
        };
      })
    ];

    home-manager.users.${username} = {
      home.file = {
        ".config/mpv" = {
          source = ./config;
          recursive = true;
        };
      };
    };
  };
}
