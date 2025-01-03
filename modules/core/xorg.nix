{ pkgs, username, ... }:
let
  gtkThemeName = "catppuccin-mocha-blue-standard+rimless,black";
  gtkThemePkg = pkgs.catppuccin-gtk.override {
    accents = [ "blue" ];
    size = "standard";
    tweaks = [ "rimless" "black" ];
    variant = "mocha";
  };
  gtk4 = "${gtkThemePkg}/share/themes/${gtkThemeName}/gtk-4.0";
in
{
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
      pcmanfm sxiv libnotify

      # wayland specific
      imv wl-clipboard wlr-randr
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
        name = gtkThemeName;
        package = gtkThemePkg;
      };
      iconTheme = {
        package = pkgs.tela-icon-theme;
        name = "Tela-blue-dark";
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
}
