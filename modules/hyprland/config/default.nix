{ pkgs, username, ... }:
{
  programs.hyprland.enable = true;
  programs.light.enable = true;
  home-manager.users.${username} = {
    home.file = {
      ".config/hypr/hyprland.conf".source = ./hyprland.conf;
    };

    home.packages = with pkgs; [
      swww
      grim slurp
      wl-clipboard
      wlr-randr
    ];
  };
}
