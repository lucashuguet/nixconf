{ pkgs, dwm, system, username, ... }:
{
  imports = [ ./picom ../../core/terminal/st ];

  environment.systemPackages = with pkgs; [ feh xdotool ];
  services.xserver.windowManager.dwm = {
    enable = true;
    package = dwm.packages.${system}.default;
  };

  home-manager.users.${username} = {
    home.file = {
      ".config/dwm/autostart.sh".source = ./autostart.sh;
    };
  };
}
