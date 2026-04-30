# Lenovo IdeaPad Gaming 3 15HU6

{ inputs, self, ... }: {
  flake.nixosConfigurations."natnix" = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = {
      username = "natminer";
      hostname = "natnix";
      resolution = "preferred";
      nvidia = true;
      extraHyprConfig = "";
      stateVersion = "24.05";
    };

    modules = [ self.nixosModules.hostNatNix ];
  };

  flake.nixosModules.hostNatNix = { ... }: {
    imports = with self.nixosModules; [
      # bare bones
      common secrets

      # apps
      docker

      # display manager
      regreet

      # window manager
      gnome
    ];

    # fix time with windows dual boot
    time.hardwareClockInLocalTime = true;
  };
}
