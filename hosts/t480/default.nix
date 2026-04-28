# Lenovo Thinkpad T480

{ inputs, self, ... }: {
  flake.nixosConfigurations."t480" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      username = "astrogoat";
      hostname = "t480";
      resolution = "1920x1080";
    };

    modules = [ self.nixosModules.hostT480 ];
  };

  flake.nixosModules.hostT480 = { lib, pkgs, username, ... }: {
    imports = (with inputs; [
      nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
      nixos-hardware.nixosModules.lenovo-thinkpad-t480
      disko.nixosModules.disko
    ]) ++ [ self.diskoConfigurations.hostT480 ] ++ (with self.nixosModules; [
      # bare bones
      common secrets

      # user
      astrogoat

      # apps
      emacs
      filezilla
      finances
      firefox librewolf
      games
      impactor
      libreoffice
      localsend
      mpd
      mpv
      optical
      thunar
      thunderbird
      typst
      uxplay
      virtualisation
      zathura

      code

      # core
      cups

      # display manager
      regreet

      # hardware
      nvidia steelseries

      # window manager
      gnome hyprland
    ]);

    system.stateVersion = "25.11";

    boot.loader.efi.canTouchEfiVariables = true;
    boot.extraModprobeConfig = ''
      options psmouse synaptics_intertouch=1
    '';

    environment.systemPackages = with pkgs; [ pcsc-tools ];
    services.pcscd.enable = true;

    services."06cb-009a-fingerprint-sensor" = {
      enable = true;
      backend = "python-validity";
    };

    security.pam.services = lib.genAttrs
      [ "greetd" ]
      (name: { fprintAuth = lib.mkDefault true; });

    sops.secrets = {
      "hosts/t480/komga_api".owner = username;
      "hosts/t480/private_key" = {
        path = "/home/${username}/.ssh/id_ed25519";
        owner = username;
        mode = "600";
      };
      "hosts/t480/public_key" = {
        path = "/home/${username}/.ssh/id_ed25519.pub";
        owner = username;
        mode = "644";
      };
    };
  };
}
