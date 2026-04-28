{ inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.emacs = inputs.wrappers.lib.evalPackage [
      ../../../pkgs/emacs { inherit pkgs; }
    ];
  };

  flake.nixosModules.emacs = { pkgs, username, ... }: {
    environment.systemPackages = [
      pkgs.ripgrep
      (inputs.wrappers.lib.evalPackage [
        ../../../pkgs/emacs { inherit pkgs; }
      ])
    ];

    home-manager.users.${username} = {
      services.emacs = {
        enable = true;
        package = inputs.wrappers.lib.evalPackage [
          ../../../pkgs/emacs { inherit pkgs; }
        ];
      };
    };
  };
}
