{ config, lib, pkgs, username, ... }:
let
  gtk4 = "${config.theme.gtk.pkg}/share/themes/${config.theme.gtk.name}/gtk-4.0";
in
{
  options = with lib; {
    theme.gtk.name = mkOption { type = types.str; default = "catppuccin-mocha-blue-standard+rimless,black"; };
    theme.gtk.pkg  = mkOption { type = types.package; default = pkgs.catppuccin-gtk.override {
      accents = [ "blue" ];
      size = "standard";
      tweaks = [ "rimless" "black" ];
      variant = "mocha";
    }; };
    theme.cursor.name = mkOption { type = types.str; default = "capitaine-cursors"; };
    theme.cursor.pkg = mkOption { type = types.package; default = pkgs.capitaine-cursors; };
    theme.icon.name = mkOption { type = types.str; default = "Tela-blue-dark"; };
    theme.icon.pkg = mkOption { type = types.package; default = pkgs.tela-icon-theme; };
    theme.font.name = mkOption { type = types.str; default = "FantasqueSansM Nerd Font"; };
  };

  config = {
    environment.systemPackages = [
      config.theme.gtk.pkg config.theme.cursor.pkg config.theme.icon.pkg
    ];

    services.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    services.xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];

      displayManager.startx.enable = true;
    };

    environment.variables = {
      XCURSOR_SIZE = "32";
    };

    home-manager.users.${username} = {
      home.packages = with pkgs; [
        sxiv libnotify

        # wayland specific
        imv wl-clipboard wlr-randr
      ];

      home.pointerCursor = {
        x11 = {
          defaultCursor = "left_ptr";
          enable = true;
        };
        gtk.enable = true;
        name = config.theme.cursor.name;
        package = config.theme.cursor.pkg;
      };

      gtk = {
        enable = true;
        theme = {
          name = config.theme.gtk.name;
          package = config.theme.gtk.pkg;
        };
        iconTheme = {
          name = config.theme.icon.name;
          package = config.theme.icon.pkg;
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "gtk";
      };

      xdg.configFile = {
        "gtk-4.0/assets".source = "${gtk4}/assets";
        "gtk-4.0/gtk.css".source = "${gtk4}/gtk.css";
        "gtk-4.0/gtk-dark.css".source = "${gtk4}/gtk-dark.css";
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
    };
  };
}
