# Lenovo Thinkpad T470

{ inputs, self, ... }: {
  flake.nixosConfigurations."t470" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      username = "astrogoat";
      hostname = "t470";
      resolution = "auto";
    };

    modules = [ self.nixosModules.hostT470 ];
  };

  flake.nixosModules.hostT470 = { username, ... }: {
    imports = [ inputs.disko.nixosModules.disko ] ++ [ self.diskoConfigurations.hostT470 ] ++ (with self.nixosModules; [
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

    system.stateVersion = "25.05";

    boot.loader.efi.canTouchEfiVariables = true;

    sops.secrets = {
      "hosts/t470/komga_api".owner = username;
      "hosts/t470/private_key" = {
        path = "/home/${username}/.ssh/id_ed25519";
        owner = username;
        mode = "600";
      };
      "hosts/t470/public_key" = {
        path = "/home/${username}/.ssh/id_ed25519.pub";
        owner = username;
        mode = "644";
      };
    };
  };
}
