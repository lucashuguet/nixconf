# Asus ROG Stix G15 G512LV

{ inputs, self, ... }: {
  flake.nixosConfigurations."rog" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      username = "astrogoat";
      hostname = "rog";
      resolution = "1920x1080@60";
    };

    modules = [ self.nixosModules.hostRog ];
  };

  flake.nixosModules.hostRog = { pkgs, ... }: {
    imports = (with inputs; [ disko.nixosModules.disko ]) ++ [ self.diskoConfigurations.hostRog ] ++ (with self.nixosModules; [
      # bare bones
      common secrets

      # user
      astrogoat

      # apps
      emacs
      filezilla
      finances
      firefox librewolf qutebrowser
      games
      mpd
      typst
      virtualisation

      # hardware
      nvidia

      # core
      cups

      # display manager
      regreet

      # window manager
      hyprland gnome
    ]);

    system.stateVersion = "24.05";

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
