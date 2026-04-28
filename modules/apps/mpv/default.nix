{
  flake.nixosModules.mpv = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      (mpv.override {
        mpv = mpv-unwrapped.override {
          cddaSupport = true;
        };
      })
    ];
  };

  flake.homeModules.mpv = {
    home.file = {
      ".config/mpv" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
