{
  flake.nixosModules.regreet = { config, username, ... }: {
    services.greetd = {
      enable = true;
      settings.initial_session = {
        command = "Hyprland > /dev/null 2>&1";
        user = username;
      };
    };

    programs.regreet = {
      enable = true;
      cageArgs  = [ "-s" "-d" ];
      settings = {
        background.path = ../../../assets/background.png;
      };
    };
  };
}
