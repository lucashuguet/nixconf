{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      (mpv.override {
        mpv = mpv-unwrapped.override {
          cddaSupport = true;
        };
      })
    ];
    home.file = {
      ".config/mpv" = {
        source = ./config;
        recursive = true;
      };
    };
  };
}
