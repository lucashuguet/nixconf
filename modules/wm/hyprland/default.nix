{ pkgs, username, ... }:
{
  imports = [
    ./bpytop
    ./dunst
    ./rofi
    ./waybar
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = false;
  };

  programs.light.enable = true;
  users.users.${username}.extraGroups = [ "video" ];

  home-manager.users.${username} = {
    home.file = {
      ".config/hypr/hyprland.conf".source = ./hyprland.conf;
    };

    home.packages = with pkgs; [
      swww
      hyprshot
      wl-clipboard
      wlr-randr
    ];
  };
}
