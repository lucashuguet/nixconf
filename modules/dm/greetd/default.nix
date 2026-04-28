{
  flake.nixosModules.regreet = { config, ... }: {
    programs.regreet = {
      enable = true;
      cageArgs  = [ "-s" "-d" ];
      settings = {
        background.path = ../../../assets/background.png;
      };
    };
  };
}
