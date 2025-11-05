{ pkgs, lib, config, username, ... }:
let
  hyprConfig = builtins.readFile ./hyprland.conf;
in {
  imports = [
    ./bpytop
    ./dunst
    ./hyprlock
    ./rofi
    ./waybar
  ];

  options.programs.hyprland = {
    monitor-resolution = lib.mkOption {
      type = lib.types.str;
      default = "preferred";
      description = "Hyprland monitor resolution";
    };
  };

  config = {
    programs.hyprland = {
      enable = true;
      withUWSM = false;
    };

    programs.light.enable = true;
    users.users.${username}.extraGroups = [ "video" ];

    home-manager.users.${username} = {
      home.file = {
        ".config/hypr/hyprland.conf".text = ''
        monitor = ,${config.programs.hyprland.monitor-resolution},0x0,1

        ${hyprConfig}
        '';
      };

      home.packages = with pkgs; [
        swww
        hyprshot
        wl-clipboard
        wlr-randr
      ];
    };
  };
}
