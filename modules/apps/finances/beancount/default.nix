{
  flake.nixosModules.beancount = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      beancount fava jdk21
      (pkgs.python3.withPackages (ps: with ps; [
        beangulp camelot tabula-py
      ]))
    ];
  };
}
