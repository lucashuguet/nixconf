{ config, lib, pkgs, ... }:

{
  options.programs.python = {
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.python3;
      description = "python package";
    };

    extraPackages = lib.mkOption {
      type = lib.types.functionTo (lib.types.listOf lib.types.package);
      default = ps: [ ];
      description = "additionnal python packages";
    };
  };

  config = {
    programs.python.package = pkgs.python3.withPackages (ps:
      (with ps; [ numpy matplotlib requests beautifulsoup4 python-lsp-server ])
      ++ config.programs.python.extraPackages ps
    );

    environment.systemPackages = with pkgs; [
      virtualenv
      config.programs.python.package
    ];
  };
}
