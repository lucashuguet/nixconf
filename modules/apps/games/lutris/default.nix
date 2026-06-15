{
  flake.nixosModules.lutris = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      lutris mangohud
      wineWow64Packages.stable wineWow64Packages.waylandFull winetricks
    ];

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
