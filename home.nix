{ config, pkgs, ... }:

{
  home.username = "astrogoat";
  home.homeDirectory = "/home/astrogoat";
  home.stateVersion = "24.05";
  home.packages = [
    (pkgs.writeScriptBin "rofisink" (builtins.readFile ./scripts/rofisink.py))
    (pkgs.writeScriptBin "rofidrives" (builtins.readFile ./scripts/rofidrives.py))
    (pkgs.writeScriptBin "rofinmcli" (builtins.readFile ./scripts/rofinmcli.py))
    (pkgs.writeScriptBin "rofitheme" (builtins.readFile ./scripts/rofitheme.sh))
    (pkgs.writeScriptBin "screenshot" (builtins.readFile ./scripts/screenshot.sh))
    (pkgs.writeScriptBin "aurastatic" ''
      asusctl led-mode static -c $(cat ~/.config/colors/aura.txt)
    '')
  ];

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "rimless" "black" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-blue-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  home.file = {
    ".config/alacritty/alacritty.toml".source = ./dotfiles/alacritty.toml;
    ".config/hypr/hyprland.conf".source = ./dotfiles/hyprland.conf;
    ".config/starship.toml".source = ./dotfiles/starship.toml;

    ".config/mpv" = {
      source = ./dotfiles/mpv;
      recursive = true;
    };

    ".config/zathura/zathurarc".text = ''
      set selection-clipboard clipboard
      map <C-i> recolor
    '';

    ".config/waybar/config".source = ./dotfiles/waybar.json;
    ".config/waybar/style.css".source = ./dotfiles/waybar.css;
    
    ".config/fish/config.fish".source = ./dotfiles/config.fish;
    ".config/mpd/mpd.conf".source = ./dotfiles/mpd.conf;
    ".config/rofi/config.rasi".source = ./dotfiles/rofi.rasi;
    ".config/rofi/theme.rasi".source = ./dotfiles/rofi_theme.rasi;
    ".config/qutebrowser/config.py".source = ./dotfiles/qutebrowser.py;
    ".config/dunst/config.toml".source = ./dotfiles/dunst.toml;
  };

   xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/xhtml+xml" = "librewolf.desktop";
      "text/html" = "librewolf.desktop";
      "text/xml" = "librewolf.desktop";
      "x-scheme-handler/ftp" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";

      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      "application/vnd.comicbook+zip" = "org.pwmt.zathura-cb.desktop";

      "image/gif" = "sxiv.desktop";
      "image/jpeg" = "imv.desktop";
      "image/png" = "imv.desktop";
    };
  };

  programs.home-manager.enable = true;
}
