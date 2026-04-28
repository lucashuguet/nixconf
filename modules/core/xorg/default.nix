{ self, ... }: {
  flake.nixosModules.xorg = { pkgs, username, ... }: {
    imports = [ self.nixosModules.stylix ];

    environment.variables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    environment.systemPackages = (with pkgs; [
      kdePackages.qt6ct
      sxiv libnotify

      # wayland specific
      imv wl-clipboard wlr-randr
    ]);

    services.libinput = {
      enable = true;
      touchpad.naturalScrolling = true;
    };

    services.xserver = {
      enable = true;
      excludePackages = [ pkgs.xterm ];

      displayManager.startx.enable = true;
    };

    home-manager.users.${username} = {
      imports = [ self.homeModules.stylix ];

      gtk = {
        enable = true;
        iconTheme = {
          package = pkgs.tela-icon-theme;
          name = "Tela-blue-dark";
        };
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
