{
  flake.nixosModules.brasero = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      brasero dvdplusrwtools
    ];
  };
}
