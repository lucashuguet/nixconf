# Asus ROG Stix G15 G512LV

{ inputs, self, ... }: {
  flake.nixosConfigurations."rog" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      username = "astrogoat";
      hostname = "rog";
      resolution = "1920x1080@60";
      nvidia = true;
      extraHyprConfig = ''
        exec-once = aurastatic

        bind = , XF86KbdBrightnessDown, exec, asusctl -p
        bind = , XF86KbdBrightnessUp, exec, asusctl -n
        bind = , XF86Launch2, exec, asusctl aura rainbow-wave
        bind = , XF86Launch3, exec, aurastatic
      '';
      stateVersion = "24.05";
    };

    modules = [ self.nixosModules.hostRog ];
  };

  flake.nixosModules.hostRog = { pkgs, ... }: {
    imports = (with inputs; [ disko.nixosModules.disko ]) ++ [ self.diskoConfigurations.hostRog ] ++ (with self.nixosModules; [
      # bare bones
      common secrets

      # apps
      emacs
      filezilla
      finances
      firefox librewolf qutebrowser
      games
      mpd
      typst
      virtualisation

      # core
      cups

      # display manager
      regreet

      # window manager
      hyprland gnome
    ]);

    # broken screen on 144hz
    boot.kernelParams = [ "video=1920x1080@60" ];
    # programs.hyprland.monitor-resolution = "1920x1080@60";
    services.xserver.displayManager.setupCommands = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --rate 60
    '';

    # fix sound
    boot.extraModprobeConfig = ''
      blacklist snd_hda_codec_realtek
    '';

    # asus services
    services.asusd.enable = true;
  };
}
