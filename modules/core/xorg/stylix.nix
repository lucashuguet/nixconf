{ inputs, ... }: let
  stylixConfiguration = { pkgs, ... }: {
    stylix = {
      enable = true;
      # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      base16Scheme = ./catppucin-custom.yaml;
      polarity = "dark";
      autoEnable = false;
      cursor = {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
        size = 32;
      };

      fonts = {
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };

        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };

        monospace = {
          package = pkgs.unstable.nerd-fonts.fantasque-sans-mono;
          name = "FantasqueSansM Nerd Font";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };

      targets.gtk.enable = true;
    };
  };
in {
  flake.nixosModules.stylix = { ... }: {
    imports = [
      inputs.stylix.nixosModules.stylix stylixConfiguration
    ];

    stylix.targets = {
      regreet.enable = true;
    };
  };

  flake.homeModules.stylix = { ... }: {
    imports = [ stylixConfiguration ];

    stylix.targets.qt.enable = true;
  };
}
