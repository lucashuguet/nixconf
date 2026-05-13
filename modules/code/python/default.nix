{
  flake.nixosModules.pythonLang = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      virtualenv
      (pkgs.python3.withPackages (ps: with ps; [
        beautifulsoup4 matplotlib numpy python-lsp-server requests scipy
      ]))
    ];
  };
}
