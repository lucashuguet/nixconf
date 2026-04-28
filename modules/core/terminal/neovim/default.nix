{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.neovim = inputs.wrappers.lib.evalPackage [
      ../../../../pkgs/neovim { inherit pkgs; }
    ];
  };

  flake.nixosModules.neovim = { pkgs, ... }: {
    environment.systemPackages = [
      (inputs.wrappers.lib.evalPackage [
        ../../../../pkgs/neovim { inherit pkgs; }
      ])
    ];
    environment.variables.EDITOR = "nvim";
  };
}
