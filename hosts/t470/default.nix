# Lenovo Thinkpad T470

{ inputs, self, ... }: {
  flake.nixosConfigurations."t470" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      username = "astrogoat";
      hostname = "t470";
      resolution = "preferred";
      nvidia = false;
      extraHyprConfig = "";
      stateVersion = "25.05";
    };

    modules = [ self.nixosModules.hostT470 ];
  };

  flake.nixosModules.hostT470 = { username, ... }: {
    imports = [ inputs.disko.nixosModules.disko ] ++ [ self.diskoConfigurations.hostT470 ] ++ (with self.nixosModules; [
      # bare bones
      common secrets

      # apps
      emacs code typst
      filezilla localsend
      finances
      firefox librewolf
      games
      impactor uxplay
      libreoffice thunar thunderbird zathura
      mpd mpv
      optical virtualisation

      # core
      cups

      # display manager
      regreet

      # window manager
      gnome hyprland
    ]);

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
