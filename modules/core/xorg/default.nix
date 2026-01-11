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
    theme.font.mono.name = mkOption { type = types.str; default = "FantasqueSansM Nerd Font"; };
    theme.font.sans.name = mkOption { type = types.str; default = "Noto Sans"; };
    theme.font.serif.name = mkOption { type = types.str; default = "Noto Serif"; };
    theme.qt.name = mkOption { type = types.str; default = "catppuccin-mocha-blue"; };
    theme.qt.pkg = mkOption { type = types.package; default = pkgs.catppuccin-qt5ct; };
  };

  config = {
    environment.variables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    environment.systemPackages = [
      pkgs.kdePackages.qt6ct
      config.theme.gtk.pkg config.theme.cursor.pkg config.theme.icon.pkg config.theme.qt.pkg
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
      XCURSOR_THEME = config.theme.cursor.name;
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
        cursorTheme = {
          name = config.theme.cursor.name;
        };
        iconTheme = {
          name = config.theme.icon.name;
        };
        theme = {
          name = config.theme.gtk.name;
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "qt6ct";
        qt6ctSettings = {
          Appearance = {
            color_scheme_path= "${config.theme.qt.pkg}/share/qt5ct/colors/${config.theme.qt.name}.conf";
            custom_palette = true;
            icon_theme = config.theme.icon.name;
            standard_dialogs = "xdgdesktopportal";
            style = "Fusion";
          };
          Fonts = {
            fixed = config.theme.font.mono.name;
            general = config.theme.font.sans.name;
          };
        };
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
